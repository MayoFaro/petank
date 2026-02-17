import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/models.dart' as core;
import '../core/round_live_ops.dart';
import '../core/tournament_engine.dart';
import '../data/local/app_database.dart' as db;
import '../data/repositories/player_repository.dart';
import '../data/repositories/tournament_repository.dart';

enum FutureImpactChangeType { add, remove, replace }

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
  List<core.Player> currentParticipants = [];
  core.TournamentPlan? currentPlan;
  int? activeTournamentId;
  String? activeTournamentName;
  int activeRoundIndex = 0;
  bool isBusy = false;
  String? flashMessage;

  core.RoundPlanModel? get activeRound {
    final plan = currentPlan;
    if (plan == null || plan.rounds.isEmpty) return null;
    if (activeRoundIndex < 0 || activeRoundIndex >= plan.rounds.length) {
      return plan.rounds.first;
    }
    return plan.rounds[activeRoundIndex];
  }

  List<core.RankingEntry> get ranking {
    final plan = currentPlan;
    if (plan == null || currentParticipants.isEmpty) {
      return const [];
    }
    return engine.computeRanking(players: currentParticipants, plan: plan);
  }

  List<core.Player> get availableBenchForActiveRound {
    final round = activeRound;
    if (round == null) return const [];

    final inRound = <int>{
      for (final team in round.teams)
        for (final p in team.players) p.id,
    };

    return players.where((p) => !inRound.contains(p.id)).toList();
  }

  void setActiveRoundIndex(int index) {
    final plan = currentPlan;
    if (plan == null) return;
    if (index < 0 || index >= plan.rounds.length) return;
    activeRoundIndex = index;
    notifyListeners();
  }

  Future<void> saveMatchScore({
    required int matchIndex,
    required int scoreA,
    required int scoreB,
  }) async {
    final round = activeRound;
    final plan = currentPlan;
    if (round == null || plan == null) return;

    final validationError = validatePetanqueScore(
      scoreA: scoreA,
      scoreB: scoreB,
    );
    if (validationError != null) {
      throw core.TournamentGenerationException(validationError);
    }

    final match = round.matches.firstWhere((m) => m.matchIndex == matchIndex);
    match.scoreA = scoreA;
    match.scoreB = scoreB;

    final tRepo = tournamentRepository;
    final tournamentId = activeTournamentId;
    if (tRepo != null && tournamentId != null) {
      await tRepo.saveMatchScore(
        tournamentId: tournamentId,
        roundIndex: round.roundIndex,
        matchIndex: matchIndex,
        scoreA: scoreA,
        scoreB: scoreB,
      );
    }

    notifyListeners();
  }

  String? validatePetanqueScore({required int scoreA, required int scoreB}) {
    if (scoreA < 0 || scoreB < 0) {
      return 'Les scores doivent être positifs.';
    }

    final aWins = scoreA >= 13 && scoreA <= 18 && scoreB >= 0 && scoreB <= 12;
    final bWins = scoreB >= 13 && scoreB <= 18 && scoreA >= 0 && scoreA <= 12;
    if (!aWins && !bWins) {
      return 'Score pétanque invalide: une seule équipe doit avoir entre 13 et 18, l\'autre entre 0 et 12.';
    }

    return null;
  }

  Future<core.Player> createPoolPlayer({
    required String name,
    required core.PlayerRole role,
  }) async {
    final pRepo = playerRepository;
    if (pRepo == null) {
      throw const core.TournamentGenerationException(
        'Repository joueurs indisponible.',
      );
    }

    final id = await pRepo.addPlayer(name: name, role: role, activePool: true);
    final created = await pRepo.getPlayersByIds([id]);
    return created.first;
  }

  bool addPlayerToActiveTeam({
    required int teamIndex,
    required core.Player player,
  }) {
    final round = activeRound;
    if (round == null) return false;

    final ok = RoundLiveOps.addPlayerToTeam(
      round: round,
      teamIndex: teamIndex,
      player: player,
    );
    if (ok) {
      if (currentParticipants.every((p) => p.id != player.id)) {
        currentParticipants = [...currentParticipants, player];
      }
      notifyListeners();
    }
    return ok;
  }

  bool removePlayerFromActiveTeam({
    required int teamIndex,
    required int playerId,
  }) {
    final round = activeRound;
    if (round == null) return false;

    final ok = RoundLiveOps.removePlayerFromTeam(
      round: round,
      teamIndex: teamIndex,
      playerId: playerId,
    );
    if (ok) {
      notifyListeners();
    }
    return ok;
  }

  bool replacePlayerInActiveTeam({
    required int teamIndex,
    required int outPlayerId,
    required core.Player inPlayer,
  }) {
    final round = activeRound;
    if (round == null) return false;

    final ok = RoundLiveOps.replacePlayer(
      round: round,
      teamIndex: teamIndex,
      outPlayerId: outPlayerId,
      inPlayer: inPlayer,
    );
    if (ok) {
      if (currentParticipants.every((p) => p.id != inPlayer.id)) {
        currentParticipants = [...currentParticipants, inPlayer];
      }
      notifyListeners();
    }
    return ok;
  }

  Future<void> applyChangeToFutureRounds({
    required FutureImpactChangeType type,
    int? outPlayerId,
    core.Player? inPlayer,
  }) async {
    final plan = currentPlan;
    final preference = plan?.preference;
    if (plan == null || preference == null) return;

    final startRoundIndex = activeRoundIndex + 1;
    if (startRoundIndex >= plan.roundsCount) {
      return;
    }

    var generationPlayers = [...currentParticipants];
    switch (type) {
      case FutureImpactChangeType.add:
        if (inPlayer != null &&
            generationPlayers.every((p) => p.id != inPlayer.id)) {
          generationPlayers = [...generationPlayers, inPlayer];
          if (currentParticipants.every((p) => p.id != inPlayer.id)) {
            currentParticipants = [...currentParticipants, inPlayer];
          }
        }
      case FutureImpactChangeType.remove:
        if (outPlayerId != null) {
          generationPlayers = generationPlayers
              .where((p) => p.id != outPlayerId)
              .toList();
        }
      case FutureImpactChangeType.replace:
        if (outPlayerId != null) {
          generationPlayers = generationPlayers
              .where((p) => p.id != outPlayerId)
              .toList();
        }
        if (inPlayer != null &&
            generationPlayers.every((p) => p.id != inPlayer.id)) {
          generationPlayers = [...generationPlayers, inPlayer];
          if (currentParticipants.every((p) => p.id != inPlayer.id)) {
            currentParticipants = [...currentParticipants, inPlayer];
          }
        }
    }

    final lockedRounds = plan.rounds
        .where((r) => r.roundIndex <= activeRoundIndex || _roundIsDone(r))
        .toList();

    List<core.RoundPlanModel> regenerated;
    try {
      regenerated = engine.regenerateFutureRounds(
        players: generationPlayers,
        preference: preference,
        totalRounds: plan.roundsCount,
        startRoundIndex: startRoundIndex,
        lockedRounds: lockedRounds,
        allowRelaxedConstraints: false,
      );
    } on core.TournamentGenerationException {
      regenerated = engine.regenerateFutureRounds(
        players: generationPlayers,
        preference: preference,
        totalRounds: plan.roundsCount,
        startRoundIndex: startRoundIndex,
        lockedRounds: lockedRounds,
        allowRelaxedConstraints: true,
      );
      flashMessage = 'Tours suivants régénérés en mode contraintes assouplies.';
    }

    final sortedLocked = [...lockedRounds]
      ..sort((a, b) => a.roundIndex.compareTo(b.roundIndex));
    final nextRounds = [...sortedLocked, ...regenerated]
      ..sort((a, b) => a.roundIndex.compareTo(b.roundIndex));

    currentPlan = core.TournamentPlan(
      roundsCount: plan.roundsCount,
      preference: plan.preference,
      teamTemplate: plan.teamTemplate,
      rounds: nextRounds,
    );

    final tRepo = tournamentRepository;
    final tournamentId = activeTournamentId;
    if (tRepo != null && tournamentId != null) {
      if (inPlayer != null) {
        await tRepo.upsertTournamentPlayer(
          tournamentId: tournamentId,
          playerId: inPlayer.id,
          joinedRound: activeRoundIndex + 1,
        );
      }
      if (outPlayerId != null) {
        await tRepo.markTournamentPlayerLeft(
          tournamentId: tournamentId,
          playerId: outPlayerId,
          leftRound: activeRoundIndex,
        );
      }

      await tRepo.replaceFutureRounds(
        tournamentId: tournamentId,
        startRoundIndex: startRoundIndex,
        rounds: regenerated,
      );
    }

    notifyListeners();
  }

  bool _roundIsDone(core.RoundPlanModel round) {
    return round.matches.every((m) => m.scoreA != null && m.scoreB != null);
  }

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
      currentParticipants = participants;
      currentPlan = plan;
      activeRoundIndex = 0;
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
