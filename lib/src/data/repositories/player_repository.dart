import 'package:drift/drift.dart';

import '../../core/models.dart' as core;
import '../local/app_database.dart' as db;

class PlayerRepository {
  PlayerRepository(this._database);

  final db.AppDatabase _database;

  Stream<List<core.Player>> watchPoolPlayers() {
    final query = (_database.select(_database.players)
      ..where((tbl) => tbl.activePool.equals(true))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)]));

    return query.watch().map((rows) => rows.map(_toCorePlayer).toList());
  }

  Future<int> addPlayer({
    required String name,
    required core.PlayerRole role,
    bool activePool = true,
  }) async {
    final normalized = _normalizeName(name);
    if (normalized.isEmpty) {
      throw const core.TournamentGenerationException(
        'Le nom joueur est requis.',
      );
    }

    final exists = await _nameExists(normalized);
    if (exists) {
      throw core.TournamentGenerationException(
        'Le joueur "$normalized" existe déjà. Choisis un autre nom.',
      );
    }

    return _database
        .into(_database.players)
        .insert(
          db.PlayersCompanion.insert(
            name: normalized,
            role: Value(role.value),
            activePool: Value(activePool),
          ),
        );
  }

  Future<void> updatePlayer({
    required int id,
    required String name,
    required core.PlayerRole role,
  }) async {
    final normalized = _normalizeName(name);
    if (normalized.isEmpty) {
      throw const core.TournamentGenerationException(
        'Le nom joueur est requis.',
      );
    }

    final exists = await _nameExists(normalized, excludingPlayerId: id);
    if (exists) {
      throw core.TournamentGenerationException(
        'Le joueur "$normalized" existe déjà. Choisis un autre nom.',
      );
    }

    await (_database.update(
      _database.players,
    )..where((t) => t.id.equals(id))).write(
      db.PlayersCompanion(name: Value(normalized), role: Value(role.value)),
    );
  }

  Future<void> updateRole({
    required int id,
    required core.PlayerRole role,
  }) async {
    await (_database.update(_database.players)..where((t) => t.id.equals(id)))
        .write(db.PlayersCompanion(role: Value(role.value)));
  }

  Future<void> deleteOrDeactivate(int playerId) async {
    try {
      await (_database.delete(
        _database.players,
      )..where((t) => t.id.equals(playerId))).go();
    } catch (_) {
      await (_database.update(_database.players)
            ..where((t) => t.id.equals(playerId)))
          .write(const db.PlayersCompanion(activePool: Value(false)));
    }
  }

  Future<List<core.Player>> getPlayersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    final rows = await (_database.select(
      _database.players,
    )..where((t) => t.id.isIn(ids))).get();

    final byId = {for (final row in rows) row.id: _toCorePlayer(row)};
    return ids.where(byId.containsKey).map((id) => byId[id]!).toList();
  }

  Future<bool> _nameExists(
    String normalizedName, {
    int? excludingPlayerId,
  }) async {
    final lower = normalizedName.toLowerCase();
    final rows = await (_database.select(
      _database.players,
    )..where((t) => t.activePool.equals(true))).get();

    return rows.any((row) {
      if (excludingPlayerId != null && row.id == excludingPlayerId) {
        return false;
      }
      return row.name.trim().toLowerCase() == lower;
    });
  }

  String _normalizeName(String name) => name.trim();

  core.Player _toCorePlayer(db.Player row) {
    return core.Player(
      id: row.id,
      name: row.name,
      role: switch (row.role) {
        1 => core.PlayerRole.beginner,
        2 => core.PlayerRole.pointer,
        3 => core.PlayerRole.shooter,
        _ => core.PlayerRole.beginner,
      },
      activePool: row.activePool,
    );
  }
}
