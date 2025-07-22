// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telecom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Telecom _$TelecomFromJson(Map<String, dynamic> json) {
  return _Telecom.fromJson(json);
}

/// @nodoc
mixin _$Telecom {
  String? get system => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  String? get use => throw _privateConstructorUsedError;

  /// Serializes this Telecom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Telecom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TelecomCopyWith<Telecom> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelecomCopyWith<$Res> {
  factory $TelecomCopyWith(Telecom value, $Res Function(Telecom) then) =
      _$TelecomCopyWithImpl<$Res, Telecom>;
  @useResult
  $Res call({String? system, String? value, String? use});
}

/// @nodoc
class _$TelecomCopyWithImpl<$Res, $Val extends Telecom>
    implements $TelecomCopyWith<$Res> {
  _$TelecomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Telecom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? value = freezed,
    Object? use = freezed,
  }) {
    return _then(_value.copyWith(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelecomImplCopyWith<$Res> implements $TelecomCopyWith<$Res> {
  factory _$$TelecomImplCopyWith(
          _$TelecomImpl value, $Res Function(_$TelecomImpl) then) =
      __$$TelecomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? system, String? value, String? use});
}

/// @nodoc
class __$$TelecomImplCopyWithImpl<$Res>
    extends _$TelecomCopyWithImpl<$Res, _$TelecomImpl>
    implements _$$TelecomImplCopyWith<$Res> {
  __$$TelecomImplCopyWithImpl(
      _$TelecomImpl _value, $Res Function(_$TelecomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Telecom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? value = freezed,
    Object? use = freezed,
  }) {
    return _then(_$TelecomImpl(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelecomImpl implements _Telecom {
  _$TelecomImpl({this.system, this.value, this.use});

  factory _$TelecomImpl.fromJson(Map<String, dynamic> json) =>
      _$$TelecomImplFromJson(json);

  @override
  final String? system;
  @override
  final String? value;
  @override
  final String? use;

  @override
  String toString() {
    return 'Telecom(system: $system, value: $value, use: $use)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelecomImpl &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.use, use) || other.use == use));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, system, value, use);

  /// Create a copy of Telecom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TelecomImplCopyWith<_$TelecomImpl> get copyWith =>
      __$$TelecomImplCopyWithImpl<_$TelecomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelecomImplToJson(
      this,
    );
  }
}

abstract class _Telecom implements Telecom {
  factory _Telecom(
      {final String? system,
      final String? value,
      final String? use}) = _$TelecomImpl;

  factory _Telecom.fromJson(Map<String, dynamic> json) = _$TelecomImpl.fromJson;

  @override
  String? get system;
  @override
  String? get value;
  @override
  String? get use;

  /// Create a copy of Telecom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TelecomImplCopyWith<_$TelecomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
