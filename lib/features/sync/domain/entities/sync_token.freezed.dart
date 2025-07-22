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
  bool get isActive =>
      throw _privateConstructorUsedError; // Enhanced fields for GitHub-like token management
  String get tokenId => throw _privateConstructorUsedError;
  DateTime? get lastUsedAt =>
      throw _privateConstructorUsedError; // Network resilience fields
  List<String> get fallbackAddresses => throw _privateConstructorUsedError;
  Map<String, dynamic> get serverInfo => throw _privateConstructorUsedError;

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
      bool isActive,
      String tokenId,
      DateTime? lastUsedAt,
      List<String> fallbackAddresses,
      Map<String, dynamic> serverInfo});
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
    Object? tokenId = null,
    Object? lastUsedAt = freezed,
    Object? fallbackAddresses = null,
    Object? serverInfo = null,
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
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fallbackAddresses: null == fallbackAddresses
          ? _value.fallbackAddresses
          : fallbackAddresses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serverInfo: null == serverInfo
          ? _value.serverInfo
          : serverInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      bool isActive,
      String tokenId,
      DateTime? lastUsedAt,
      List<String> fallbackAddresses,
      Map<String, dynamic> serverInfo});
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
    Object? tokenId = null,
    Object? lastUsedAt = freezed,
    Object? fallbackAddresses = null,
    Object? serverInfo = null,
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
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fallbackAddresses: null == fallbackAddresses
          ? _value._fallbackAddresses
          : fallbackAddresses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serverInfo: null == serverInfo
          ? _value._serverInfo
          : serverInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      this.isActive = true,
      required this.tokenId,
      this.lastUsedAt,
      final List<String> fallbackAddresses = const [],
      final Map<String, dynamic> serverInfo = const {}})
      : _fallbackAddresses = fallbackAddresses,
        _serverInfo = serverInfo;

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
// Enhanced fields for GitHub-like token management
  @override
  final String tokenId;
  @override
  final DateTime? lastUsedAt;
// Network resilience fields
  final List<String> _fallbackAddresses;
// Network resilience fields
  @override
  @JsonKey()
  List<String> get fallbackAddresses {
    if (_fallbackAddresses is EqualUnmodifiableListView)
      return _fallbackAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fallbackAddresses);
  }

  final Map<String, dynamic> _serverInfo;
  @override
  @JsonKey()
  Map<String, dynamic> get serverInfo {
    if (_serverInfo is EqualUnmodifiableMapView) return _serverInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_serverInfo);
  }

  @override
  String toString() {
    return 'SyncToken(token: $token, address: $address, port: $port, serverName: $serverName, createdAt: $createdAt, expiresAt: $expiresAt, isActive: $isActive, tokenId: $tokenId, lastUsedAt: $lastUsedAt, fallbackAddresses: $fallbackAddresses, serverInfo: $serverInfo)';
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
                other.isActive == isActive) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            const DeepCollectionEquality()
                .equals(other._fallbackAddresses, _fallbackAddresses) &&
            const DeepCollectionEquality()
                .equals(other._serverInfo, _serverInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      token,
      address,
      port,
      serverName,
      createdAt,
      expiresAt,
      isActive,
      tokenId,
      lastUsedAt,
      const DeepCollectionEquality().hash(_fallbackAddresses),
      const DeepCollectionEquality().hash(_serverInfo));

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
      final bool isActive,
      required final String tokenId,
      final DateTime? lastUsedAt,
      final List<String> fallbackAddresses,
      final Map<String, dynamic> serverInfo}) = _$SyncTokenImpl;

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
  bool get isActive; // Enhanced fields for GitHub-like token management
  @override
  String get tokenId;
  @override
  DateTime? get lastUsedAt; // Network resilience fields
  @override
  List<String> get fallbackAddresses;
  @override
  Map<String, dynamic> get serverInfo;

  /// Create a copy of SyncToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncTokenImplCopyWith<_$SyncTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
