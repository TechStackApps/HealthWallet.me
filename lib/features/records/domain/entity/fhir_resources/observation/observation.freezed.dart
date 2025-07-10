// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Observation _$ObservationFromJson(Map<String, dynamic> json) {
  return _Observation.fromJson(json);
}

/// @nodoc
mixin _$Observation {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  CodeableConcept get code => throw _privateConstructorUsedError;
  ValueQuantity? get valueQuantity => throw _privateConstructorUsedError;
  DateTime? get effectiveDateTime => throw _privateConstructorUsedError;

  /// Serializes this Observation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ObservationCopyWith<Observation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObservationCopyWith<$Res> {
  factory $ObservationCopyWith(
          Observation value, $Res Function(Observation) then) =
      _$ObservationCopyWithImpl<$Res, Observation>;
  @useResult
  $Res call(
      {String id,
      String status,
      CodeableConcept code,
      ValueQuantity? valueQuantity,
      DateTime? effectiveDateTime});

  $CodeableConceptCopyWith<$Res> get code;
  $ValueQuantityCopyWith<$Res>? get valueQuantity;
}

/// @nodoc
class _$ObservationCopyWithImpl<$Res, $Val extends Observation>
    implements $ObservationCopyWith<$Res> {
  _$ObservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? code = null,
    Object? valueQuantity = freezed,
    Object? effectiveDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept,
      valueQuantity: freezed == valueQuantity
          ? _value.valueQuantity
          : valueQuantity // ignore: cast_nullable_to_non_nullable
              as ValueQuantity?,
      effectiveDateTime: freezed == effectiveDateTime
          ? _value.effectiveDateTime
          : effectiveDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res> get code {
    return $CodeableConceptCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value) as $Val);
    });
  }

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ValueQuantityCopyWith<$Res>? get valueQuantity {
    if (_value.valueQuantity == null) {
      return null;
    }

    return $ValueQuantityCopyWith<$Res>(_value.valueQuantity!, (value) {
      return _then(_value.copyWith(valueQuantity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ObservationImplCopyWith<$Res>
    implements $ObservationCopyWith<$Res> {
  factory _$$ObservationImplCopyWith(
          _$ObservationImpl value, $Res Function(_$ObservationImpl) then) =
      __$$ObservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      CodeableConcept code,
      ValueQuantity? valueQuantity,
      DateTime? effectiveDateTime});

  @override
  $CodeableConceptCopyWith<$Res> get code;
  @override
  $ValueQuantityCopyWith<$Res>? get valueQuantity;
}

/// @nodoc
class __$$ObservationImplCopyWithImpl<$Res>
    extends _$ObservationCopyWithImpl<$Res, _$ObservationImpl>
    implements _$$ObservationImplCopyWith<$Res> {
  __$$ObservationImplCopyWithImpl(
      _$ObservationImpl _value, $Res Function(_$ObservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? code = null,
    Object? valueQuantity = freezed,
    Object? effectiveDateTime = freezed,
  }) {
    return _then(_$ObservationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept,
      valueQuantity: freezed == valueQuantity
          ? _value.valueQuantity
          : valueQuantity // ignore: cast_nullable_to_non_nullable
              as ValueQuantity?,
      effectiveDateTime: freezed == effectiveDateTime
          ? _value.effectiveDateTime
          : effectiveDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ObservationImpl implements _Observation {
  _$ObservationImpl(
      {required this.id,
      required this.status,
      required this.code,
      this.valueQuantity,
      this.effectiveDateTime});

  factory _$ObservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ObservationImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  final CodeableConcept code;
  @override
  final ValueQuantity? valueQuantity;
  @override
  final DateTime? effectiveDateTime;

  @override
  String toString() {
    return 'Observation(id: $id, status: $status, code: $code, valueQuantity: $valueQuantity, effectiveDateTime: $effectiveDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.valueQuantity, valueQuantity) ||
                other.valueQuantity == valueQuantity) &&
            (identical(other.effectiveDateTime, effectiveDateTime) ||
                other.effectiveDateTime == effectiveDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, status, code, valueQuantity, effectiveDateTime);

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ObservationImplCopyWith<_$ObservationImpl> get copyWith =>
      __$$ObservationImplCopyWithImpl<_$ObservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ObservationImplToJson(
      this,
    );
  }
}

abstract class _Observation implements Observation {
  factory _Observation(
      {required final String id,
      required final String status,
      required final CodeableConcept code,
      final ValueQuantity? valueQuantity,
      final DateTime? effectiveDateTime}) = _$ObservationImpl;

  factory _Observation.fromJson(Map<String, dynamic> json) =
      _$ObservationImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  CodeableConcept get code;
  @override
  ValueQuantity? get valueQuantity;
  @override
  DateTime? get effectiveDateTime;

  /// Create a copy of Observation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ObservationImplCopyWith<_$ObservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ValueQuantity _$ValueQuantityFromJson(Map<String, dynamic> json) {
  return _ValueQuantity.fromJson(json);
}

/// @nodoc
mixin _$ValueQuantity {
  double? get value => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;

  /// Serializes this ValueQuantity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValueQuantity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValueQuantityCopyWith<ValueQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueQuantityCopyWith<$Res> {
  factory $ValueQuantityCopyWith(
          ValueQuantity value, $Res Function(ValueQuantity) then) =
      _$ValueQuantityCopyWithImpl<$Res, ValueQuantity>;
  @useResult
  $Res call({double? value, String? unit});
}

/// @nodoc
class _$ValueQuantityCopyWithImpl<$Res, $Val extends ValueQuantity>
    implements $ValueQuantityCopyWith<$Res> {
  _$ValueQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValueQuantity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValueQuantityImplCopyWith<$Res>
    implements $ValueQuantityCopyWith<$Res> {
  factory _$$ValueQuantityImplCopyWith(
          _$ValueQuantityImpl value, $Res Function(_$ValueQuantityImpl) then) =
      __$$ValueQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? value, String? unit});
}

/// @nodoc
class __$$ValueQuantityImplCopyWithImpl<$Res>
    extends _$ValueQuantityCopyWithImpl<$Res, _$ValueQuantityImpl>
    implements _$$ValueQuantityImplCopyWith<$Res> {
  __$$ValueQuantityImplCopyWithImpl(
      _$ValueQuantityImpl _value, $Res Function(_$ValueQuantityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ValueQuantity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unit = freezed,
  }) {
    return _then(_$ValueQuantityImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValueQuantityImpl implements _ValueQuantity {
  _$ValueQuantityImpl({this.value, this.unit});

  factory _$ValueQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValueQuantityImplFromJson(json);

  @override
  final double? value;
  @override
  final String? unit;

  @override
  String toString() {
    return 'ValueQuantity(value: $value, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueQuantityImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, unit);

  /// Create a copy of ValueQuantity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValueQuantityImplCopyWith<_$ValueQuantityImpl> get copyWith =>
      __$$ValueQuantityImplCopyWithImpl<_$ValueQuantityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValueQuantityImplToJson(
      this,
    );
  }
}

abstract class _ValueQuantity implements ValueQuantity {
  factory _ValueQuantity({final double? value, final String? unit}) =
      _$ValueQuantityImpl;

  factory _ValueQuantity.fromJson(Map<String, dynamic> json) =
      _$ValueQuantityImpl.fromJson;

  @override
  double? get value;
  @override
  String? get unit;

  /// Create a copy of ValueQuantity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValueQuantityImplCopyWith<_$ValueQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
