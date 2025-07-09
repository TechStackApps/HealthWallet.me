// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FhirResourceTable extends FhirResource
    with TableInfo<$FhirResourceTable, FhirResourceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FhirResourceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resourceTypeMeta =
      const VerificationMeta('resourceType');
  @override
  late final GeneratedColumn<String> resourceType = GeneratedColumn<String>(
      'resource_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resourceMeta =
      const VerificationMeta('resource');
  @override
  late final GeneratedColumn<String> resource = GeneratedColumn<String>(
      'resource', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, resourceType, resource, isFavorite, sourceId, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fhir_resource';
  @override
  VerificationContext validateIntegrity(Insertable<FhirResourceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('resource_type')) {
      context.handle(
          _resourceTypeMeta,
          resourceType.isAcceptableOrUnknown(
              data['resource_type']!, _resourceTypeMeta));
    } else if (isInserting) {
      context.missing(_resourceTypeMeta);
    }
    if (data.containsKey('resource')) {
      context.handle(_resourceMeta,
          resource.isAcceptableOrUnknown(data['resource']!, _resourceMeta));
    } else if (isInserting) {
      context.missing(_resourceMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FhirResourceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FhirResourceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      resourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_type'])!,
      resource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FhirResourceTable createAlias(String alias) {
    return $FhirResourceTable(attachedDatabase, alias);
  }
}

class FhirResourceData extends DataClass
    implements Insertable<FhirResourceData> {
  final String id;
  final String resourceType;
  final String resource;
  final bool isFavorite;
  final String? sourceId;
  final DateTime updatedAt;
  const FhirResourceData(
      {required this.id,
      required this.resourceType,
      required this.resource,
      required this.isFavorite,
      this.sourceId,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['resource_type'] = Variable<String>(resourceType);
    map['resource'] = Variable<String>(resource);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FhirResourceCompanion toCompanion(bool nullToAbsent) {
    return FhirResourceCompanion(
      id: Value(id),
      resourceType: Value(resourceType),
      resource: Value(resource),
      isFavorite: Value(isFavorite),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      updatedAt: Value(updatedAt),
    );
  }

  factory FhirResourceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FhirResourceData(
      id: serializer.fromJson<String>(json['id']),
      resourceType: serializer.fromJson<String>(json['resourceType']),
      resource: serializer.fromJson<String>(json['resource']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'resourceType': serializer.toJson<String>(resourceType),
      'resource': serializer.toJson<String>(resource),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'sourceId': serializer.toJson<String?>(sourceId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FhirResourceData copyWith(
          {String? id,
          String? resourceType,
          String? resource,
          bool? isFavorite,
          Value<String?> sourceId = const Value.absent(),
          DateTime? updatedAt}) =>
      FhirResourceData(
        id: id ?? this.id,
        resourceType: resourceType ?? this.resourceType,
        resource: resource ?? this.resource,
        isFavorite: isFavorite ?? this.isFavorite,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  FhirResourceData copyWithCompanion(FhirResourceCompanion data) {
    return FhirResourceData(
      id: data.id.present ? data.id.value : this.id,
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      resource: data.resource.present ? data.resource.value : this.resource,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FhirResourceData(')
          ..write('id: $id, ')
          ..write('resourceType: $resourceType, ')
          ..write('resource: $resource, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sourceId: $sourceId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, resourceType, resource, isFavorite, sourceId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FhirResourceData &&
          other.id == this.id &&
          other.resourceType == this.resourceType &&
          other.resource == this.resource &&
          other.isFavorite == this.isFavorite &&
          other.sourceId == this.sourceId &&
          other.updatedAt == this.updatedAt);
}

class FhirResourceCompanion extends UpdateCompanion<FhirResourceData> {
  final Value<String> id;
  final Value<String> resourceType;
  final Value<String> resource;
  final Value<bool> isFavorite;
  final Value<String?> sourceId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FhirResourceCompanion({
    this.id = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resource = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FhirResourceCompanion.insert({
    required String id,
    required String resourceType,
    required String resource,
    this.isFavorite = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        resourceType = Value(resourceType),
        resource = Value(resource);
  static Insertable<FhirResourceData> custom({
    Expression<String>? id,
    Expression<String>? resourceType,
    Expression<String>? resource,
    Expression<bool>? isFavorite,
    Expression<String>? sourceId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resourceType != null) 'resource_type': resourceType,
      if (resource != null) 'resource': resource,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (sourceId != null) 'source_id': sourceId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FhirResourceCompanion copyWith(
      {Value<String>? id,
      Value<String>? resourceType,
      Value<String>? resource,
      Value<bool>? isFavorite,
      Value<String?>? sourceId,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return FhirResourceCompanion(
      id: id ?? this.id,
      resourceType: resourceType ?? this.resourceType,
      resource: resource ?? this.resource,
      isFavorite: isFavorite ?? this.isFavorite,
      sourceId: sourceId ?? this.sourceId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(resourceType.value);
    }
    if (resource.present) {
      map['resource'] = Variable<String>(resource.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FhirResourceCompanion(')
          ..write('id: $id, ')
          ..write('resourceType: $resourceType, ')
          ..write('resource: $resource, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sourceId: $sourceId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SourcesTable extends Sources with TableInfo<$SourcesTable, Source> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
      'logo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, logo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sources';
  @override
  VerificationContext validateIntegrity(Insertable<Source> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Source map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Source(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo']),
    );
  }

  @override
  $SourcesTable createAlias(String alias) {
    return $SourcesTable(attachedDatabase, alias);
  }
}

class Source extends DataClass implements Insertable<Source> {
  final String id;
  final String? name;
  final String? logo;
  const Source({required this.id, this.name, this.logo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    return map;
  }

  SourcesCompanion toCompanion(bool nullToAbsent) {
    return SourcesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
    );
  }

  factory Source.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Source(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      logo: serializer.fromJson<String?>(json['logo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'logo': serializer.toJson<String?>(logo),
    };
  }

  Source copyWith(
          {String? id,
          Value<String?> name = const Value.absent(),
          Value<String?> logo = const Value.absent()}) =>
      Source(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        logo: logo.present ? logo.value : this.logo,
      );
  Source copyWithCompanion(SourcesCompanion data) {
    return Source(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      logo: data.logo.present ? data.logo.value : this.logo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Source(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logo: $logo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, logo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Source &&
          other.id == this.id &&
          other.name == this.name &&
          other.logo == this.logo);
}

class SourcesCompanion extends UpdateCompanion<Source> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> logo;
  final Value<int> rowid;
  const SourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.logo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SourcesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.logo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Source> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? logo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (logo != null) 'logo': logo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SourcesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String?>? logo,
      Value<int>? rowid}) {
    return SourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logo: $logo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FhirResourceTable fhirResource = $FhirResourceTable(this);
  late final $SourcesTable sources = $SourcesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [fhirResource, sources];
}

typedef $$FhirResourceTableCreateCompanionBuilder = FhirResourceCompanion
    Function({
  required String id,
  required String resourceType,
  required String resource,
  Value<bool> isFavorite,
  Value<String?> sourceId,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$FhirResourceTableUpdateCompanionBuilder = FhirResourceCompanion
    Function({
  Value<String> id,
  Value<String> resourceType,
  Value<String> resource,
  Value<bool> isFavorite,
  Value<String?> sourceId,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$FhirResourceTableFilterComposer
    extends Composer<_$AppDatabase, $FhirResourceTable> {
  $$FhirResourceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resource => $composableBuilder(
      column: $table.resource, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$FhirResourceTableOrderingComposer
    extends Composer<_$AppDatabase, $FhirResourceTable> {
  $$FhirResourceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceType => $composableBuilder(
      column: $table.resourceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resource => $composableBuilder(
      column: $table.resource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$FhirResourceTableAnnotationComposer
    extends Composer<_$AppDatabase, $FhirResourceTable> {
  $$FhirResourceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get resourceType => $composableBuilder(
      column: $table.resourceType, builder: (column) => column);

  GeneratedColumn<String> get resource =>
      $composableBuilder(column: $table.resource, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FhirResourceTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FhirResourceTable,
    FhirResourceData,
    $$FhirResourceTableFilterComposer,
    $$FhirResourceTableOrderingComposer,
    $$FhirResourceTableAnnotationComposer,
    $$FhirResourceTableCreateCompanionBuilder,
    $$FhirResourceTableUpdateCompanionBuilder,
    (
      FhirResourceData,
      BaseReferences<_$AppDatabase, $FhirResourceTable, FhirResourceData>
    ),
    FhirResourceData,
    PrefetchHooks Function()> {
  $$FhirResourceTableTableManager(_$AppDatabase db, $FhirResourceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FhirResourceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FhirResourceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FhirResourceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> resourceType = const Value.absent(),
            Value<String> resource = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<String?> sourceId = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FhirResourceCompanion(
            id: id,
            resourceType: resourceType,
            resource: resource,
            isFavorite: isFavorite,
            sourceId: sourceId,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String resourceType,
            required String resource,
            Value<bool> isFavorite = const Value.absent(),
            Value<String?> sourceId = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FhirResourceCompanion.insert(
            id: id,
            resourceType: resourceType,
            resource: resource,
            isFavorite: isFavorite,
            sourceId: sourceId,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FhirResourceTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FhirResourceTable,
    FhirResourceData,
    $$FhirResourceTableFilterComposer,
    $$FhirResourceTableOrderingComposer,
    $$FhirResourceTableAnnotationComposer,
    $$FhirResourceTableCreateCompanionBuilder,
    $$FhirResourceTableUpdateCompanionBuilder,
    (
      FhirResourceData,
      BaseReferences<_$AppDatabase, $FhirResourceTable, FhirResourceData>
    ),
    FhirResourceData,
    PrefetchHooks Function()>;
typedef $$SourcesTableCreateCompanionBuilder = SourcesCompanion Function({
  required String id,
  Value<String?> name,
  Value<String?> logo,
  Value<int> rowid,
});
typedef $$SourcesTableUpdateCompanionBuilder = SourcesCompanion Function({
  Value<String> id,
  Value<String?> name,
  Value<String?> logo,
  Value<int> rowid,
});

class $$SourcesTableFilterComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnFilters(column));
}

class $$SourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnOrderings(column));
}

class $$SourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SourcesTable> {
  $$SourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logo =>
      $composableBuilder(column: $table.logo, builder: (column) => column);
}

class $$SourcesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SourcesTable,
    Source,
    $$SourcesTableFilterComposer,
    $$SourcesTableOrderingComposer,
    $$SourcesTableAnnotationComposer,
    $$SourcesTableCreateCompanionBuilder,
    $$SourcesTableUpdateCompanionBuilder,
    (Source, BaseReferences<_$AppDatabase, $SourcesTable, Source>),
    Source,
    PrefetchHooks Function()> {
  $$SourcesTableTableManager(_$AppDatabase db, $SourcesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> logo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SourcesCompanion(
            id: id,
            name: name,
            logo: logo,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> name = const Value.absent(),
            Value<String?> logo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SourcesCompanion.insert(
            id: id,
            name: name,
            logo: logo,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SourcesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SourcesTable,
    Source,
    $$SourcesTableFilterComposer,
    $$SourcesTableOrderingComposer,
    $$SourcesTableAnnotationComposer,
    $$SourcesTableCreateCompanionBuilder,
    $$SourcesTableUpdateCompanionBuilder,
    (Source, BaseReferences<_$AppDatabase, $SourcesTable, Source>),
    Source,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FhirResourceTableTableManager get fhirResource =>
      $$FhirResourceTableTableManager(_db, _db.fhirResource);
  $$SourcesTableTableManager get sources =>
      $$SourcesTableTableManager(_db, _db.sources);
}
