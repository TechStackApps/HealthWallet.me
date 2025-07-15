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
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

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
  $Res call({String name, String date, String? reason});
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
    Object? name = null,
    Object? date = null,
    Object? reason = freezed,
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
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
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
  $Res call({String name, String date, String? reason});
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
    Object? name = null,
    Object? date = null,
    Object? reason = freezed,
  }) {
    return _then(_$ProcedureImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcedureImpl implements _Procedure {
  const _$ProcedureImpl({required this.name, required this.date, this.reason});

  factory _$ProcedureImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcedureImplFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final String? reason;

  @override
  String toString() {
    return 'Procedure(name: $name, date: $date, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcedureImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, date, reason);

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
  const factory _Procedure(
      {required final String name,
      required final String date,
      final String? reason}) = _$ProcedureImpl;

  factory _Procedure.fromJson(Map<String, dynamic> json) =
      _$ProcedureImpl.fromJson;

  @override
  String get name;
  @override
  String get date;
  @override
  String? get reason;

  /// Create a copy of Procedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcedureImplCopyWith<_$ProcedureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
