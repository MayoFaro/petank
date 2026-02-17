// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<int> role = GeneratedColumn<int>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _activePoolMeta = const VerificationMeta(
    'activePool',
  );
  @override
  late final GeneratedColumn<bool> activePool = GeneratedColumn<bool>(
    'active_pool',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active_pool" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, role, activePool];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('active_pool')) {
      context.handle(
        _activePoolMeta,
        activePool.isAcceptableOrUnknown(data['active_pool']!, _activePoolMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}role'],
      )!,
      activePool: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active_pool'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String name;
  final int role;
  final bool activePool;
  const Player({
    required this.id,
    required this.name,
    required this.role,
    required this.activePool,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<int>(role);
    map['active_pool'] = Variable<bool>(activePool);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      activePool: Value(activePool),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<int>(json['role']),
      activePool: serializer.fromJson<bool>(json['activePool']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<int>(role),
      'activePool': serializer.toJson<bool>(activePool),
    };
  }

  Player copyWith({int? id, String? name, int? role, bool? activePool}) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        activePool: activePool ?? this.activePool,
      );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      activePool: data.activePool.present
          ? data.activePool.value
          : this.activePool,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('activePool: $activePool')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, role, activePool);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.activePool == this.activePool);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> role;
  final Value<bool> activePool;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.activePool = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.role = const Value.absent(),
    this.activePool = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? role,
    Expression<bool>? activePool,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (activePool != null) 'active_pool': activePool,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? role,
    Value<bool>? activePool,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      activePool: activePool ?? this.activePool,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<int>(role.value);
    }
    if (activePool.present) {
      map['active_pool'] = Variable<bool>(activePool.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('activePool: $activePool')
          ..write(')'))
        .toString();
  }
}

