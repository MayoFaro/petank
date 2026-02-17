import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get role => integer().withDefault(const Constant(1))();
  BoolColumn get activePool => boolean().withDefault(const Constant(true))();
}

class Tournaments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get nbTours => integer()();
  IntColumn get preferredTeamSize => integer()(); // 2 or 3
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TournamentPlayers extends Table {
  IntColumn get tournamentId => integer().references(Tournaments, #id)();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get joinedRound => integer().withDefault(const Constant(1))();
  IntColumn get leftRound => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {tournamentId, playerId};
}

class RoundPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tournamentId => integer().references(Tournaments, #id)();
  IntColumn get roundIndex => integer()();
  TextColumn get status => text().withDefault(const Constant('PLANNED'))();
}

class TeamPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get roundId => integer().references(RoundPlans, #id)();
  IntColumn get teamIndex => integer()();
  IntColumn get teamSize => integer()();
}

class TeamMemberPlans extends Table {
  IntColumn get teamId => integer().references(TeamPlans, #id)();
  IntColumn get playerId => integer().references(Players, #id)();

  @override
  Set<Column<Object>> get primaryKey => {teamId, playerId};
}

class MatchPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get roundId => integer().references(RoundPlans, #id)();
  IntColumn get matchIndex => integer()();
  IntColumn get teamAId => integer().references(TeamPlans, #id)();
  IntColumn get teamBId => integer().references(TeamPlans, #id)();
  IntColumn get scoreA => integer().nullable()();
  IntColumn get scoreB => integer().nullable()();
}

@DriftDatabase(
  tables: [
    Players,
    Tournaments,
    TournamentPlayers,
    RoundPlans,
    TeamPlans,
    TeamMemberPlans,
    MatchPlans,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      throw UnsupportedError('Web non supporte pour cette app offline SQLite.');
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'petank.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
