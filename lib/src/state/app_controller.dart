import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/models.dart' as core;
import '../core/tournament_engine.dart';
import '../data/local/app_database.dart' as db;
import '../data/repositories/player_repository.dart';
import '../data/repositories/tournament_repository.dart';

class NewPlayerInput {
  const NewPlayerInput({required this.name, required this.role});

  final String name;
  final core.PlayerRole role;
}

class AppController extends ChangeNotifier {
  AppController._({
    required this.engine,
    this.database,
    this.playerRepository,
    this.tournamentRepository,
    this.watchPool = true,
  }) {
    if (watchPool && playerRepository != null) {
      _playersSub = playerRepository!.watchPoolPlayers().listen((items) {
        players = items;
        notifyListeners();
      });
    }
  }

  factory AppController.live() {
    final database = db.AppDatabase();
    return AppController._(
      database: database,
      playerRepository: PlayerRepository(database),
      tournamentRepository: TournamentRepository(database),
      engine: TournamentEngine(),
      watchPool: true,
    );
  }

  factory AppController.test() {
    return AppController._(engine: TournamentEngine(), watchPool: false);
  }

  final db.AppDatabase? database;
  final PlayerRepository? playerRepository;
  final TournamentRepository? tournamentRepository;
  final TournamentEngine engine;
  final bool watchPool;

  StreamSubscription<List<core.Player>>? _playersSub;

  List<core.Player> players = [];
  core.TournamentPlan? currentPlan;
  int? activeTournamentId;
  String? activeTournamentName;
  bool isBusy = false;
  String? flashMessage;

  Future<void> addPlayer(String name, core.PlayerRole role) async {
    final repo = playerRepository;
    if (repo == null) return;

    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const core.TournamentGenerationException(
        'Le nom joueur est requis.',
      );
    }

    await repo.addPlayer(name: trimmed, role: role);
  }

  Future<void> updatePlayer({
    required int id,
    required String name,
    required core.PlayerRole role,
  }) async {
    final repo = playerRepository;
    if (repo == null) return;

    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const core.TournamentGenerationException(
        'Le nom joueur est requis.',
      );
    }

    await repo.updatePlayer(id: id, name: trimmed, role: role);
  }

  Future<void> deletePlayer(int id) async {
    final repo = playerRepository;
    if (repo == null) return;
    await repo.deleteOrDeactivate(id);
  }

  Future<void> createTournament({
    required String name,
    required int roundsCount,
    required core.TeamSizePreference preference,
    required List<int> selectedPlayerIds,
    List<NewPlayerInput> newPlayers = const [],
  }) async {
    final pRepo = playerRepository;
    final tRepo = tournamentRepository;
    if (pRepo == null || tRepo == null) return;

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw const core.TournamentGenerationException(
        'Le nom du tournoi est requis.',
      );
    }

    if (roundsCount < 4 || roundsCount > 5) {
      throw const core.TournamentGenerationException(
        'Le nombre de tours doit être 4 ou 5.',
      );
    }

    _validateDraftPlayerDuplicates(newPlayers);

    isBusy = true;
    flashMessage = null;
    notifyListeners();

    try {
      final extraIds = <int>[];
      for (final entry in newPlayers) {
        final trimmed = entry.name.trim();
        if (trimmed.isEmpty) continue;
        final id = await pRepo.addPlayer(
          name: trimmed,
          role: entry.role,
          activePool: true,
        );
        extraIds.add(id);
      }

      final participantIds = <int>{...selectedPlayerIds, ...extraIds}.toList();

      if (participantIds.length < 4) {
        throw const core.TournamentGenerationException(
          'Il faut au minimum 4 joueurs pour créer un tournoi.',
        );
      }

      final participants = await pRepo.getPlayersByIds(participantIds);
      final plan = engine.generateTournamentPlan(
        players: participants,
        roundsCount: roundsCount,
        preference: preference,
      );

      final tournamentId = await tRepo.createTournamentWithPlan(
        name: trimmedName,
        date: DateTime.now(),
        roundsCount: roundsCount,
        preferredTeamSize: preference == core.TeamSizePreference.prefer2
            ? 2
            : 3,
        participants: participants,
        plan: plan,
      );

      activeTournamentId = tournamentId;
      activeTournamentName = trimmedName;
      currentPlan = plan;
      flashMessage =
          'Tournoi "$trimmedName" créé (${participants.length} joueurs).';
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  void _validateDraftPlayerDuplicates(List<NewPlayerInput> newPlayers) {
    final seen = <String>{};
    for (final entry in newPlayers) {
      final trimmed = entry.name.trim();
      if (trimmed.isEmpty) continue;
      final key = trimmed.toLowerCase();
      if (!seen.add(key)) {
        throw core.TournamentGenerationException(
          'Le joueur "$trimmed" est saisi plusieurs fois. Change le nom.',
        );
      }
    }
  }

  String consumeFlashMessage() {
    final msg = flashMessage;
    flashMessage = null;
    return msg ?? '';
  }

  @override
  void dispose() {
    _playersSub?.cancel();
    database?.close();
    super.dispose();
  }
}