class $TournamentsTable extends Tournaments
    with TableInfo<$TournamentsTable, Tournament> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nbToursMeta = const VerificationMeta(
    'nbTours',
  );
  @override
  late final GeneratedColumn<int> nbTours = GeneratedColumn<int>(
    'nb_tours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preferredTeamSizeMeta = const VerificationMeta(
    'preferredTeamSize',
  );
  @override
  late final GeneratedColumn<int> preferredTeamSize = GeneratedColumn<int>(
    'preferred_team_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    date,
    nbTours,
    preferredTeamSize,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournaments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tournament> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('nb_tours')) {
      context.handle(
        _nbToursMeta,
        nbTours.isAcceptableOrUnknown(data['nb_tours']!, _nbToursMeta),
      );
    } else if (isInserting) {
      context.missing(_nbToursMeta);
    }
    if (data.containsKey('preferred_team_size')) {
      context.handle(
        _preferredTeamSizeMeta,
        preferredTeamSize.isAcceptableOrUnknown(
          data['preferred_team_size']!,
          _preferredTeamSizeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredTeamSizeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tournament map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tournament(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      nbTours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nb_tours'],
      )!,
      preferredTeamSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_team_size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TournamentsTable createAlias(String alias) {
    return $TournamentsTable(attachedDatabase, alias);
  }
}

class Tournament extends DataClass implements Insertable<Tournament> {
  final int id;
  final String name;
  final DateTime date;
  final int nbTours;
  final int preferredTeamSize;
  final DateTime createdAt;
  const Tournament({
    required this.id,
    required this.name,
    required this.date,
    required this.nbTours,
    required this.preferredTeamSize,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    map['nb_tours'] = Variable<int>(nbTours);
    map['preferred_team_size'] = Variable<int>(preferredTeamSize);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TournamentsCompanion toCompanion(bool nullToAbsent) {
    return TournamentsCompanion(
      id: Value(id),
      name: Value(name),
      date: Value(date),
      nbTours: Value(nbTours),
      preferredTeamSize: Value(preferredTeamSize),
      createdAt: Value(createdAt),
    );
  }

  factory Tournament.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tournament(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      nbTours: serializer.fromJson<int>(json['nbTours']),
      preferredTeamSize: serializer.fromJson<int>(json['preferredTeamSize']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'nbTours': serializer.toJson<int>(nbTours),
      'preferredTeamSize': serializer.toJson<int>(preferredTeamSize),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tournament copyWith({
    int? id,
    String? name,
    DateTime? date,
    int? nbTours,
    int? preferredTeamSize,
    DateTime? createdAt,
  }) => Tournament(
    id: id ?? this.id,
    name: name ?? this.name,
    date: date ?? this.date,
    nbTours: nbTours ?? this.nbTours,
    preferredTeamSize: preferredTeamSize ?? this.preferredTeamSize,
    createdAt: createdAt ?? this.createdAt,
  );
  Tournament copyWithCompanion(TournamentsCompanion data) {
    return Tournament(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      date: data.date.present ? data.date.value : this.date,
      nbTours: data.nbTours.present ? data.nbTours.value : this.nbTours,
      preferredTeamSize: data.preferredTeamSize.present
          ? data.preferredTeamSize.value
          : this.preferredTeamSize,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tournament(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('nbTours: $nbTours, ')
          ..write('preferredTeamSize: $preferredTeamSize, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, date, nbTours, preferredTeamSize, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.nbTours == this.nbTours &&
          other.preferredTeamSize == this.preferredTeamSize &&
          other.createdAt == this.createdAt);
}

class TournamentsCompanion extends UpdateCompanion<Tournament> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<int> nbTours;
  final Value<int> preferredTeamSize;
  final Value<DateTime> createdAt;
  const TournamentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.nbTours = const Value.absent(),
    this.preferredTeamSize = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TournamentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime date,
    required int nbTours,
    required int preferredTeamSize,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       date = Value(date),
       nbTours = Value(nbTours),
       preferredTeamSize = Value(preferredTeamSize);
  static Insertable<Tournament> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<int>? nbTours,
    Expression<int>? preferredTeamSize,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (nbTours != null) 'nb_tours': nbTours,
      if (preferredTeamSize != null) 'preferred_team_size': preferredTeamSize,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TournamentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? date,
    Value<int>? nbTours,
    Value<int>? preferredTeamSize,
    Value<DateTime>? createdAt,
  }) {
    return TournamentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      nbTours: nbTours ?? this.nbTours,
      preferredTeamSize: preferredTeamSize ?? this.preferredTeamSize,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (nbTours.present) {
      map['nb_tours'] = Variable<int>(nbTours.value);
    }
    if (preferredTeamSize.present) {
      map['preferred_team_size'] = Variable<int>(preferredTeamSize.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('nbTours: $nbTours, ')
          ..write('preferredTeamSize: $preferredTeamSize, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TournamentPlayersTable extends TournamentPlayers
    with TableInfo<$TournamentPlayersTable, TournamentPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id)',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _joinedRoundMeta = const VerificationMeta(
    'joinedRound',
  );
  @override
  late final GeneratedColumn<int> joinedRound = GeneratedColumn<int>(
    'joined_round',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _leftRoundMeta = const VerificationMeta(
    'leftRound',
  );
  @override
  late final GeneratedColumn<int> leftRound = GeneratedColumn<int>(
    'left_round',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tournamentId,
    playerId,
    joinedRound,
    leftRound,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournament_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<TournamentPlayer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('joined_round')) {
      context.handle(
        _joinedRoundMeta,
        joinedRound.isAcceptableOrUnknown(
          data['joined_round']!,
          _joinedRoundMeta,
        ),
      );
    }
    if (data.containsKey('left_round')) {
      context.handle(
        _leftRoundMeta,
        leftRound.isAcceptableOrUnknown(data['left_round']!, _leftRoundMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tournamentId, playerId};
  @override
  TournamentPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TournamentPlayer(
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      joinedRound: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}joined_round'],
      )!,
      leftRound: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}left_round'],
      ),
    );
  }

  @override
  $TournamentPlayersTable createAlias(String alias) {
    return $TournamentPlayersTable(attachedDatabase, alias);
  }
}

class TournamentPlayer extends DataClass
    implements Insertable<TournamentPlayer> {
  final int tournamentId;
  final int playerId;
  final int joinedRound;
  final int? leftRound;
  const TournamentPlayer({
    required this.tournamentId,
    required this.playerId,
    required this.joinedRound,
    this.leftRound,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tournament_id'] = Variable<int>(tournamentId);
    map['player_id'] = Variable<int>(playerId);
    map['joined_round'] = Variable<int>(joinedRound);
    if (!nullToAbsent || leftRound != null) {
      map['left_round'] = Variable<int>(leftRound);
    }
    return map;
  }

  TournamentPlayersCompanion toCompanion(bool nullToAbsent) {
    return TournamentPlayersCompanion(
      tournamentId: Value(tournamentId),
      playerId: Value(playerId),
      joinedRound: Value(joinedRound),
      leftRound: leftRound == null && nullToAbsent
          ? const Value.absent()
          : Value(leftRound),
    );
  }

  factory TournamentPlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TournamentPlayer(
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      joinedRound: serializer.fromJson<int>(json['joinedRound']),
      leftRound: serializer.fromJson<int?>(json['leftRound']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tournamentId': serializer.toJson<int>(tournamentId),
      'playerId': serializer.toJson<int>(playerId),
      'joinedRound': serializer.toJson<int>(joinedRound),
      'leftRound': serializer.toJson<int?>(leftRound),
    };
  }

  TournamentPlayer copyWith({
    int? tournamentId,
    int? playerId,
    int? joinedRound,
    Value<int?> leftRound = const Value.absent(),
  }) => TournamentPlayer(
    tournamentId: tournamentId ?? this.tournamentId,
    playerId: playerId ?? this.playerId,
    joinedRound: joinedRound ?? this.joinedRound,
    leftRound: leftRound.present ? leftRound.value : this.leftRound,
  );
  TournamentPlayer copyWithCompanion(TournamentPlayersCompanion data) {
    return TournamentPlayer(
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      joinedRound: data.joinedRound.present
          ? data.joinedRound.value
          : this.joinedRound,
      leftRound: data.leftRound.present ? data.leftRound.value : this.leftRound,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TournamentPlayer(')
          ..write('tournamentId: $tournamentId, ')
          ..write('playerId: $playerId, ')
          ..write('joinedRound: $joinedRound, ')
          ..write('leftRound: $leftRound')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tournamentId, playerId, joinedRound, leftRound);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TournamentPlayer &&
          other.tournamentId == this.tournamentId &&
          other.playerId == this.playerId &&
          other.joinedRound == this.joinedRound &&
          other.leftRound == this.leftRound);
}

class TournamentPlayersCompanion extends UpdateCompanion<TournamentPlayer> {
  final Value<int> tournamentId;
  final Value<int> playerId;
  final Value<int> joinedRound;
  final Value<int?> leftRound;
  final Value<int> rowid;
  const TournamentPlayersCompanion({
    this.tournamentId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.joinedRound = const Value.absent(),
    this.leftRound = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TournamentPlayersCompanion.insert({
    required int tournamentId,
    required int playerId,
    this.joinedRound = const Value.absent(),
    this.leftRound = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tournamentId = Value(tournamentId),
       playerId = Value(playerId);
  static Insertable<TournamentPlayer> custom({
    Expression<int>? tournamentId,
    Expression<int>? playerId,
    Expression<int>? joinedRound,
    Expression<int>? leftRound,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (playerId != null) 'player_id': playerId,
      if (joinedRound != null) 'joined_round': joinedRound,
      if (leftRound != null) 'left_round': leftRound,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TournamentPlayersCompanion copyWith({
    Value<int>? tournamentId,
    Value<int>? playerId,
    Value<int>? joinedRound,
    Value<int?>? leftRound,
    Value<int>? rowid,
  }) {
    return TournamentPlayersCompanion(
      tournamentId: tournamentId ?? this.tournamentId,
      playerId: playerId ?? this.playerId,
      joinedRound: joinedRound ?? this.joinedRound,
      leftRound: leftRound ?? this.leftRound,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (joinedRound.present) {
      map['joined_round'] = Variable<int>(joinedRound.value);
    }
    if (leftRound.present) {
      map['left_round'] = Variable<int>(leftRound.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentPlayersCompanion(')
          ..write('tournamentId: $tournamentId, ')
          ..write('playerId: $playerId, ')
          ..write('joinedRound: $joinedRound, ')
          ..write('leftRound: $leftRound, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundPlansTable extends RoundPlans
    with TableInfo<$RoundPlansTable, RoundPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id)',
    ),
  );
  static const VerificationMeta _roundIndexMeta = const VerificationMeta(
    'roundIndex',
  );
  @override
  late final GeneratedColumn<int> roundIndex = GeneratedColumn<int>(
    'round_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PLANNED'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tournamentId, roundIndex, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'round_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoundPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('round_index')) {
      context.handle(
        _roundIndexMeta,
        roundIndex.isAcceptableOrUnknown(data['round_index']!, _roundIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIndexMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoundPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      roundIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_index'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $RoundPlansTable createAlias(String alias) {
    return $RoundPlansTable(attachedDatabase, alias);
  }
}

class RoundPlan extends DataClass implements Insertable<RoundPlan> {
  final int id;
  final int tournamentId;
  final int roundIndex;
  final String status;
  const RoundPlan({
    required this.id,
    required this.tournamentId,
    required this.roundIndex,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['round_index'] = Variable<int>(roundIndex);
    map['status'] = Variable<String>(status);
    return map;
  }

  RoundPlansCompanion toCompanion(bool nullToAbsent) {
    return RoundPlansCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      roundIndex: Value(roundIndex),
      status: Value(status),
    );
  }

  factory RoundPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundPlan(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      roundIndex: serializer.fromJson<int>(json['roundIndex']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'roundIndex': serializer.toJson<int>(roundIndex),
      'status': serializer.toJson<String>(status),
    };
  }

  RoundPlan copyWith({
    int? id,
    int? tournamentId,
    int? roundIndex,
    String? status,
  }) => RoundPlan(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    roundIndex: roundIndex ?? this.roundIndex,
    status: status ?? this.status,
  );
  RoundPlan copyWithCompanion(RoundPlansCompanion data) {
    return RoundPlan(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      roundIndex: data.roundIndex.present
          ? data.roundIndex.value
          : this.roundIndex,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundPlan(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('roundIndex: $roundIndex, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tournamentId, roundIndex, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundPlan &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.roundIndex == this.roundIndex &&
          other.status == this.status);
}

class RoundPlansCompanion extends UpdateCompanion<RoundPlan> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<int> roundIndex;
  final Value<String> status;
  const RoundPlansCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.roundIndex = const Value.absent(),
    this.status = const Value.absent(),
  });
  RoundPlansCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required int roundIndex,
    this.status = const Value.absent(),
  }) : tournamentId = Value(tournamentId),
       roundIndex = Value(roundIndex);
  static Insertable<RoundPlan> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<int>? roundIndex,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (roundIndex != null) 'round_index': roundIndex,
      if (status != null) 'status': status,
    });
  }

  RoundPlansCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<int>? roundIndex,
    Value<String>? status,
  }) {
    return RoundPlansCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      roundIndex: roundIndex ?? this.roundIndex,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (roundIndex.present) {
      map['round_index'] = Variable<int>(roundIndex.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundPlansCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('roundIndex: $roundIndex, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TeamPlansTable extends TeamPlans
    with TableInfo<$TeamPlansTable, TeamPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _roundIdMeta = const VerificationMeta(
    'roundId',
  );
  @override
  late final GeneratedColumn<int> roundId = GeneratedColumn<int>(
    'round_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES round_plans (id)',
    ),
  );
  static const VerificationMeta _teamIndexMeta = const VerificationMeta(
    'teamIndex',
  );
  @override
  late final GeneratedColumn<int> teamIndex = GeneratedColumn<int>(
    'team_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamSizeMeta = const VerificationMeta(
    'teamSize',
  );
  @override
  late final GeneratedColumn<int> teamSize = GeneratedColumn<int>(
    'team_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, roundId, teamIndex, teamSize];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('round_id')) {
      context.handle(
        _roundIdMeta,
        roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('team_index')) {
      context.handle(
        _teamIndexMeta,
        teamIndex.isAcceptableOrUnknown(data['team_index']!, _teamIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIndexMeta);
    }
    if (data.containsKey('team_size')) {
      context.handle(
        _teamSizeMeta,
        teamSize.isAcceptableOrUnknown(data['team_size']!, _teamSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_teamSizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      roundId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_id'],
      )!,
      teamIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_index'],
      )!,
      teamSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_size'],
      )!,
    );
  }

  @override
  $TeamPlansTable createAlias(String alias) {
    return $TeamPlansTable(attachedDatabase, alias);
  }
}

class TeamPlan extends DataClass implements Insertable<TeamPlan> {
  final int id;
  final int roundId;
  final int teamIndex;
  final int teamSize;
  const TeamPlan({
    required this.id,
    required this.roundId,
    required this.teamIndex,
    required this.teamSize,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['round_id'] = Variable<int>(roundId);
    map['team_index'] = Variable<int>(teamIndex);
    map['team_size'] = Variable<int>(teamSize);
    return map;
  }

  TeamPlansCompanion toCompanion(bool nullToAbsent) {
    return TeamPlansCompanion(
      id: Value(id),
      roundId: Value(roundId),
      teamIndex: Value(teamIndex),
      teamSize: Value(teamSize),
    );
  }

  factory TeamPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPlan(
      id: serializer.fromJson<int>(json['id']),
      roundId: serializer.fromJson<int>(json['roundId']),
      teamIndex: serializer.fromJson<int>(json['teamIndex']),
      teamSize: serializer.fromJson<int>(json['teamSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'roundId': serializer.toJson<int>(roundId),
      'teamIndex': serializer.toJson<int>(teamIndex),
      'teamSize': serializer.toJson<int>(teamSize),
    };
  }

  TeamPlan copyWith({int? id, int? roundId, int? teamIndex, int? teamSize}) =>
      TeamPlan(
        id: id ?? this.id,
        roundId: roundId ?? this.roundId,
        teamIndex: teamIndex ?? this.teamIndex,
        teamSize: teamSize ?? this.teamSize,
      );
  TeamPlan copyWithCompanion(TeamPlansCompanion data) {
    return TeamPlan(
      id: data.id.present ? data.id.value : this.id,
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      teamIndex: data.teamIndex.present ? data.teamIndex.value : this.teamIndex,
      teamSize: data.teamSize.present ? data.teamSize.value : this.teamSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlan(')
          ..write('id: $id, ')
          ..write('roundId: $roundId, ')
          ..write('teamIndex: $teamIndex, ')
          ..write('teamSize: $teamSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, roundId, teamIndex, teamSize);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPlan &&
          other.id == this.id &&
          other.roundId == this.roundId &&
          other.teamIndex == this.teamIndex &&
          other.teamSize == this.teamSize);
}

class TeamPlansCompanion extends UpdateCompanion<TeamPlan> {
  final Value<int> id;
  final Value<int> roundId;
  final Value<int> teamIndex;
  final Value<int> teamSize;
  const TeamPlansCompanion({
    this.id = const Value.absent(),
    this.roundId = const Value.absent(),
    this.teamIndex = const Value.absent(),
    this.teamSize = const Value.absent(),
  });
  TeamPlansCompanion.insert({
    this.id = const Value.absent(),
    required int roundId,
    required int teamIndex,
    required int teamSize,
  }) : roundId = Value(roundId),
       teamIndex = Value(teamIndex),
       teamSize = Value(teamSize);
  static Insertable<TeamPlan> custom({
    Expression<int>? id,
    Expression<int>? roundId,
    Expression<int>? teamIndex,
    Expression<int>? teamSize,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roundId != null) 'round_id': roundId,
      if (teamIndex != null) 'team_index': teamIndex,
      if (teamSize != null) 'team_size': teamSize,
    });
  }

  TeamPlansCompanion copyWith({
    Value<int>? id,
    Value<int>? roundId,
    Value<int>? teamIndex,
    Value<int>? teamSize,
  }) {
    return TeamPlansCompanion(
      id: id ?? this.id,
      roundId: roundId ?? this.roundId,
      teamIndex: teamIndex ?? this.teamIndex,
      teamSize: teamSize ?? this.teamSize,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (roundId.present) {
      map['round_id'] = Variable<int>(roundId.value);
    }
    if (teamIndex.present) {
      map['team_index'] = Variable<int>(teamIndex.value);
    }
    if (teamSize.present) {
      map['team_size'] = Variable<int>(teamSize.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlansCompanion(')
          ..write('id: $id, ')
          ..write('roundId: $roundId, ')
          ..write('teamIndex: $teamIndex, ')
          ..write('teamSize: $teamSize')
          ..write(')'))
        .toString();
  }
}

class $TeamMemberPlansTable extends TeamMemberPlans
    with TableInfo<$TeamMemberPlansTable, TeamMemberPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamMemberPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_plans (id)',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [teamId, playerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_member_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamMemberPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, playerId};
  @override
  TeamMemberPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamMemberPlan(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
    );
  }

  @override
  $TeamMemberPlansTable createAlias(String alias) {
    return $TeamMemberPlansTable(attachedDatabase, alias);
  }
}

class TeamMemberPlan extends DataClass implements Insertable<TeamMemberPlan> {
  final int teamId;
  final int playerId;
  const TeamMemberPlan({required this.teamId, required this.playerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<int>(teamId);
    map['player_id'] = Variable<int>(playerId);
    return map;
  }

  TeamMemberPlansCompanion toCompanion(bool nullToAbsent) {
    return TeamMemberPlansCompanion(
      teamId: Value(teamId),
      playerId: Value(playerId),
    );
  }

  factory TeamMemberPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamMemberPlan(
      teamId: serializer.fromJson<int>(json['teamId']),
      playerId: serializer.fromJson<int>(json['playerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<int>(teamId),
      'playerId': serializer.toJson<int>(playerId),
    };
  }

  TeamMemberPlan copyWith({int? teamId, int? playerId}) => TeamMemberPlan(
    teamId: teamId ?? this.teamId,
    playerId: playerId ?? this.playerId,
  );
  TeamMemberPlan copyWithCompanion(TeamMemberPlansCompanion data) {
    return TeamMemberPlan(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamMemberPlan(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teamId, playerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamMemberPlan &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId);
}

class TeamMemberPlansCompanion extends UpdateCompanion<TeamMemberPlan> {
  final Value<int> teamId;
  final Value<int> playerId;
  final Value<int> rowid;
  const TeamMemberPlansCompanion({
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamMemberPlansCompanion.insert({
    required int teamId,
    required int playerId,
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       playerId = Value(playerId);
  static Insertable<TeamMemberPlan> custom({
    Expression<int>? teamId,
    Expression<int>? playerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamMemberPlansCompanion copyWith({
    Value<int>? teamId,
    Value<int>? playerId,
    Value<int>? rowid,
  }) {
    return TeamMemberPlansCompanion(
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamMemberPlansCompanion(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchPlansTable extends MatchPlans
    with TableInfo<$MatchPlansTable, MatchPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _roundIdMeta = const VerificationMeta(
    'roundId',
  );
  @override
  late final GeneratedColumn<int> roundId = GeneratedColumn<int>(
    'round_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES round_plans (id)',
    ),
  );
  static const VerificationMeta _matchIndexMeta = const VerificationMeta(
    'matchIndex',
  );
  @override
  late final GeneratedColumn<int> matchIndex = GeneratedColumn<int>(
    'match_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamAIdMeta = const VerificationMeta(
    'teamAId',
  );
  @override
  late final GeneratedColumn<int> teamAId = GeneratedColumn<int>(
    'team_a_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_plans (id)',
    ),
  );
  static const VerificationMeta _teamBIdMeta = const VerificationMeta(
    'teamBId',
  );
  @override
  late final GeneratedColumn<int> teamBId = GeneratedColumn<int>(
    'team_b_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_plans (id)',
    ),
  );
  static const VerificationMeta _scoreAMeta = const VerificationMeta('scoreA');
  @override
  late final GeneratedColumn<int> scoreA = GeneratedColumn<int>(
    'score_a',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreBMeta = const VerificationMeta('scoreB');
  @override
  late final GeneratedColumn<int> scoreB = GeneratedColumn<int>(
    'score_b',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    roundId,
    matchIndex,
    teamAId,
    teamBId,
    scoreA,
    scoreB,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('round_id')) {
      context.handle(
        _roundIdMeta,
        roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('match_index')) {
      context.handle(
        _matchIndexMeta,
        matchIndex.isAcceptableOrUnknown(data['match_index']!, _matchIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIndexMeta);
    }
    if (data.containsKey('team_a_id')) {
      context.handle(
        _teamAIdMeta,
        teamAId.isAcceptableOrUnknown(data['team_a_id']!, _teamAIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamAIdMeta);
    }
    if (data.containsKey('team_b_id')) {
      context.handle(
        _teamBIdMeta,
        teamBId.isAcceptableOrUnknown(data['team_b_id']!, _teamBIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamBIdMeta);
    }
    if (data.containsKey('score_a')) {
      context.handle(
        _scoreAMeta,
        scoreA.isAcceptableOrUnknown(data['score_a']!, _scoreAMeta),
      );
    }
    if (data.containsKey('score_b')) {
      context.handle(
        _scoreBMeta,
        scoreB.isAcceptableOrUnknown(data['score_b']!, _scoreBMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      roundId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_id'],
      )!,
      matchIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_index'],
      )!,
      teamAId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_a_id'],
      )!,
      teamBId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_b_id'],
      )!,
      scoreA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_a'],
      ),
      scoreB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_b'],
      ),
    );
  }

  @override
  $MatchPlansTable createAlias(String alias) {
    return $MatchPlansTable(attachedDatabase, alias);
  }
}

class MatchPlan extends DataClass implements Insertable<MatchPlan> {
  final int id;
  final int roundId;
  final int matchIndex;
  final int teamAId;
  final int teamBId;
  final int? scoreA;
  final int? scoreB;
  const MatchPlan({
    required this.id,
    required this.roundId,
    required this.matchIndex,
    required this.teamAId,
    required this.teamBId,
    this.scoreA,
    this.scoreB,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['round_id'] = Variable<int>(roundId);
    map['match_index'] = Variable<int>(matchIndex);
    map['team_a_id'] = Variable<int>(teamAId);
    map['team_b_id'] = Variable<int>(teamBId);
    if (!nullToAbsent || scoreA != null) {
      map['score_a'] = Variable<int>(scoreA);
    }
    if (!nullToAbsent || scoreB != null) {
      map['score_b'] = Variable<int>(scoreB);
    }
    return map;
  }

  MatchPlansCompanion toCompanion(bool nullToAbsent) {
    return MatchPlansCompanion(
      id: Value(id),
      roundId: Value(roundId),
      matchIndex: Value(matchIndex),
      teamAId: Value(teamAId),
      teamBId: Value(teamBId),
      scoreA: scoreA == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreA),
      scoreB: scoreB == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreB),
    );
  }

  factory MatchPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchPlan(
      id: serializer.fromJson<int>(json['id']),
      roundId: serializer.fromJson<int>(json['roundId']),
      matchIndex: serializer.fromJson<int>(json['matchIndex']),
      teamAId: serializer.fromJson<int>(json['teamAId']),
      teamBId: serializer.fromJson<int>(json['teamBId']),
      scoreA: serializer.fromJson<int?>(json['scoreA']),
      scoreB: serializer.fromJson<int?>(json['scoreB']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'roundId': serializer.toJson<int>(roundId),
      'matchIndex': serializer.toJson<int>(matchIndex),
      'teamAId': serializer.toJson<int>(teamAId),
      'teamBId': serializer.toJson<int>(teamBId),
      'scoreA': serializer.toJson<int?>(scoreA),
      'scoreB': serializer.toJson<int?>(scoreB),
    };
  }

  MatchPlan copyWith({
    int? id,
    int? roundId,
    int? matchIndex,
    int? teamAId,
    int? teamBId,
    Value<int?> scoreA = const Value.absent(),
    Value<int?> scoreB = const Value.absent(),
  }) => MatchPlan(
    id: id ?? this.id,
    roundId: roundId ?? this.roundId,
    matchIndex: matchIndex ?? this.matchIndex,
    teamAId: teamAId ?? this.teamAId,
    teamBId: teamBId ?? this.teamBId,
    scoreA: scoreA.present ? scoreA.value : this.scoreA,
    scoreB: scoreB.present ? scoreB.value : this.scoreB,
  );
  MatchPlan copyWithCompanion(MatchPlansCompanion data) {
    return MatchPlan(
      id: data.id.present ? data.id.value : this.id,
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      matchIndex: data.matchIndex.present
          ? data.matchIndex.value
          : this.matchIndex,
      teamAId: data.teamAId.present ? data.teamAId.value : this.teamAId,
      teamBId: data.teamBId.present ? data.teamBId.value : this.teamBId,
      scoreA: data.scoreA.present ? data.scoreA.value : this.scoreA,
      scoreB: data.scoreB.present ? data.scoreB.value : this.scoreB,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchPlan(')
          ..write('id: $id, ')
          ..write('roundId: $roundId, ')
          ..write('matchIndex: $matchIndex, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, roundId, matchIndex, teamAId, teamBId, scoreA, scoreB);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchPlan &&
          other.id == this.id &&
          other.roundId == this.roundId &&
          other.matchIndex == this.matchIndex &&
          other.teamAId == this.teamAId &&
          other.teamBId == this.teamBId &&
          other.scoreA == this.scoreA &&
          other.scoreB == this.scoreB);
}

class MatchPlansCompanion extends UpdateCompanion<MatchPlan> {
  final Value<int> id;
  final Value<int> roundId;
  final Value<int> matchIndex;
  final Value<int> teamAId;
  final Value<int> teamBId;
  final Value<int?> scoreA;
  final Value<int?> scoreB;
  const MatchPlansCompanion({
    this.id = const Value.absent(),
    this.roundId = const Value.absent(),
    this.matchIndex = const Value.absent(),
    this.teamAId = const Value.absent(),
    this.teamBId = const Value.absent(),
    this.scoreA = const Value.absent(),
    this.scoreB = const Value.absent(),
  });
  MatchPlansCompanion.insert({
    this.id = const Value.absent(),
    required int roundId,
    required int matchIndex,
    required int teamAId,
    required int teamBId,
    this.scoreA = const Value.absent(),
    this.scoreB = const Value.absent(),
  }) : roundId = Value(roundId),
       matchIndex = Value(matchIndex),
       teamAId = Value(teamAId),
       teamBId = Value(teamBId);
  static Insertable<MatchPlan> custom({
    Expression<int>? id,
    Expression<int>? roundId,
    Expression<int>? matchIndex,
    Expression<int>? teamAId,
    Expression<int>? teamBId,
    Expression<int>? scoreA,
    Expression<int>? scoreB,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roundId != null) 'round_id': roundId,
      if (matchIndex != null) 'match_index': matchIndex,
      if (teamAId != null) 'team_a_id': teamAId,
      if (teamBId != null) 'team_b_id': teamBId,
      if (scoreA != null) 'score_a': scoreA,
      if (scoreB != null) 'score_b': scoreB,
    });
  }

  MatchPlansCompanion copyWith({
    Value<int>? id,
    Value<int>? roundId,
    Value<int>? matchIndex,
    Value<int>? teamAId,
    Value<int>? teamBId,
    Value<int?>? scoreA,
    Value<int?>? scoreB,
  }) {
    return MatchPlansCompanion(
      id: id ?? this.id,
      roundId: roundId ?? this.roundId,
      matchIndex: matchIndex ?? this.matchIndex,
      teamAId: teamAId ?? this.teamAId,
      teamBId: teamBId ?? this.teamBId,
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (roundId.present) {
      map['round_id'] = Variable<int>(roundId.value);
    }
    if (matchIndex.present) {
      map['match_index'] = Variable<int>(matchIndex.value);
    }
    if (teamAId.present) {
      map['team_a_id'] = Variable<int>(teamAId.value);
    }
    if (teamBId.present) {
      map['team_b_id'] = Variable<int>(teamBId.value);
    }
    if (scoreA.present) {
      map['score_a'] = Variable<int>(scoreA.value);
    }
    if (scoreB.present) {
      map['score_b'] = Variable<int>(scoreB.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchPlansCompanion(')
          ..write('id: $id, ')
          ..write('roundId: $roundId, ')
          ..write('matchIndex: $matchIndex, ')
          ..write('teamAId: $teamAId, ')
          ..write('teamBId: $teamBId, ')
          ..write('scoreA: $scoreA, ')
          ..write('scoreB: $scoreB')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $TournamentsTable tournaments = $TournamentsTable(this);
  late final $TournamentPlayersTable tournamentPlayers =
      $TournamentPlayersTable(this);
  late final $RoundPlansTable roundPlans = $RoundPlansTable(this);
  late final $TeamPlansTable teamPlans = $TeamPlansTable(this);
  late final $TeamMemberPlansTable teamMemberPlans = $TeamMemberPlansTable(
    this,
  );
  late final $MatchPlansTable matchPlans = $MatchPlansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    players,
    tournaments,
    tournamentPlayers,
    roundPlans,
    teamPlans,
    teamMemberPlans,
    matchPlans,
  ];
}

typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required String name,
      Value<int> role,
      Value<bool> activePool,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> role,
      Value<bool> activePool,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TournamentPlayersTable, List<TournamentPlayer>>
  _tournamentPlayersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.tournamentPlayers,
        aliasName: $_aliasNameGenerator(
          db.players.id,
          db.tournamentPlayers.playerId,
        ),
      );

  $$TournamentPlayersTableProcessedTableManager get tournamentPlayersRefs {
    final manager = $$TournamentPlayersTableTableManager(
      $_db,
      $_db.tournamentPlayers,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _tournamentPlayersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TeamMemberPlansTable, List<TeamMemberPlan>>
  _teamMemberPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamMemberPlans,
    aliasName: $_aliasNameGenerator(db.players.id, db.teamMemberPlans.playerId),
  );

  $$TeamMemberPlansTableProcessedTableManager get teamMemberPlansRefs {
    final manager = $$TeamMemberPlansTableTableManager(
      $_db,
      $_db.teamMemberPlans,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _teamMemberPlansRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activePool => $composableBuilder(
    column: $table.activePool,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tournamentPlayersRefs(
    Expression<bool> Function($$TournamentPlayersTableFilterComposer f) f,
  ) {
    final $$TournamentPlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tournamentPlayers,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentPlayersTableFilterComposer(
            $db: $db,
            $table: $db.tournamentPlayers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> teamMemberPlansRefs(
    Expression<bool> Function($$TeamMemberPlansTableFilterComposer f) f,
  ) {
    final $$TeamMemberPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMemberPlans,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMemberPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamMemberPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activePool => $composableBuilder(
    column: $table.activePool,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get activePool => $composableBuilder(
    column: $table.activePool,
    builder: (column) => column,
  );

  Expression<T> tournamentPlayersRefs<T extends Object>(
    Expression<T> Function($$TournamentPlayersTableAnnotationComposer a) f,
  ) {
    final $$TournamentPlayersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentPlayers,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentPlayersTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentPlayers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> teamMemberPlansRefs<T extends Object>(
    Expression<T> Function($$TeamMemberPlansTableAnnotationComposer a) f,
  ) {
    final $$TeamMemberPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMemberPlans,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMemberPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamMemberPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({
            bool tournamentPlayersRefs,
            bool teamMemberPlansRefs,
          })
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> role = const Value.absent(),
                Value<bool> activePool = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                name: name,
                role: role,
                activePool: activePool,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> role = const Value.absent(),
                Value<bool> activePool = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                name: name,
                role: role,
                activePool: activePool,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tournamentPlayersRefs = false, teamMemberPlansRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tournamentPlayersRefs) db.tournamentPlayers,
                    if (teamMemberPlansRefs) db.teamMemberPlans,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tournamentPlayersRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TournamentPlayer
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._tournamentPlayersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).tournamentPlayersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (teamMemberPlansRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TeamMemberPlan
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._teamMemberPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).teamMemberPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({
        bool tournamentPlayersRefs,
        bool teamMemberPlansRefs,
      })
    >;
typedef $$TournamentsTableCreateCompanionBuilder =
    TournamentsCompanion Function({
      Value<int> id,
      required String name,
      required DateTime date,
      required int nbTours,
      required int preferredTeamSize,
      Value<DateTime> createdAt,
    });
typedef $$TournamentsTableUpdateCompanionBuilder =
    TournamentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> date,
      Value<int> nbTours,
      Value<int> preferredTeamSize,
      Value<DateTime> createdAt,
    });

final class $$TournamentsTableReferences
    extends BaseReferences<_$AppDatabase, $TournamentsTable, Tournament> {
  $$TournamentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TournamentPlayersTable, List<TournamentPlayer>>
  _tournamentPlayersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.tournamentPlayers,
        aliasName: $_aliasNameGenerator(
          db.tournaments.id,
          db.tournamentPlayers.tournamentId,
        ),
      );

  $$TournamentPlayersTableProcessedTableManager get tournamentPlayersRefs {
    final manager = $$TournamentPlayersTableTableManager(
      $_db,
      $_db.tournamentPlayers,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _tournamentPlayersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoundPlansTable, List<RoundPlan>>
  _roundPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundPlans,
    aliasName: $_aliasNameGenerator(
      db.tournaments.id,
      db.roundPlans.tournamentId,
    ),
  );

  $$RoundPlansTableProcessedTableManager get roundPlansRefs {
    final manager = $$RoundPlansTableTableManager(
      $_db,
      $_db.roundPlans,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roundPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TournamentsTableFilterComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nbTours => $composableBuilder(
    column: $table.nbTours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredTeamSize => $composableBuilder(
    column: $table.preferredTeamSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tournamentPlayersRefs(
    Expression<bool> Function($$TournamentPlayersTableFilterComposer f) f,
  ) {
    final $$TournamentPlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tournamentPlayers,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentPlayersTableFilterComposer(
            $db: $db,
            $table: $db.tournamentPlayers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roundPlansRefs(
    Expression<bool> Function($$RoundPlansTableFilterComposer f) f,
  ) {
    final $$RoundPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableFilterComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nbTours => $composableBuilder(
    column: $table.nbTours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredTeamSize => $composableBuilder(
    column: $table.preferredTeamSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TournamentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get nbTours =>
      $composableBuilder(column: $table.nbTours, builder: (column) => column);

  GeneratedColumn<int> get preferredTeamSize => $composableBuilder(
    column: $table.preferredTeamSize,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> tournamentPlayersRefs<T extends Object>(
    Expression<T> Function($$TournamentPlayersTableAnnotationComposer a) f,
  ) {
    final $$TournamentPlayersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentPlayers,
          getReferencedColumn: (t) => t.tournamentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentPlayersTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentPlayers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> roundPlansRefs<T extends Object>(
    Expression<T> Function($$RoundPlansTableAnnotationComposer a) f,
  ) {
    final $$RoundPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TournamentsTable,
          Tournament,
          $$TournamentsTableFilterComposer,
          $$TournamentsTableOrderingComposer,
          $$TournamentsTableAnnotationComposer,
          $$TournamentsTableCreateCompanionBuilder,
          $$TournamentsTableUpdateCompanionBuilder,
          (Tournament, $$TournamentsTableReferences),
          Tournament,
          PrefetchHooks Function({
            bool tournamentPlayersRefs,
            bool roundPlansRefs,
          })
        > {
  $$TournamentsTableTableManager(_$AppDatabase db, $TournamentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> nbTours = const Value.absent(),
                Value<int> preferredTeamSize = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentsCompanion(
                id: id,
                name: name,
                date: date,
                nbTours: nbTours,
                preferredTeamSize: preferredTeamSize,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime date,
                required int nbTours,
                required int preferredTeamSize,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentsCompanion.insert(
                id: id,
                name: name,
                date: date,
                nbTours: nbTours,
                preferredTeamSize: preferredTeamSize,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TournamentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tournamentPlayersRefs = false, roundPlansRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tournamentPlayersRefs) db.tournamentPlayers,
                    if (roundPlansRefs) db.roundPlans,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tournamentPlayersRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          TournamentPlayer
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._tournamentPlayersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).tournamentPlayersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (roundPlansRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          RoundPlan
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._roundPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).roundPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TournamentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TournamentsTable,
      Tournament,
      $$TournamentsTableFilterComposer,
      $$TournamentsTableOrderingComposer,
      $$TournamentsTableAnnotationComposer,
      $$TournamentsTableCreateCompanionBuilder,
      $$TournamentsTableUpdateCompanionBuilder,
      (Tournament, $$TournamentsTableReferences),
      Tournament,
      PrefetchHooks Function({bool tournamentPlayersRefs, bool roundPlansRefs})
    >;
typedef $$TournamentPlayersTableCreateCompanionBuilder =
    TournamentPlayersCompanion Function({
      required int tournamentId,
      required int playerId,
      Value<int> joinedRound,
      Value<int?> leftRound,
      Value<int> rowid,
    });
typedef $$TournamentPlayersTableUpdateCompanionBuilder =
    TournamentPlayersCompanion Function({
      Value<int> tournamentId,
      Value<int> playerId,
      Value<int> joinedRound,
      Value<int?> leftRound,
      Value<int> rowid,
    });

final class $$TournamentPlayersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TournamentPlayersTable,
          TournamentPlayer
        > {
  $$TournamentPlayersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(
          db.tournamentPlayers.tournamentId,
          db.tournaments.id,
        ),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.tournamentPlayers.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TournamentPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $TournamentPlayersTable> {
  $$TournamentPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get joinedRound => $composableBuilder(
    column: $table.joinedRound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leftRound => $composableBuilder(
    column: $table.leftRound,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $TournamentPlayersTable> {
  $$TournamentPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get joinedRound => $composableBuilder(
    column: $table.joinedRound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leftRound => $composableBuilder(
    column: $table.leftRound,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TournamentPlayersTable> {
  $$TournamentPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get joinedRound => $composableBuilder(
    column: $table.joinedRound,
    builder: (column) => column,
  );

  GeneratedColumn<int> get leftRound =>
      $composableBuilder(column: $table.leftRound, builder: (column) => column);

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentPlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TournamentPlayersTable,
          TournamentPlayer,
          $$TournamentPlayersTableFilterComposer,
          $$TournamentPlayersTableOrderingComposer,
          $$TournamentPlayersTableAnnotationComposer,
          $$TournamentPlayersTableCreateCompanionBuilder,
          $$TournamentPlayersTableUpdateCompanionBuilder,
          (TournamentPlayer, $$TournamentPlayersTableReferences),
          TournamentPlayer,
          PrefetchHooks Function({bool tournamentId, bool playerId})
        > {
  $$TournamentPlayersTableTableManager(
    _$AppDatabase db,
    $TournamentPlayersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentPlayersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> tournamentId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> joinedRound = const Value.absent(),
                Value<int?> leftRound = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TournamentPlayersCompanion(
                tournamentId: tournamentId,
                playerId: playerId,
                joinedRound: joinedRound,
                leftRound: leftRound,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int tournamentId,
                required int playerId,
                Value<int> joinedRound = const Value.absent(),
                Value<int?> leftRound = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TournamentPlayersCompanion.insert(
                tournamentId: tournamentId,
                playerId: playerId,
                joinedRound: joinedRound,
                leftRound: leftRound,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TournamentPlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tournamentId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tournamentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tournamentId,
                                referencedTable:
                                    $$TournamentPlayersTableReferences
                                        ._tournamentIdTable(db),
                                referencedColumn:
                                    $$TournamentPlayersTableReferences
                                        ._tournamentIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable:
                                    $$TournamentPlayersTableReferences
                                        ._playerIdTable(db),
                                referencedColumn:
                                    $$TournamentPlayersTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TournamentPlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TournamentPlayersTable,
      TournamentPlayer,
      $$TournamentPlayersTableFilterComposer,
      $$TournamentPlayersTableOrderingComposer,
      $$TournamentPlayersTableAnnotationComposer,
      $$TournamentPlayersTableCreateCompanionBuilder,
      $$TournamentPlayersTableUpdateCompanionBuilder,
      (TournamentPlayer, $$TournamentPlayersTableReferences),
      TournamentPlayer,
      PrefetchHooks Function({bool tournamentId, bool playerId})
    >;
typedef $$RoundPlansTableCreateCompanionBuilder =
    RoundPlansCompanion Function({
      Value<int> id,
      required int tournamentId,
      required int roundIndex,
      Value<String> status,
    });
typedef $$RoundPlansTableUpdateCompanionBuilder =
    RoundPlansCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<int> roundIndex,
      Value<String> status,
    });

final class $$RoundPlansTableReferences
    extends BaseReferences<_$AppDatabase, $RoundPlansTable, RoundPlan> {
  $$RoundPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(db.roundPlans.tournamentId, db.tournaments.id),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TeamPlansTable, List<TeamPlan>>
  _teamPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamPlans,
    aliasName: $_aliasNameGenerator(db.roundPlans.id, db.teamPlans.roundId),
  );

  $$TeamPlansTableProcessedTableManager get teamPlansRefs {
    final manager = $$TeamPlansTableTableManager(
      $_db,
      $_db.teamPlans,
    ).filter((f) => f.roundId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchPlansTable, List<MatchPlan>>
  _matchPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.matchPlans,
    aliasName: $_aliasNameGenerator(db.roundPlans.id, db.matchPlans.roundId),
  );

  $$MatchPlansTableProcessedTableManager get matchPlansRefs {
    final manager = $$MatchPlansTableTableManager(
      $_db,
      $_db.matchPlans,
    ).filter((f) => f.roundId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoundPlansTableFilterComposer
    extends Composer<_$AppDatabase, $RoundPlansTable> {
  $$RoundPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundIndex => $composableBuilder(
    column: $table.roundIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> teamPlansRefs(
    Expression<bool> Function($$TeamPlansTableFilterComposer f) f,
  ) {
    final $$TeamPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> matchPlansRefs(
    Expression<bool> Function($$MatchPlansTableFilterComposer f) f,
  ) {
    final $$MatchPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchPlans,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchPlansTableFilterComposer(
            $db: $db,
            $table: $db.matchPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundPlansTable> {
  $$RoundPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundIndex => $composableBuilder(
    column: $table.roundIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundPlansTable> {
  $$RoundPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get roundIndex => $composableBuilder(
    column: $table.roundIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> teamPlansRefs<T extends Object>(
    Expression<T> Function($$TeamPlansTableAnnotationComposer a) f,
  ) {
    final $$TeamPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> matchPlansRefs<T extends Object>(
    Expression<T> Function($$MatchPlansTableAnnotationComposer a) f,
  ) {
    final $$MatchPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.matchPlans,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.matchPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundPlansTable,
          RoundPlan,
          $$RoundPlansTableFilterComposer,
          $$RoundPlansTableOrderingComposer,
          $$RoundPlansTableAnnotationComposer,
          $$RoundPlansTableCreateCompanionBuilder,
          $$RoundPlansTableUpdateCompanionBuilder,
          (RoundPlan, $$RoundPlansTableReferences),
          RoundPlan,
          PrefetchHooks Function({
            bool tournamentId,
            bool teamPlansRefs,
            bool matchPlansRefs,
          })
        > {
  $$RoundPlansTableTableManager(_$AppDatabase db, $RoundPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<int> roundIndex = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => RoundPlansCompanion(
                id: id,
                tournamentId: tournamentId,
                roundIndex: roundIndex,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required int roundIndex,
                Value<String> status = const Value.absent(),
              }) => RoundPlansCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                roundIndex: roundIndex,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoundPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentId = false,
                teamPlansRefs = false,
                matchPlansRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (teamPlansRefs) db.teamPlans,
                    if (matchPlansRefs) db.matchPlans,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tournamentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tournamentId,
                                    referencedTable: $$RoundPlansTableReferences
                                        ._tournamentIdTable(db),
                                    referencedColumn:
                                        $$RoundPlansTableReferences
                                            ._tournamentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (teamPlansRefs)
                        await $_getPrefetchedData<
                          RoundPlan,
                          $RoundPlansTable,
                          TeamPlan
                        >(
                          currentTable: table,
                          referencedTable: $$RoundPlansTableReferences
                              ._teamPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoundPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).teamPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roundId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (matchPlansRefs)
                        await $_getPrefetchedData<
                          RoundPlan,
                          $RoundPlansTable,
                          MatchPlan
                        >(
                          currentTable: table,
                          referencedTable: $$RoundPlansTableReferences
                              ._matchPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoundPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).matchPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roundId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoundPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundPlansTable,
      RoundPlan,
      $$RoundPlansTableFilterComposer,
      $$RoundPlansTableOrderingComposer,
      $$RoundPlansTableAnnotationComposer,
      $$RoundPlansTableCreateCompanionBuilder,
      $$RoundPlansTableUpdateCompanionBuilder,
      (RoundPlan, $$RoundPlansTableReferences),
      RoundPlan,
      PrefetchHooks Function({
        bool tournamentId,
        bool teamPlansRefs,
        bool matchPlansRefs,
      })
    >;
typedef $$TeamPlansTableCreateCompanionBuilder =
    TeamPlansCompanion Function({
      Value<int> id,
      required int roundId,
      required int teamIndex,
      required int teamSize,
    });
typedef $$TeamPlansTableUpdateCompanionBuilder =
    TeamPlansCompanion Function({
      Value<int> id,
      Value<int> roundId,
      Value<int> teamIndex,
      Value<int> teamSize,
    });

final class $$TeamPlansTableReferences
    extends BaseReferences<_$AppDatabase, $TeamPlansTable, TeamPlan> {
  $$TeamPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoundPlansTable _roundIdTable(_$AppDatabase db) =>
      db.roundPlans.createAlias(
        $_aliasNameGenerator(db.teamPlans.roundId, db.roundPlans.id),
      );

  $$RoundPlansTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<int>('round_id')!;

    final manager = $$RoundPlansTableTableManager(
      $_db,
      $_db.roundPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TeamMemberPlansTable, List<TeamMemberPlan>>
  _teamMemberPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamMemberPlans,
    aliasName: $_aliasNameGenerator(db.teamPlans.id, db.teamMemberPlans.teamId),
  );

  $$TeamMemberPlansTableProcessedTableManager get teamMemberPlansRefs {
    final manager = $$TeamMemberPlansTableTableManager(
      $_db,
      $_db.teamMemberPlans,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _teamMemberPlansRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeamPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TeamPlansTable> {
  $$TeamPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamIndex => $composableBuilder(
    column: $table.teamIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teamSize => $composableBuilder(
    column: $table.teamSize,
    builder: (column) => ColumnFilters(column),
  );

  $$RoundPlansTableFilterComposer get roundId {
    final $$RoundPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableFilterComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> teamMemberPlansRefs(
    Expression<bool> Function($$TeamMemberPlansTableFilterComposer f) f,
  ) {
    final $$TeamMemberPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMemberPlans,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMemberPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamMemberPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamPlansTable> {
  $$TeamPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamIndex => $composableBuilder(
    column: $table.teamIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teamSize => $composableBuilder(
    column: $table.teamSize,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoundPlansTableOrderingComposer get roundId {
    final $$RoundPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableOrderingComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamPlansTable> {
  $$TeamPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get teamIndex =>
      $composableBuilder(column: $table.teamIndex, builder: (column) => column);

  GeneratedColumn<int> get teamSize =>
      $composableBuilder(column: $table.teamSize, builder: (column) => column);

  $$RoundPlansTableAnnotationComposer get roundId {
    final $$RoundPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> teamMemberPlansRefs<T extends Object>(
    Expression<T> Function($$TeamMemberPlansTableAnnotationComposer a) f,
  ) {
    final $$TeamMemberPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamMemberPlans,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamMemberPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamMemberPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamPlansTable,
          TeamPlan,
          $$TeamPlansTableFilterComposer,
          $$TeamPlansTableOrderingComposer,
          $$TeamPlansTableAnnotationComposer,
          $$TeamPlansTableCreateCompanionBuilder,
          $$TeamPlansTableUpdateCompanionBuilder,
          (TeamPlan, $$TeamPlansTableReferences),
          TeamPlan,
          PrefetchHooks Function({bool roundId, bool teamMemberPlansRefs})
        > {
  $$TeamPlansTableTableManager(_$AppDatabase db, $TeamPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> roundId = const Value.absent(),
                Value<int> teamIndex = const Value.absent(),
                Value<int> teamSize = const Value.absent(),
              }) => TeamPlansCompanion(
                id: id,
                roundId: roundId,
                teamIndex: teamIndex,
                teamSize: teamSize,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int roundId,
                required int teamIndex,
                required int teamSize,
              }) => TeamPlansCompanion.insert(
                id: id,
                roundId: roundId,
                teamIndex: teamIndex,
                teamSize: teamSize,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({roundId = false, teamMemberPlansRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (teamMemberPlansRefs) db.teamMemberPlans,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (roundId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roundId,
                                    referencedTable: $$TeamPlansTableReferences
                                        ._roundIdTable(db),
                                    referencedColumn: $$TeamPlansTableReferences
                                        ._roundIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (teamMemberPlansRefs)
                        await $_getPrefetchedData<
                          TeamPlan,
                          $TeamPlansTable,
                          TeamMemberPlan
                        >(
                          currentTable: table,
                          referencedTable: $$TeamPlansTableReferences
                              ._teamMemberPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).teamMemberPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TeamPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamPlansTable,
      TeamPlan,
      $$TeamPlansTableFilterComposer,
      $$TeamPlansTableOrderingComposer,
      $$TeamPlansTableAnnotationComposer,
      $$TeamPlansTableCreateCompanionBuilder,
      $$TeamPlansTableUpdateCompanionBuilder,
      (TeamPlan, $$TeamPlansTableReferences),
      TeamPlan,
      PrefetchHooks Function({bool roundId, bool teamMemberPlansRefs})
    >;
typedef $$TeamMemberPlansTableCreateCompanionBuilder =
    TeamMemberPlansCompanion Function({
      required int teamId,
      required int playerId,
      Value<int> rowid,
    });
typedef $$TeamMemberPlansTableUpdateCompanionBuilder =
    TeamMemberPlansCompanion Function({
      Value<int> teamId,
      Value<int> playerId,
      Value<int> rowid,
    });

final class $$TeamMemberPlansTableReferences
    extends
        BaseReferences<_$AppDatabase, $TeamMemberPlansTable, TeamMemberPlan> {
  $$TeamMemberPlansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TeamPlansTable _teamIdTable(_$AppDatabase db) =>
      db.teamPlans.createAlias(
        $_aliasNameGenerator(db.teamMemberPlans.teamId, db.teamPlans.id),
      );

  $$TeamPlansTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<int>('team_id')!;

    final manager = $$TeamPlansTableTableManager(
      $_db,
      $_db.teamPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.teamMemberPlans.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TeamMemberPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TeamMemberPlansTable> {
  $$TeamMemberPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeamPlansTableFilterComposer get teamId {
    final $$TeamPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMemberPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamMemberPlansTable> {
  $$TeamMemberPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeamPlansTableOrderingComposer get teamId {
    final $$TeamPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableOrderingComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMemberPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamMemberPlansTable> {
  $$TeamMemberPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TeamPlansTableAnnotationComposer get teamId {
    final $$TeamPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamMemberPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamMemberPlansTable,
          TeamMemberPlan,
          $$TeamMemberPlansTableFilterComposer,
          $$TeamMemberPlansTableOrderingComposer,
          $$TeamMemberPlansTableAnnotationComposer,
          $$TeamMemberPlansTableCreateCompanionBuilder,
          $$TeamMemberPlansTableUpdateCompanionBuilder,
          (TeamMemberPlan, $$TeamMemberPlansTableReferences),
          TeamMemberPlan,
          PrefetchHooks Function({bool teamId, bool playerId})
        > {
  $$TeamMemberPlansTableTableManager(
    _$AppDatabase db,
    $TeamMemberPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamMemberPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamMemberPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamMemberPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> teamId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamMemberPlansCompanion(
                teamId: teamId,
                playerId: playerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int teamId,
                required int playerId,
                Value<int> rowid = const Value.absent(),
              }) => TeamMemberPlansCompanion.insert(
                teamId: teamId,
                playerId: playerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamMemberPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({teamId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (teamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teamId,
                                referencedTable:
                                    $$TeamMemberPlansTableReferences
                                        ._teamIdTable(db),
                                referencedColumn:
                                    $$TeamMemberPlansTableReferences
                                        ._teamIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable:
                                    $$TeamMemberPlansTableReferences
                                        ._playerIdTable(db),
                                referencedColumn:
                                    $$TeamMemberPlansTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TeamMemberPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamMemberPlansTable,
      TeamMemberPlan,
      $$TeamMemberPlansTableFilterComposer,
      $$TeamMemberPlansTableOrderingComposer,
      $$TeamMemberPlansTableAnnotationComposer,
      $$TeamMemberPlansTableCreateCompanionBuilder,
      $$TeamMemberPlansTableUpdateCompanionBuilder,
      (TeamMemberPlan, $$TeamMemberPlansTableReferences),
      TeamMemberPlan,
      PrefetchHooks Function({bool teamId, bool playerId})
    >;
typedef $$MatchPlansTableCreateCompanionBuilder =
    MatchPlansCompanion Function({
      Value<int> id,
      required int roundId,
      required int matchIndex,
      required int teamAId,
      required int teamBId,
      Value<int?> scoreA,
      Value<int?> scoreB,
    });
typedef $$MatchPlansTableUpdateCompanionBuilder =
    MatchPlansCompanion Function({
      Value<int> id,
      Value<int> roundId,
      Value<int> matchIndex,
      Value<int> teamAId,
      Value<int> teamBId,
      Value<int?> scoreA,
      Value<int?> scoreB,
    });

final class $$MatchPlansTableReferences
    extends BaseReferences<_$AppDatabase, $MatchPlansTable, MatchPlan> {
  $$MatchPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoundPlansTable _roundIdTable(_$AppDatabase db) =>
      db.roundPlans.createAlias(
        $_aliasNameGenerator(db.matchPlans.roundId, db.roundPlans.id),
      );

  $$RoundPlansTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<int>('round_id')!;

    final manager = $$RoundPlansTableTableManager(
      $_db,
      $_db.roundPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamPlansTable _teamAIdTable(_$AppDatabase db) =>
      db.teamPlans.createAlias(
        $_aliasNameGenerator(db.matchPlans.teamAId, db.teamPlans.id),
      );

  $$TeamPlansTableProcessedTableManager get teamAId {
    final $_column = $_itemColumn<int>('team_a_id')!;

    final manager = $$TeamPlansTableTableManager(
      $_db,
      $_db.teamPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamAIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamPlansTable _teamBIdTable(_$AppDatabase db) =>
      db.teamPlans.createAlias(
        $_aliasNameGenerator(db.matchPlans.teamBId, db.teamPlans.id),
      );

  $$TeamPlansTableProcessedTableManager get teamBId {
    final $_column = $_itemColumn<int>('team_b_id')!;

    final manager = $$TeamPlansTableTableManager(
      $_db,
      $_db.teamPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamBIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MatchPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MatchPlansTable> {
  $$MatchPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchIndex => $composableBuilder(
    column: $table.matchIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnFilters(column),
  );

  $$RoundPlansTableFilterComposer get roundId {
    final $$RoundPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableFilterComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableFilterComposer get teamAId {
    final $$TeamPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamAId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableFilterComposer get teamBId {
    final $$TeamPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamBId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableFilterComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchPlansTable> {
  $$MatchPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchIndex => $composableBuilder(
    column: $table.matchIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreA => $composableBuilder(
    column: $table.scoreA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreB => $composableBuilder(
    column: $table.scoreB,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoundPlansTableOrderingComposer get roundId {
    final $$RoundPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableOrderingComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableOrderingComposer get teamAId {
    final $$TeamPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamAId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableOrderingComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableOrderingComposer get teamBId {
    final $$TeamPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamBId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableOrderingComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchPlansTable> {
  $$MatchPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get matchIndex => $composableBuilder(
    column: $table.matchIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoreA =>
      $composableBuilder(column: $table.scoreA, builder: (column) => column);

  GeneratedColumn<int> get scoreB =>
      $composableBuilder(column: $table.scoreB, builder: (column) => column);

  $$RoundPlansTableAnnotationComposer get roundId {
    final $$RoundPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.roundPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableAnnotationComposer get teamAId {
    final $$TeamPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamAId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamPlansTableAnnotationComposer get teamBId {
    final $$TeamPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamBId,
      referencedTable: $db.teamPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchPlansTable,
          MatchPlan,
          $$MatchPlansTableFilterComposer,
          $$MatchPlansTableOrderingComposer,
          $$MatchPlansTableAnnotationComposer,
          $$MatchPlansTableCreateCompanionBuilder,
          $$MatchPlansTableUpdateCompanionBuilder,
          (MatchPlan, $$MatchPlansTableReferences),
          MatchPlan,
          PrefetchHooks Function({bool roundId, bool teamAId, bool teamBId})
        > {
  $$MatchPlansTableTableManager(_$AppDatabase db, $MatchPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> roundId = const Value.absent(),
                Value<int> matchIndex = const Value.absent(),
                Value<int> teamAId = const Value.absent(),
                Value<int> teamBId = const Value.absent(),
                Value<int?> scoreA = const Value.absent(),
                Value<int?> scoreB = const Value.absent(),
              }) => MatchPlansCompanion(
                id: id,
                roundId: roundId,
                matchIndex: matchIndex,
                teamAId: teamAId,
                teamBId: teamBId,
                scoreA: scoreA,
                scoreB: scoreB,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int roundId,
                required int matchIndex,
                required int teamAId,
                required int teamBId,
                Value<int?> scoreA = const Value.absent(),
                Value<int?> scoreB = const Value.absent(),
              }) => MatchPlansCompanion.insert(
                id: id,
                roundId: roundId,
                matchIndex: matchIndex,
                teamAId: teamAId,
                teamBId: teamBId,
                scoreA: scoreA,
                scoreB: scoreB,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({roundId = false, teamAId = false, teamBId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (roundId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roundId,
                                    referencedTable: $$MatchPlansTableReferences
                                        ._roundIdTable(db),
                                    referencedColumn:
                                        $$MatchPlansTableReferences
                                            ._roundIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (teamAId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.teamAId,
                                    referencedTable: $$MatchPlansTableReferences
                                        ._teamAIdTable(db),
                                    referencedColumn:
                                        $$MatchPlansTableReferences
                                            ._teamAIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (teamBId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.teamBId,
                                    referencedTable: $$MatchPlansTableReferences
                                        ._teamBIdTable(db),
                                    referencedColumn:
                                        $$MatchPlansTableReferences
                                            ._teamBIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MatchPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchPlansTable,
      MatchPlan,
      $$MatchPlansTableFilterComposer,
      $$MatchPlansTableOrderingComposer,
      $$MatchPlansTableAnnotationComposer,
      $$MatchPlansTableCreateCompanionBuilder,
      $$MatchPlansTableUpdateCompanionBuilder,
      (MatchPlan, $$MatchPlansTableReferences),
      MatchPlan,
      PrefetchHooks Function({bool roundId, bool teamAId, bool teamBId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$TournamentsTableTableManager get tournaments =>
      $$TournamentsTableTableManager(_db, _db.tournaments);
  $$TournamentPlayersTableTableManager get tournamentPlayers =>
      $$TournamentPlayersTableTableManager(_db, _db.tournamentPlayers);
  $$RoundPlansTableTableManager get roundPlans =>
      $$RoundPlansTableTableManager(_db, _db.roundPlans);
  $$TeamPlansTableTableManager get teamPlans =>
      $$TeamPlansTableTableManager(_db, _db.teamPlans);
  $$TeamMemberPlansTableTableManager get teamMemberPlans =>
      $$TeamMemberPlansTableTableManager(_db, _db.teamMemberPlans);
  $$MatchPlansTableTableManager get matchPlans =>
      $$MatchPlansTableTableManager(_db, _db.matchPlans);
}
