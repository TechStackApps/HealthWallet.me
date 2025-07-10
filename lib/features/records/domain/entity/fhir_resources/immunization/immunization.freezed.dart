// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'immunization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Immunization _$ImmunizationFromJson(Map<String, dynamic> json) {
  return _Immunization.fromJson(json);
}

/// @nodoc
mixin _$Immunization {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'provided_date')
  String? get providedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'manufacturer_text')
  String? get manufacturerText => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_lot_number')
  bool? get hasLotNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'lot_number')
  String? get lotNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'lot_number_expiration_date')
  String? get lotNumberExpirationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_dose_quantity')
  bool? get hasDoseQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'dose_quantity')
  Coding? get doseQuantity => throw _privateConstructorUsedError;
  String? get requester => throw _privateConstructorUsedError;
  String? get reported => throw _privateConstructorUsedError;
  String? get performer => throw _privateConstructorUsedError;
  List<Coding>? get route => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_route')
  bool? get hasRoute => throw _privateConstructorUsedError;
  List<Coding>? get site => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_site')
  bool? get hasSite => throw _privateConstructorUsedError;
  Reference? get patient => throw _privateConstructorUsedError;
  List<Note>? get note => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

  /// Serializes this Immunization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImmunizationCopyWith<Immunization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImmunizationCopyWith<$Res> {
  factory $ImmunizationCopyWith(
          Immunization value, $Res Function(Immunization) then) =
      _$ImmunizationCopyWithImpl<$Res, Immunization>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'provided_date') String? providedDate,
      @JsonKey(name: 'manufacturer_text') String? manufacturerText,
      @JsonKey(name: 'has_lot_number') bool? hasLotNumber,
      @JsonKey(name: 'lot_number') String? lotNumber,
      @JsonKey(name: 'lot_number_expiration_date')
      String? lotNumberExpirationDate,
      @JsonKey(name: 'has_dose_quantity') bool? hasDoseQuantity,
      @JsonKey(name: 'dose_quantity') Coding? doseQuantity,
      String? requester,
      String? reported,
      String? performer,
      List<Coding>? route,
      @JsonKey(name: 'has_route') bool? hasRoute,
      List<Coding>? site,
      @JsonKey(name: 'has_site') bool? hasSite,
      Reference? patient,
      List<Note>? note,
      String? location});

  $CodingCopyWith<$Res>? get doseQuantity;
  $ReferenceCopyWith<$Res>? get patient;
}

