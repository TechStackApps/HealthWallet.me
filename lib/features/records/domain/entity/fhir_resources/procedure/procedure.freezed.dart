// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Procedure _$ProcedureFromJson(Map<String, dynamic> json) {
  return _Procedure.fromJson(json);
}

/// @nodoc
mixin _$Procedure {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  CodeableConcept get code => throw _privateConstructorUsedError;
  DateTime? get performedDateTime => throw _privateConstructorUsedError;

  /// Serializes this Procedure to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcedureCopyWith<Procedure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcedureCopyWith<$Res> {
  factory $ProcedureCopyWith(Procedure value, $Res Function(Procedure) then) =
      _$ProcedureCopyWithImpl<$Res, Procedure>;
  @useResult
  $Res call(
      {String id,
      String status,
      CodeableConcept code,
      DateTime? performedDateTime});

  $CodeableConceptCopyWith<$Res> get code;
}

/// @nodoc
class _$ProcedureCopyWithImpl<$Res, $Val extends Procedure>
    implements $ProcedureCopyWith<$Res> {
  _$ProcedureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? code = null,
    Object? performedDateTime = freezed,
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
      performedDateTime: freezed == performedDateTime
          ? _value.performedDateTime
          : performedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res> get code {
    return $CodeableConceptCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProcedureImplCopyWith<$Res>
    implements $ProcedureCopyWith<$Res> {
  factory _$$ProcedureImplCopyWith(
          _$ProcedureImpl value, $Res Function(_$ProcedureImpl) then) =
      __$$ProcedureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      CodeableConcept code,
      DateTime? performedDateTime});

  @override
  $CodeableConceptCopyWith<$Res> get code;
}

/// @nodoc
class __$$ProcedureImplCopyWithImpl<$Res>
    extends _$ProcedureCopyWithImpl<$Res, _$ProcedureImpl>
    implements _$$ProcedureImplCopyWith<$Res> {
  __$$ProcedureImplCopyWithImpl(
      _$ProcedureImpl _value, $Res Function(_$ProcedureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? code = null,
    Object? performedDateTime = freezed,
  }) {
    return _then(_$ProcedureImpl(
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
      performedDateTime: freezed == performedDateTime
          ? _value.performedDateTime
          : performedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcedureImpl implements _Procedure {
  _$ProcedureImpl(
      {required this.id,
      required this.status,
      required this.code,
      this.performedDateTime});

  factory _$ProcedureImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  final CodeableConcept code;
  @override
  final DateTime? performedDateTime;

  @override
  String toString() {
    return 'Procedure(id: $id, status: $status, code: $code, performedDateTime: $performedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.performedDateTime, performedDateTime) ||
                other.performedDateTime == performedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, code, performedDateTime);

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcedureImplCopyWith<_$ProcedureImpl> get copyWith =>
      __$$ProcedureImplCopyWithImpl<_$ProcedureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcedureImplToJson(
      this,
    );
  }
}

abstract class _Procedure implements Procedure {
  factory _Procedure(
      {required final String id,
      required final String status,
      required final CodeableConcept code,
      final DateTime? performedDateTime}) = _$ProcedureImpl;

  factory _Procedure.fromJson(Map<String, dynamic> json) =
      _$ProcedureImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  CodeableConcept get code;
  @override
  DateTime? get performedDateTime;

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureImplCopyWith<_$ProcedureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
