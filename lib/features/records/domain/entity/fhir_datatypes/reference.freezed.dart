// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reference _$ReferenceFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'resolved':
      return ResolvedReference.fromJson(json);
    case 'unresolved':
      return UnresolvedReference.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Reference',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Reference {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FhirResource resource) resolved,
    required TResult Function(String reference) unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FhirResource resource)? resolved,
    TResult? Function(String reference)? unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FhirResource resource)? resolved,
    TResult Function(String reference)? unresolved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResolvedReference value) resolved,
    required TResult Function(UnresolvedReference value) unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResolvedReference value)? resolved,
    TResult? Function(UnresolvedReference value)? unresolved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResolvedReference value)? resolved,
    TResult Function(UnresolvedReference value)? unresolved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Reference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceCopyWith<$Res> {
  factory $ReferenceCopyWith(Reference value, $Res Function(Reference) then) =
      _$ReferenceCopyWithImpl<$Res, Reference>;
}

/// @nodoc
class _$ReferenceCopyWithImpl<$Res, $Val extends Reference>
    implements $ReferenceCopyWith<$Res> {
  _$ReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ResolvedReferenceImplCopyWith<$Res> {
  factory _$$ResolvedReferenceImplCopyWith(_$ResolvedReferenceImpl value,
          $Res Function(_$ResolvedReferenceImpl) then) =
      __$$ResolvedReferenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FhirResource resource});
}

/// @nodoc
class __$$ResolvedReferenceImplCopyWithImpl<$Res>
    extends _$ReferenceCopyWithImpl<$Res, _$ResolvedReferenceImpl>
    implements _$$ResolvedReferenceImplCopyWith<$Res> {
  __$$ResolvedReferenceImplCopyWithImpl(_$ResolvedReferenceImpl _value,
      $Res Function(_$ResolvedReferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = null,
  }) {
    return _then(_$ResolvedReferenceImpl(
      null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as FhirResource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResolvedReferenceImpl implements ResolvedReference {
  const _$ResolvedReferenceImpl(this.resource, {final String? $type})
      : $type = $type ?? 'resolved';

  factory _$ResolvedReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResolvedReferenceImplFromJson(json);

  @override
  final FhirResource resource;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Reference.resolved(resource: $resource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResolvedReferenceImpl &&
            (identical(other.resource, resource) ||
                other.resource == resource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resource);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResolvedReferenceImplCopyWith<_$ResolvedReferenceImpl> get copyWith =>
      __$$ResolvedReferenceImplCopyWithImpl<_$ResolvedReferenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FhirResource resource) resolved,
    required TResult Function(String reference) unresolved,
  }) {
    return resolved(resource);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FhirResource resource)? resolved,
    TResult? Function(String reference)? unresolved,
  }) {
    return resolved?.call(resource);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FhirResource resource)? resolved,
    TResult Function(String reference)? unresolved,
    required TResult orElse(),
  }) {
    if (resolved != null) {
      return resolved(resource);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResolvedReference value) resolved,
    required TResult Function(UnresolvedReference value) unresolved,
  }) {
    return resolved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResolvedReference value)? resolved,
    TResult? Function(UnresolvedReference value)? unresolved,
  }) {
    return resolved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResolvedReference value)? resolved,
    TResult Function(UnresolvedReference value)? unresolved,
    required TResult orElse(),
  }) {
    if (resolved != null) {
      return resolved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ResolvedReferenceImplToJson(
      this,
    );
  }
}

abstract class ResolvedReference implements Reference {
  const factory ResolvedReference(final FhirResource resource) =
      _$ResolvedReferenceImpl;

  factory ResolvedReference.fromJson(Map<String, dynamic> json) =
      _$ResolvedReferenceImpl.fromJson;

  FhirResource get resource;

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResolvedReferenceImplCopyWith<_$ResolvedReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnresolvedReferenceImplCopyWith<$Res> {
  factory _$$UnresolvedReferenceImplCopyWith(_$UnresolvedReferenceImpl value,
          $Res Function(_$UnresolvedReferenceImpl) then) =
      __$$UnresolvedReferenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reference});
}

/// @nodoc
class __$$UnresolvedReferenceImplCopyWithImpl<$Res>
    extends _$ReferenceCopyWithImpl<$Res, _$UnresolvedReferenceImpl>
    implements _$$UnresolvedReferenceImplCopyWith<$Res> {
  __$$UnresolvedReferenceImplCopyWithImpl(_$UnresolvedReferenceImpl _value,
      $Res Function(_$UnresolvedReferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
  }) {
    return _then(_$UnresolvedReferenceImpl(
      null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnresolvedReferenceImpl implements UnresolvedReference {
  const _$UnresolvedReferenceImpl(this.reference, {final String? $type})
      : $type = $type ?? 'unresolved';

  factory _$UnresolvedReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnresolvedReferenceImplFromJson(json);

  @override
  final String reference;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Reference.unresolved(reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnresolvedReferenceImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reference);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnresolvedReferenceImplCopyWith<_$UnresolvedReferenceImpl> get copyWith =>
      __$$UnresolvedReferenceImplCopyWithImpl<_$UnresolvedReferenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FhirResource resource) resolved,
    required TResult Function(String reference) unresolved,
  }) {
    return unresolved(reference);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(FhirResource resource)? resolved,
    TResult? Function(String reference)? unresolved,
  }) {
    return unresolved?.call(reference);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FhirResource resource)? resolved,
    TResult Function(String reference)? unresolved,
    required TResult orElse(),
  }) {
    if (unresolved != null) {
      return unresolved(reference);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResolvedReference value) resolved,
    required TResult Function(UnresolvedReference value) unresolved,
  }) {
    return unresolved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResolvedReference value)? resolved,
    TResult? Function(UnresolvedReference value)? unresolved,
  }) {
    return unresolved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResolvedReference value)? resolved,
    TResult Function(UnresolvedReference value)? unresolved,
    required TResult orElse(),
  }) {
    if (unresolved != null) {
      return unresolved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnresolvedReferenceImplToJson(
      this,
    );
  }
}

abstract class UnresolvedReference implements Reference {
  const factory UnresolvedReference(final String reference) =
      _$UnresolvedReferenceImpl;

  factory UnresolvedReference.fromJson(Map<String, dynamic> json) =
      _$UnresolvedReferenceImpl.fromJson;

  String get reference;

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnresolvedReferenceImplCopyWith<_$UnresolvedReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