/// @nodoc
class _$ImmunizationCopyWithImpl<$Res, $Val extends Immunization>
    implements $ImmunizationCopyWith<$Res> {
  _$ImmunizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? providedDate = freezed,
    Object? manufacturerText = freezed,
    Object? hasLotNumber = freezed,
    Object? lotNumber = freezed,
    Object? lotNumberExpirationDate = freezed,
    Object? hasDoseQuantity = freezed,
    Object? doseQuantity = freezed,
    Object? requester = freezed,
    Object? reported = freezed,
    Object? performer = freezed,
    Object? route = freezed,
    Object? hasRoute = freezed,
    Object? site = freezed,
    Object? hasSite = freezed,
    Object? patient = freezed,
    Object? note = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      providedDate: freezed == providedDate
          ? _value.providedDate
          : providedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturerText: freezed == manufacturerText
          ? _value.manufacturerText
          : manufacturerText // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLotNumber: freezed == hasLotNumber
          ? _value.hasLotNumber
          : hasLotNumber // ignore: cast_nullable_to_non_nullable
              as bool?,
      lotNumber: freezed == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      lotNumberExpirationDate: freezed == lotNumberExpirationDate
          ? _value.lotNumberExpirationDate
          : lotNumberExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDoseQuantity: freezed == hasDoseQuantity
          ? _value.hasDoseQuantity
          : hasDoseQuantity // ignore: cast_nullable_to_non_nullable
              as bool?,
      doseQuantity: freezed == doseQuantity
          ? _value.doseQuantity
          : doseQuantity // ignore: cast_nullable_to_non_nullable
              as Coding?,
      requester: freezed == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as String?,
      reported: freezed == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as String?,
      performer: freezed == performer
          ? _value.performer
          : performer // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasRoute: freezed == hasRoute
          ? _value.hasRoute
          : hasRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
      site: freezed == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasSite: freezed == hasSite
          ? _value.hasSite
          : hasSite // ignore: cast_nullable_to_non_nullable
              as bool?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodingCopyWith<$Res>? get doseQuantity {
    if (_value.doseQuantity == null) {
      return null;
    }

    return $CodingCopyWith<$Res>(_value.doseQuantity!, (value) {
      return _then(_value.copyWith(doseQuantity: value) as $Val);
    });
  }

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImmunizationImplCopyWith<$Res>
    implements $ImmunizationCopyWith<$Res> {
  factory _$$ImmunizationImplCopyWith(
          _$ImmunizationImpl value, $Res Function(_$ImmunizationImpl) then) =
      __$$ImmunizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? status,
      @JsonKey(name: 'provided_date') String? providedDate,
      @JsonKey(name: 'manufacturer_text') String? manufacturerText,
      @JsonKey(name: 'has_lot_number') bool? hasLotNumber,
      @JsonKey(name: 'lot_number') String? lotNumber,
      @JsonKey(name: 'lot_number_expiration_date')
      String? lotNumberExpirationDate,
      @JsonKey(name: 'has_dose_quantity') bool? hasDoseQuantity,
      @JsonKey(name: 'dose_quantity') Coding? doseQuantity,
      String? requester,
      String? reported,
      String? performer,
      List<Coding>? route,
      @JsonKey(name: 'has_route') bool? hasRoute,
      List<Coding>? site,
      @JsonKey(name: 'has_site') bool? hasSite,
      Reference? patient,
      List<Note>? note,
      String? location});

  @override
  $CodingCopyWith<$Res>? get doseQuantity;
  @override
  $ReferenceCopyWith<$Res>? get patient;
}

