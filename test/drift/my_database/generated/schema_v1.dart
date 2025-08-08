// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class FhirResource extends Table
    with TableInfo<FhirResource, FhirResourceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FhirResource(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<String> resourceType = GeneratedColumn<String>(
      'resource_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<String> resourceId = GeneratedColumn<String>(
      'resource_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  late final GeneratedColumn<String> resourceRaw = GeneratedColumn<String>(
      'resource_raw', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> encounterId = GeneratedColumn<String>(
      'encounter_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceId,
        resourceType,
        resourceId,
        title,
        date,
        resourceRaw,
        encounterId,
        subjectId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fhir_resource';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FhirResourceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FhirResourceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id']),
      resourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_type']),
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      resourceRaw: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_raw'])!,
      encounterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}encounter_id']),
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id']),
    );
  }

  @override
  FhirResource createAlias(String alias) {
    return FhirResource(attachedDatabase, alias);
  }
}

class FhirResourceData extends DataClass
    implements Insertable<FhirResourceData> {
  final String id;
  final String? sourceId;
  final String? resourceType;
  final String? resourceId;
  final String? title;
  final DateTime? date;
  final String resourceRaw;
  final String? encounterId;
  final String? subjectId;
  const FhirResourceData(
      {required this.id,
      this.sourceId,
      this.resourceType,
      this.resourceId,
      this.title,
      this.date,
      required this.resourceRaw,
      this.encounterId,
      this.subjectId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    if (!nullToAbsent || resourceType != null) {
      map['resource_type'] = Variable<String>(resourceType);
    }
    if (!nullToAbsent || resourceId != null) {
      map['resource_id'] = Variable<String>(resourceId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    map['resource_raw'] = Variable<String>(resourceRaw);
    if (!nullToAbsent || encounterId != null) {
      map['encounter_id'] = Variable<String>(encounterId);
    }
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    return map;
  }

  FhirResourceCompanion toCompanion(bool nullToAbsent) {
    return FhirResourceCompanion(
      id: Value(id),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      resourceType: resourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceType),
      resourceId: resourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      resourceRaw: Value(resourceRaw),
      encounterId: encounterId == null && nullToAbsent
          ? const Value.absent()
          : Value(encounterId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
    );
  }

  factory FhirResourceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FhirResourceData(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      resourceType: serializer.fromJson<String?>(json['resourceType']),
      resourceId: serializer.fromJson<String?>(json['resourceId']),
      title: serializer.fromJson<String?>(json['title']),
      date: serializer.fromJson<DateTime?>(json['date']),
      resourceRaw: serializer.fromJson<String>(json['resourceRaw']),
      encounterId: serializer.fromJson<String?>(json['encounterId']),
      subjectId: serializer.fromJson<String?>(json['subjectId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String?>(sourceId),
      'resourceType': serializer.toJson<String?>(resourceType),
      'resourceId': serializer.toJson<String?>(resourceId),
      'title': serializer.toJson<String?>(title),
      'date': serializer.toJson<DateTime?>(date),
      'resourceRaw': serializer.toJson<String>(resourceRaw),
      'encounterId': serializer.toJson<String?>(encounterId),
      'subjectId': serializer.toJson<String?>(subjectId),
    };
  }

  FhirResourceData copyWith(
          {String? id,
          Value<String?> sourceId = const Value.absent(),
          Value<String?> resourceType = const Value.absent(),
          Value<String?> resourceId = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          String? resourceRaw,
          Value<String?> encounterId = const Value.absent(),
          Value<String?> subjectId = const Value.absent()}) =>
      FhirResourceData(
        id: id ?? this.id,
        sourceId: sourceId.present ? sourceId.value : this.sourceId,
        resourceType:
            resourceType.present ? resourceType.value : this.resourceType,
        resourceId: resourceId.present ? resourceId.value : this.resourceId,
        title: title.present ? title.value : this.title,
        date: date.present ? date.value : this.date,
        resourceRaw: resourceRaw ?? this.resourceRaw,
        encounterId: encounterId.present ? encounterId.value : this.encounterId,
        subjectId: subjectId.present ? subjectId.value : this.subjectId,
      );
  FhirResourceData copyWithCompanion(FhirResourceCompanion data) {
    return FhirResourceData(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      resourceType: data.resourceType.present
          ? data.resourceType.value
          : this.resourceType,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      title: data.title.present ? data.title.value : this.title,
      date: data.date.present ? data.date.value : this.date,
      resourceRaw:
          data.resourceRaw.present ? data.resourceRaw.value : this.resourceRaw,
      encounterId:
          data.encounterId.present ? data.encounterId.value : this.encounterId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FhirResourceData(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('resourceRaw: $resourceRaw, ')
          ..write('encounterId: $encounterId, ')
          ..write('subjectId: $subjectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, resourceType, resourceId, title,
      date, resourceRaw, encounterId, subjectId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FhirResourceData &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.resourceType == this.resourceType &&
          other.resourceId == this.resourceId &&
          other.title == this.title &&
          other.date == this.date &&
          other.resourceRaw == this.resourceRaw &&
          other.encounterId == this.encounterId &&
          other.subjectId == this.subjectId);
}

class FhirResourceCompanion extends UpdateCompanion<FhirResourceData> {
  final Value<String> id;
  final Value<String?> sourceId;
  final Value<String?> resourceType;
  final Value<String?> resourceId;
  final Value<String?> title;
  final Value<DateTime?> date;
  final Value<String> resourceRaw;
  final Value<String?> encounterId;
  final Value<String?> subjectId;
  final Value<int> rowid;
  const FhirResourceCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.resourceRaw = const Value.absent(),
    this.encounterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FhirResourceCompanion.insert({
    required String id,
    this.sourceId = const Value.absent(),
    this.resourceType = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    required String resourceRaw,
    this.encounterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        resourceRaw = Value(resourceRaw);
  static Insertable<FhirResourceData> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<String>? resourceType,
    Expression<String>? resourceId,
    Expression<String>? title,
    Expression<DateTime>? date,
    Expression<String>? resourceRaw,
    Expression<String>? encounterId,
    Expression<String>? subjectId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (resourceType != null) 'resource_type': resourceType,
      if (resourceId != null) 'resource_id': resourceId,
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (resourceRaw != null) 'resource_raw': resourceRaw,
      if (encounterId != null) 'encounter_id': encounterId,
      if (subjectId != null) 'subject_id': subjectId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FhirResourceCompanion copyWith(
      {Value<String>? id,
      Value<String?>? sourceId,
      Value<String?>? resourceType,
      Value<String?>? resourceId,
      Value<String?>? title,
      Value<DateTime?>? date,
      Value<String>? resourceRaw,
      Value<String?>? encounterId,
      Value<String?>? subjectId,
      Value<int>? rowid}) {
    return FhirResourceCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId ?? this.resourceId,
      title: title ?? this.title,
      date: date ?? this.date,
      resourceRaw: resourceRaw ?? this.resourceRaw,
      encounterId: encounterId ?? this.encounterId,
      subjectId: subjectId ?? this.subjectId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (resourceType.present) {
      map['resource_type'] = Variable<String>(resourceType.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<String>(resourceId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (resourceRaw.present) {
      map['resource_raw'] = Variable<String>(resourceRaw.value);
    }
    if (encounterId.present) {
      map['encounter_id'] = Variable<String>(encounterId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
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
          ..write('sourceId: $sourceId, ')
          ..write('resourceType: $resourceType, ')
          ..write('resourceId: $resourceId, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('resourceRaw: $resourceRaw, ')
          ..write('encounterId: $encounterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Sources extends Table with TableInfo<Sources, SourcesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Sources(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SourcesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SourcesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo']),
    );
  }

  @override
  Sources createAlias(String alias) {
    return Sources(attachedDatabase, alias);
  }
}

class SourcesData extends DataClass implements Insertable<SourcesData> {
  final String id;
  final String? name;
  final String? logo;
  const SourcesData({required this.id, this.name, this.logo});
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

  factory SourcesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SourcesData(
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

  SourcesData copyWith(
          {String? id,
          Value<String?> name = const Value.absent(),
          Value<String?> logo = const Value.absent()}) =>
      SourcesData(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        logo: logo.present ? logo.value : this.logo,
      );
  SourcesData copyWithCompanion(SourcesCompanion data) {
    return SourcesData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      logo: data.logo.present ? data.logo.value : this.logo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SourcesData(')
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
      (other is SourcesData &&
          other.id == this.id &&
          other.name == this.name &&
          other.logo == this.logo);
}

class SourcesCompanion extends UpdateCompanion<SourcesData> {
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
  static Insertable<SourcesData> custom({
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final FhirResource fhirResource = FhirResource(this);
  late final Sources sources = Sources(this);
  late final Index resourceType = Index('resourceType',
      'CREATE INDEX resourceType ON fhir_resource (resource_type)');
  late final Index resourceId = Index(
      'resourceId', 'CREATE INDEX resourceId ON fhir_resource (resource_id)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [fhirResource, sources, resourceType, resourceId];
  @override
  int get schemaVersion => 1;
}
