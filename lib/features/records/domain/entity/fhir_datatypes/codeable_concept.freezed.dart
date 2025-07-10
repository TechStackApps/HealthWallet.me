// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'codeable_concept.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CodeableConcept _$CodeableConceptFromJson(Map<String, dynamic> json) {
  return _CodeableConcept.fromJson(json);
}

/// @nodoc
mixin _$CodeableConcept {
  List<Coding>? get coding => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  /// Serializes this CodeableConcept to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CodeableConcept
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeableConceptCopyWith<CodeableConcept> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeableConceptCopyWith<$Res> {
  factory $CodeableConceptCopyWith(
          CodeableConcept value, $Res Function(CodeableConcept) then) =
      _$CodeableConceptCopyWithImpl<$Res, CodeableConcept>;
  @useResult
  $Res call({List<Coding>? coding, String? text});
}

/// @nodoc
class _$CodeableConceptCopyWithImpl<$Res, $Val extends CodeableConcept>
    implements $CodeableConceptCopyWith<$Res> {
  _$CodeableConceptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeableConcept
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coding = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      coding: freezed == coding
          ? _value.coding
          : coding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeableConceptImplCopyWith<$Res>
    implements $CodeableConceptCopyWith<$Res> {
  factory _$$CodeableConceptImplCopyWith(_$CodeableConceptImpl value,
          $Res Function(_$CodeableConceptImpl) then) =
      __$$CodeableConceptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Coding>? coding, String? text});
}

/// @nodoc
class __$$CodeableConceptImplCopyWithImpl<$Res>
    extends _$CodeableConceptCopyWithImpl<$Res, _$CodeableConceptImpl>
    implements _$$CodeableConceptImplCopyWith<$Res> {
  __$$CodeableConceptImplCopyWithImpl(
      _$CodeableConceptImpl _value, $Res Function(_$CodeableConceptImpl) _then)
      : super(_value, _then);

  /// Create a copy of CodeableConcept
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coding = freezed,
    Object? text = freezed,
  }) {
    return _then(_$CodeableConceptImpl(
      coding: freezed == coding
          ? _value._coding
          : coding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CodeableConceptImpl implements _CodeableConcept {
  _$CodeableConceptImpl({final List<Coding>? coding, this.text})
      : _coding = coding;

  factory _$CodeableConceptImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodeableConceptImplFromJson(json);

  final List<Coding>? _coding;
  @override
  List<Coding>? get coding {
    final value = _coding;
    if (value == null) return null;
    if (_coding is EqualUnmodifiableListView) return _coding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? text;

  @override
  String toString() {
    return 'CodeableConcept(coding: $coding, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeableConceptImpl &&
            const DeepCollectionEquality().equals(other._coding, _coding) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_coding), text);

  /// Create a copy of CodeableConcept
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeableConceptImplCopyWith<_$CodeableConceptImpl> get copyWith =>
      __$$CodeableConceptImplCopyWithImpl<_$CodeableConceptImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CodeableConceptImplToJson(
      this,
    );
  }
}

abstract class _CodeableConcept implements CodeableConcept {
  factory _CodeableConcept({final List<Coding>? coding, final String? text}) =
      _$CodeableConceptImpl;

  factory _CodeableConcept.fromJson(Map<String, dynamic> json) =
      _$CodeableConceptImpl.fromJson;

  @override
  List<Coding>? get coding;
  @override
  String? get text;

  /// Create a copy of CodeableConcept
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeableConceptImplCopyWith<_$CodeableConceptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
