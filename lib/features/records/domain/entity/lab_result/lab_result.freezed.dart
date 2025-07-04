// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lab_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LabResult _$LabResultFromJson(Map<String, dynamic> json) {
  return _LabResult.fromJson(json);
}

/// @nodoc
mixin _$LabResult {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String? get referenceRange => throw _privateConstructorUsedError;

  /// Serializes this LabResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LabResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabResultCopyWith<LabResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabResultCopyWith<$Res> {
  factory $LabResultCopyWith(LabResult value, $Res Function(LabResult) then) =
      _$LabResultCopyWithImpl<$Res, LabResult>;
  @useResult
  $Res call(
      {String name,
      String date,
      String value,
      String unit,
      String? referenceRange});
}

/// @nodoc
class _$LabResultCopyWithImpl<$Res, $Val extends LabResult>
    implements $LabResultCopyWith<$Res> {
  _$LabResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? value = null,
    Object? unit = null,
    Object? referenceRange = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      referenceRange: freezed == referenceRange
          ? _value.referenceRange
          : referenceRange // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LabResultImplCopyWith<$Res>
    implements $LabResultCopyWith<$Res> {
  factory _$$LabResultImplCopyWith(
          _$LabResultImpl value, $Res Function(_$LabResultImpl) then) =
      __$$LabResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String date,
      String value,
      String unit,
      String? referenceRange});
}

/// @nodoc
class __$$LabResultImplCopyWithImpl<$Res>
    extends _$LabResultCopyWithImpl<$Res, _$LabResultImpl>
    implements _$$LabResultImplCopyWith<$Res> {
  __$$LabResultImplCopyWithImpl(
      _$LabResultImpl _value, $Res Function(_$LabResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of LabResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? value = null,
    Object? unit = null,
    Object? referenceRange = freezed,
  }) {
    return _then(_$LabResultImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      referenceRange: freezed == referenceRange
          ? _value.referenceRange
          : referenceRange // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LabResultImpl implements _LabResult {
  const _$LabResultImpl(
      {required this.name,
      required this.date,
      required this.value,
      required this.unit,
      this.referenceRange});

  factory _$LabResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabResultImplFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final String value;
  @override
  final String unit;
  @override
  final String? referenceRange;

  @override
  String toString() {
    return 'LabResult(name: $name, date: $date, value: $value, unit: $unit, referenceRange: $referenceRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.referenceRange, referenceRange) ||
                other.referenceRange == referenceRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, date, value, unit, referenceRange);

  /// Create a copy of LabResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabResultImplCopyWith<_$LabResultImpl> get copyWith =>
      __$$LabResultImplCopyWithImpl<_$LabResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LabResultImplToJson(
      this,
    );
  }
}

abstract class _LabResult implements LabResult {
  const factory _LabResult(
      {required final String name,
      required final String date,
      required final String value,
      required final String unit,
      final String? referenceRange}) = _$LabResultImpl;

  factory _LabResult.fromJson(Map<String, dynamic> json) =
      _$LabResultImpl.fromJson;

  @override
  String get name;
  @override
  String get date;
  @override
  String get value;
  @override
  String get unit;
  @override
  String? get referenceRange;

  /// Create a copy of LabResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabResultImplCopyWith<_$LabResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
