// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Coding _$CodingFromJson(Map<String, dynamic> json) {
  return _Coding.fromJson(json);
}

/// @nodoc
mixin _$Coding {
  String? get system => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get display => throw _privateConstructorUsedError;

  /// Serializes this Coding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Coding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodingCopyWith<Coding> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodingCopyWith<$Res> {
  factory $CodingCopyWith(Coding value, $Res Function(Coding) then) =
      _$CodingCopyWithImpl<$Res, Coding>;
  @useResult
  $Res call({String? system, String? code, String? display});
}

/// @nodoc
class _$CodingCopyWithImpl<$Res, $Val extends Coding>
    implements $CodingCopyWith<$Res> {
  _$CodingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? code = freezed,
    Object? display = freezed,
  }) {
    return _then(_value.copyWith(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodingImplCopyWith<$Res> implements $CodingCopyWith<$Res> {
  factory _$$CodingImplCopyWith(
          _$CodingImpl value, $Res Function(_$CodingImpl) then) =
      __$$CodingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? system, String? code, String? display});
}

/// @nodoc
class __$$CodingImplCopyWithImpl<$Res>
    extends _$CodingCopyWithImpl<$Res, _$CodingImpl>
    implements _$$CodingImplCopyWith<$Res> {
  __$$CodingImplCopyWithImpl(
      _$CodingImpl _value, $Res Function(_$CodingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Coding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? code = freezed,
    Object? display = freezed,
  }) {
    return _then(_$CodingImpl(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CodingImpl implements _Coding {
  _$CodingImpl({this.system, this.code, this.display});

  factory _$CodingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodingImplFromJson(json);

  @override
  final String? system;
  @override
  final String? code;
  @override
  final String? display;

  @override
  String toString() {
    return 'Coding(system: $system, code: $code, display: $display)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodingImpl &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.display, display) || other.display == display));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, system, code, display);

  /// Create a copy of Coding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodingImplCopyWith<_$CodingImpl> get copyWith =>
      __$$CodingImplCopyWithImpl<_$CodingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CodingImplToJson(
      this,
    );
  }
}

abstract class _Coding implements Coding {
  factory _Coding(
      {final String? system,
      final String? code,
      final String? display}) = _$CodingImpl;

  factory _Coding.fromJson(Map<String, dynamic> json) = _$CodingImpl.fromJson;

  @override
  String? get system;
  @override
  String? get code;
  @override
  String? get display;

  /// Create a copy of Coding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodingImplCopyWith<_$CodingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
