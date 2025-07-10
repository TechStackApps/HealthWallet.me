// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specimen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Specimen _$SpecimenFromJson(Map<String, dynamic> json) {
  return _Specimen.fromJson(json);
}

/// @nodoc
mixin _$Specimen {
  /// Serializes this Specimen to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecimenCopyWith<$Res> {
  factory $SpecimenCopyWith(Specimen value, $Res Function(Specimen) then) =
      _$SpecimenCopyWithImpl<$Res, Specimen>;
}

/// @nodoc
class _$SpecimenCopyWithImpl<$Res, $Val extends Specimen>
    implements $SpecimenCopyWith<$Res> {
  _$SpecimenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Specimen
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SpecimenImplCopyWith<$Res> {
  factory _$$SpecimenImplCopyWith(
          _$SpecimenImpl value, $Res Function(_$SpecimenImpl) then) =
      __$$SpecimenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpecimenImplCopyWithImpl<$Res>
    extends _$SpecimenCopyWithImpl<$Res, _$SpecimenImpl>
    implements _$$SpecimenImplCopyWith<$Res> {
  __$$SpecimenImplCopyWithImpl(
      _$SpecimenImpl _value, $Res Function(_$SpecimenImpl) _then)
      : super(_value, _then);

  /// Create a copy of Specimen
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SpecimenImpl implements _Specimen {
  _$SpecimenImpl();

  factory _$SpecimenImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecimenImplFromJson(json);

  @override
  String toString() {
    return 'Specimen()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpecimenImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecimenImplToJson(
      this,
    );
  }
}

abstract class _Specimen implements Specimen {
  factory _Specimen() = _$SpecimenImpl;

  factory _Specimen.fromJson(Map<String, dynamic> json) =
      _$SpecimenImpl.fromJson;
}
