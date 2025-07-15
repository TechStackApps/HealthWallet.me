// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncToken _$SyncTokenFromJson(Map<String, dynamic> json) {
  return _SyncToken.fromJson(json);
}

/// @nodoc
mixin _$SyncToken {
  String get token => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get port => throw _privateConstructorUsedError;
  String get serverName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this SyncToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncTokenCopyWith<SyncToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncTokenCopyWith<$Res> {
  factory $SyncTokenCopyWith(SyncToken value, $Res Function(SyncToken) then) =
      _$SyncTokenCopyWithImpl<$Res, SyncToken>;
  @useResult
  $Res call(
      {String token,
      String address,
      String port,
      String serverName,
      DateTime createdAt,
      DateTime expiresAt,
      bool isActive});
}

/// @nodoc
class _$SyncTokenCopyWithImpl<$Res, $Val extends SyncToken>
    implements $SyncTokenCopyWith<$Res> {
  _$SyncTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? address = null,
    Object? port = null,
    Object? serverName = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      serverName: null == serverName
          ? _value.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncTokenImplCopyWith<$Res>
    implements $SyncTokenCopyWith<$Res> {
  factory _$$SyncTokenImplCopyWith(
          _$SyncTokenImpl value, $Res Function(_$SyncTokenImpl) then) =
      __$$SyncTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String address,
      String port,
      String serverName,
      DateTime createdAt,
      DateTime expiresAt,
      bool isActive});
}

/// @nodoc
class __$$SyncTokenImplCopyWithImpl<$Res>
    extends _$SyncTokenCopyWithImpl<$Res, _$SyncTokenImpl>
    implements _$$SyncTokenImplCopyWith<$Res> {
  __$$SyncTokenImplCopyWithImpl(
      _$SyncTokenImpl _value, $Res Function(_$SyncTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? address = null,
    Object? port = null,
    Object? serverName = null,
    Object? createdAt = null,
    Object? expiresAt = null,
    Object? isActive = null,
  }) {
    return _then(_$SyncTokenImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as String,
      serverName: null == serverName
          ? _value.serverName
          : serverName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncTokenImpl implements _SyncToken {
  const _$SyncTokenImpl(
      {required this.token,
      required this.address,
      required this.port,
      required this.serverName,
      required this.createdAt,
      required this.expiresAt,
      this.isActive = true});

  factory _$SyncTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncTokenImplFromJson(json);

  @override
  final String token;
  @override
  final String address;
  @override
  final String port;
  @override
  final String serverName;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'SyncToken(token: $token, address: $address, port: $port, serverName: $serverName, createdAt: $createdAt, expiresAt: $expiresAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncTokenImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.serverName, serverName) ||
                other.serverName == serverName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, address, port, serverName,
      createdAt, expiresAt, isActive);

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncTokenImplCopyWith<_$SyncTokenImpl> get copyWith =>
      __$$SyncTokenImplCopyWithImpl<_$SyncTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncTokenImplToJson(
      this,
    );
  }
}

abstract class _SyncToken implements SyncToken {
  const factory _SyncToken(
      {required final String token,
      required final String address,
      required final String port,
      required final String serverName,
      required final DateTime createdAt,
      required final DateTime expiresAt,
      final bool isActive}) = _$SyncTokenImpl;

  factory _SyncToken.fromJson(Map<String, dynamic> json) =
      _$SyncTokenImpl.fromJson;

  @override
  String get token;
  @override
  String get address;
  @override
  String get port;
  @override
  String get serverName;
  @override
  DateTime get createdAt;
  @override
  DateTime get expiresAt;
  @override
  bool get isActive;

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncTokenImplCopyWith<_$SyncTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
