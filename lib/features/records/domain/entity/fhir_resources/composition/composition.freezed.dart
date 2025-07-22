// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'composition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Composition _$CompositionFromJson(Map<String, dynamic> json) {
  return _Composition.fromJson(json);
}

/// @nodoc
mixin _$Composition {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'relates_to')
  String? get relatesTo => throw _privateConstructorUsedError;

  /// Serializes this Composition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Composition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompositionCopyWith<Composition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompositionCopyWith<$Res> {
  factory $CompositionCopyWith(
          Composition value, $Res Function(Composition) then) =
      _$CompositionCopyWithImpl<$Res, Composition>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      @JsonKey(name: 'relates_to') String? relatesTo});
}

/// @nodoc
class _$CompositionCopyWithImpl<$Res, $Val extends Composition>
    implements $CompositionCopyWith<$Res> {
  _$CompositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Composition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? relatesTo = freezed,
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
      relatesTo: freezed == relatesTo
          ? _value.relatesTo
          : relatesTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompositionImplCopyWith<$Res>
    implements $CompositionCopyWith<$Res> {
  factory _$$CompositionImplCopyWith(
          _$CompositionImpl value, $Res Function(_$CompositionImpl) then) =
      __$$CompositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      @JsonKey(name: 'relates_to') String? relatesTo});
}

/// @nodoc
class __$$CompositionImplCopyWithImpl<$Res>
    extends _$CompositionCopyWithImpl<$Res, _$CompositionImpl>
    implements _$$CompositionImplCopyWith<$Res> {
  __$$CompositionImplCopyWithImpl(
      _$CompositionImpl _value, $Res Function(_$CompositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Composition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? relatesTo = freezed,
  }) {
    return _then(_$CompositionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      relatesTo: freezed == relatesTo
          ? _value.relatesTo
          : relatesTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompositionImpl implements _Composition {
  _$CompositionImpl(
      {this.id, this.title, @JsonKey(name: 'relates_to') this.relatesTo});

  factory _$CompositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompositionImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  @JsonKey(name: 'relates_to')
  final String? relatesTo;

  @override
  String toString() {
    return 'Composition(id: $id, title: $title, relatesTo: $relatesTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompositionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.relatesTo, relatesTo) ||
                other.relatesTo == relatesTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, relatesTo);

  /// Create a copy of Composition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompositionImplCopyWith<_$CompositionImpl> get copyWith =>
      __$$CompositionImplCopyWithImpl<_$CompositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompositionImplToJson(
      this,
    );
  }
}

abstract class _Composition implements Composition {
  factory _Composition(
          {final String? id,
          final String? title,
          @JsonKey(name: 'relates_to') final String? relatesTo}) =
      _$CompositionImpl;

  factory _Composition.fromJson(Map<String, dynamic> json) =
      _$CompositionImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  @JsonKey(name: 'relates_to')
  String? get relatesTo;

  /// Create a copy of Composition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompositionImplCopyWith<_$CompositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
