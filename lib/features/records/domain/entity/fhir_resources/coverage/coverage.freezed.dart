// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coverage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Coverage _$CoverageFromJson(Map<String, dynamic> json) {
  return _Coverage.fromJson(json);
}

/// @nodoc
mixin _$Coverage {
  /// Serializes this Coverage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoverageCopyWith<$Res> {
  factory $CoverageCopyWith(Coverage value, $Res Function(Coverage) then) =
      _$CoverageCopyWithImpl<$Res, Coverage>;
}

/// @nodoc
class _$CoverageCopyWithImpl<$Res, $Val extends Coverage>
    implements $CoverageCopyWith<$Res> {
  _$CoverageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CoverageImplCopyWith<$Res> {
  factory _$$CoverageImplCopyWith(
          _$CoverageImpl value, $Res Function(_$CoverageImpl) then) =
      __$$CoverageImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CoverageImplCopyWithImpl<$Res>
    extends _$CoverageCopyWithImpl<$Res, _$CoverageImpl>
    implements _$$CoverageImplCopyWith<$Res> {
  __$$CoverageImplCopyWithImpl(
      _$CoverageImpl _value, $Res Function(_$CoverageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Coverage
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$CoverageImpl implements _Coverage {
  _$CoverageImpl();

  factory _$CoverageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoverageImplFromJson(json);

  @override
  String toString() {
    return 'Coverage()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CoverageImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$CoverageImplToJson(
      this,
    );
  }
}

abstract class _Coverage implements Coverage {
  factory _Coverage() = _$CoverageImpl;

  factory _Coverage.fromJson(Map<String, dynamic> json) =
      _$CoverageImpl.fromJson;
}