/// @nodoc
class __$$ImmunizationImplCopyWithImpl<$Res>
    extends _$ImmunizationCopyWithImpl<$Res, _$ImmunizationImpl>
    implements _$$ImmunizationImplCopyWith<$Res> {
  __$$ImmunizationImplCopyWithImpl(
      _$ImmunizationImpl _value, $Res Function(_$ImmunizationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? providedDate = freezed,
    Object? manufacturerText = freezed,
    Object? hasLotNumber = freezed,
    Object? lotNumber = freezed,
    Object? lotNumberExpirationDate = freezed,
    Object? hasDoseQuantity = freezed,
    Object? doseQuantity = freezed,
    Object? requester = freezed,
    Object? reported = freezed,
    Object? performer = freezed,
    Object? route = freezed,
    Object? hasRoute = freezed,
    Object? site = freezed,
    Object? hasSite = freezed,
    Object? patient = freezed,
    Object? note = freezed,
    Object? location = freezed,
  }) {
    return _then(_$ImmunizationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      providedDate: freezed == providedDate
          ? _value.providedDate
          : providedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturerText: freezed == manufacturerText
          ? _value.manufacturerText
          : manufacturerText // ignore: cast_nullable_to_non_nullable
              as String?,
      hasLotNumber: freezed == hasLotNumber
          ? _value.hasLotNumber
          : hasLotNumber // ignore: cast_nullable_to_non_nullable
              as bool?,
      lotNumber: freezed == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      lotNumberExpirationDate: freezed == lotNumberExpirationDate
          ? _value.lotNumberExpirationDate
          : lotNumberExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDoseQuantity: freezed == hasDoseQuantity
          ? _value.hasDoseQuantity
          : hasDoseQuantity // ignore: cast_nullable_to_non_nullable
              as bool?,
      doseQuantity: freezed == doseQuantity
          ? _value.doseQuantity
          : doseQuantity // ignore: cast_nullable_to_non_nullable
              as Coding?,
      requester: freezed == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as String?,
      reported: freezed == reported
          ? _value.reported
          : reported // ignore: cast_nullable_to_non_nullable
              as String?,
      performer: freezed == performer
          ? _value.performer
          : performer // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value._route
          : route // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasRoute: freezed == hasRoute
          ? _value.hasRoute
          : hasRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
      site: freezed == site
          ? _value._site
          : site // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasSite: freezed == hasSite
          ? _value.hasSite
          : hasSite // ignore: cast_nullable_to_non_nullable
              as bool?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      note: freezed == note
          ? _value._note
          : note // ignore: cast_nullable_to_non_nullable
              as List<Note>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImmunizationImpl implements _Immunization {
  _$ImmunizationImpl(
      {this.id,
      this.title,
      this.status,
      @JsonKey(name: 'provided_date') this.providedDate,
      @JsonKey(name: 'manufacturer_text') this.manufacturerText,
      @JsonKey(name: 'has_lot_number') this.hasLotNumber,
      @JsonKey(name: 'lot_number') this.lotNumber,
      @JsonKey(name: 'lot_number_expiration_date') this.lotNumberExpirationDate,
      @JsonKey(name: 'has_dose_quantity') this.hasDoseQuantity,
      @JsonKey(name: 'dose_quantity') this.doseQuantity,
      this.requester,
      this.reported,
      this.performer,
      final List<Coding>? route,
      @JsonKey(name: 'has_route') this.hasRoute,
      final List<Coding>? site,
      @JsonKey(name: 'has_site') this.hasSite,
      this.patient,
      final List<Note>? note,
      this.location})
      : _route = route,
        _site = site,
        _note = note;

  factory _$ImmunizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImmunizationImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? status;
  @override
  @JsonKey(name: 'provided_date')
  final String? providedDate;
  @override
  @JsonKey(name: 'manufacturer_text')
  final String? manufacturerText;
  @override
  @JsonKey(name: 'has_lot_number')
  final bool? hasLotNumber;
  @override
  @JsonKey(name: 'lot_number')
  final String? lotNumber;
  @override
  @JsonKey(name: 'lot_number_expiration_date')
  final String? lotNumberExpirationDate;
  @override
  @JsonKey(name: 'has_dose_quantity')
  final bool? hasDoseQuantity;
  @override
  @JsonKey(name: 'dose_quantity')
  final Coding? doseQuantity;
  @override
  final String? requester;
  @override
  final String? reported;
  @override
  final String? performer;
  final List<Coding>? _route;
  @override
  List<Coding>? get route {
    final value = _route;
    if (value == null) return null;
    if (_route is EqualUnmodifiableListView) return _route;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_route')
  final bool? hasRoute;
  final List<Coding>? _site;
  @override
  List<Coding>? get site {
    final value = _site;
    if (value == null) return null;
    if (_site is EqualUnmodifiableListView) return _site;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_site')
  final bool? hasSite;
  @override
  final Reference? patient;
  final List<Note>? _note;
  @override
  List<Note>? get note {
    final value = _note;
    if (value == null) return null;
    if (_note is EqualUnmodifiableListView) return _note;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? location;

  @override
  String toString() {
    return 'Immunization(id: $id, title: $title, status: $status, providedDate: $providedDate, manufacturerText: $manufacturerText, hasLotNumber: $hasLotNumber, lotNumber: $lotNumber, lotNumberExpirationDate: $lotNumberExpirationDate, hasDoseQuantity: $hasDoseQuantity, doseQuantity: $doseQuantity, requester: $requester, reported: $reported, performer: $performer, route: $route, hasRoute: $hasRoute, site: $site, hasSite: $hasSite, patient: $patient, note: $note, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImmunizationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.providedDate, providedDate) ||
                other.providedDate == providedDate) &&
            (identical(other.manufacturerText, manufacturerText) ||
                other.manufacturerText == manufacturerText) &&
            (identical(other.hasLotNumber, hasLotNumber) ||
                other.hasLotNumber == hasLotNumber) &&
            (identical(other.lotNumber, lotNumber) ||
                other.lotNumber == lotNumber) &&
            (identical(
                    other.lotNumberExpirationDate, lotNumberExpirationDate) ||
                other.lotNumberExpirationDate == lotNumberExpirationDate) &&
            (identical(other.hasDoseQuantity, hasDoseQuantity) ||
                other.hasDoseQuantity == hasDoseQuantity) &&
            (identical(other.doseQuantity, doseQuantity) ||
                other.doseQuantity == doseQuantity) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.reported, reported) ||
                other.reported == reported) &&
            (identical(other.performer, performer) ||
                other.performer == performer) &&
            const DeepCollectionEquality().equals(other._route, _route) &&
            (identical(other.hasRoute, hasRoute) ||
                other.hasRoute == hasRoute) &&
            const DeepCollectionEquality().equals(other._site, _site) &&
            (identical(other.hasSite, hasSite) || other.hasSite == hasSite) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            const DeepCollectionEquality().equals(other._note, _note) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        status,
        providedDate,
        manufacturerText,
        hasLotNumber,
        lotNumber,
        lotNumberExpirationDate,
        hasDoseQuantity,
        doseQuantity,
        requester,
        reported,
        performer,
        const DeepCollectionEquality().hash(_route),
        hasRoute,
        const DeepCollectionEquality().hash(_site),
        hasSite,
        patient,
        const DeepCollectionEquality().hash(_note),
        location
      ]);

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImmunizationImplCopyWith<_$ImmunizationImpl> get copyWith =>
      __$$ImmunizationImplCopyWithImpl<_$ImmunizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImmunizationImplToJson(
      this,
    );
  }
}

abstract class _Immunization implements Immunization {
  factory _Immunization(
      {final String? id,
      final String? title,
      final String? status,
      @JsonKey(name: 'provided_date') final String? providedDate,
      @JsonKey(name: 'manufacturer_text') final String? manufacturerText,
      @JsonKey(name: 'has_lot_number') final bool? hasLotNumber,
      @JsonKey(name: 'lot_number') final String? lotNumber,
      @JsonKey(name: 'lot_number_expiration_date')
      final String? lotNumberExpirationDate,
      @JsonKey(name: 'has_dose_quantity') final bool? hasDoseQuantity,
      @JsonKey(name: 'dose_quantity') final Coding? doseQuantity,
      final String? requester,
      final String? reported,
      final String? performer,
      final List<Coding>? route,
      @JsonKey(name: 'has_route') final bool? hasRoute,
      final List<Coding>? site,
      @JsonKey(name: 'has_site') final bool? hasSite,
      final Reference? patient,
      final List<Note>? note,
      final String? location}) = _$ImmunizationImpl;

  factory _Immunization.fromJson(Map<String, dynamic> json) =
      _$ImmunizationImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get status;
  @override
  @JsonKey(name: 'provided_date')
  String? get providedDate;
  @override
  @JsonKey(name: 'manufacturer_text')
  String? get manufacturerText;
  @override
  @JsonKey(name: 'has_lot_number')
  bool? get hasLotNumber;
  @override
  @JsonKey(name: 'lot_number')
  String? get lotNumber;
  @override
  @JsonKey(name: 'lot_number_expiration_date')
  String? get lotNumberExpirationDate;
  @override
  @JsonKey(name: 'has_dose_quantity')
  bool? get hasDoseQuantity;
  @override
  @JsonKey(name: 'dose_quantity')
  Coding? get doseQuantity;
  @override
  String? get requester;
  @override
  String? get reported;
  @override
  String? get performer;
  @override
  List<Coding>? get route;
  @override
  @JsonKey(name: 'has_route')
  bool? get hasRoute;
  @override
  List<Coding>? get site;
  @override
  @JsonKey(name: 'has_site')
  bool? get hasSite;
  @override
  Reference? get patient;
  @override
  List<Note>? get note;
  @override
  String? get location;

  /// Create a copy of Immunization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImmunizationImplCopyWith<_$ImmunizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
