// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'binary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Binary _$BinaryFromJson(Map<String, dynamic> json) {
  return _Binary.fromJson(json);
}

/// @nodoc
mixin _$Binary {
  String get id => throw _privateConstructorUsedError;
  String? get contentType => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this Binary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Binary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BinaryCopyWith<Binary> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinaryCopyWith<$Res> {
  factory $BinaryCopyWith(Binary value, $Res Function(Binary) then) =
      _$BinaryCopyWithImpl<$Res, Binary>;
  @useResult
  $Res call({String id, String? contentType, String? content, String? data});
}

/// @nodoc
class _$BinaryCopyWithImpl<$Res, $Val extends Binary>
    implements $BinaryCopyWith<$Res> {
  _$BinaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Binary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentType = freezed,
    Object? content = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinaryImplCopyWith<$Res> implements $BinaryCopyWith<$Res> {
  factory _$$BinaryImplCopyWith(
          _$BinaryImpl value, $Res Function(_$BinaryImpl) then) =
      __$$BinaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? contentType, String? content, String? data});
}

/// @nodoc
class __$$BinaryImplCopyWithImpl<$Res>
    extends _$BinaryCopyWithImpl<$Res, _$BinaryImpl>
    implements _$$BinaryImplCopyWith<$Res> {
  __$$BinaryImplCopyWithImpl(
      _$BinaryImpl _value, $Res Function(_$BinaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Binary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contentType = freezed,
    Object? content = freezed,
    Object? data = freezed,
  }) {
    return _then(_$BinaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BinaryImpl implements _Binary {
  _$BinaryImpl({required this.id, this.contentType, this.content, this.data});

  factory _$BinaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinaryImplFromJson(json);

  @override
  final String id;
  @override
  final String? contentType;
  @override
  final String? content;
  @override
  final String? data;

  @override
  String toString() {
    return 'Binary(id: $id, contentType: $contentType, content: $content, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, contentType, content, data);

  /// Create a copy of Binary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BinaryImplCopyWith<_$BinaryImpl> get copyWith =>
      __$$BinaryImplCopyWithImpl<_$BinaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BinaryImplToJson(
      this,
    );
  }
}

abstract class _Binary implements Binary {
  factory _Binary(
      {required final String id,
      final String? contentType,
      final String? content,
      final String? data}) = _$BinaryImpl;

  factory _Binary.fromJson(Map<String, dynamic> json) = _$BinaryImpl.fromJson;

  @override
  String get id;
  @override
  String? get contentType;
  @override
  String? get content;
  @override
  String? get data;

  /// Create a copy of Binary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BinaryImplCopyWith<_$BinaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
