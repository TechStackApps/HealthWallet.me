// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encounter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Encounter _$EncounterFromJson(Map<String, dynamic> json) {
  return _Encounter.fromJson(json);
}

/// @nodoc
mixin _$Encounter {
  String? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  List<EncounterParticipant>? get participant =>
      throw _privateConstructorUsedError;

  /// Serializes this Encounter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterCopyWith<Encounter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterCopyWith<$Res> {
  factory $EncounterCopyWith(Encounter value, $Res Function(Encounter) then) =
      _$EncounterCopyWithImpl<$Res, Encounter>;
  @useResult
  $Res call(
      {String? id, String? status, List<EncounterParticipant>? participant});
}

/// @nodoc
class _$EncounterCopyWithImpl<$Res, $Val extends Encounter>
    implements $EncounterCopyWith<$Res> {
  _$EncounterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? participant = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as List<EncounterParticipant>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EncounterImplCopyWith<$Res>
    implements $EncounterCopyWith<$Res> {
  factory _$$EncounterImplCopyWith(
          _$EncounterImpl value, $Res Function(_$EncounterImpl) then) =
      __$$EncounterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String? status, List<EncounterParticipant>? participant});
}

/// @nodoc
class __$$EncounterImplCopyWithImpl<$Res>
    extends _$EncounterCopyWithImpl<$Res, _$EncounterImpl>
    implements _$$EncounterImplCopyWith<$Res> {
  __$$EncounterImplCopyWithImpl(
      _$EncounterImpl _value, $Res Function(_$EncounterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? participant = freezed,
  }) {
    return _then(_$EncounterImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      participant: freezed == participant
          ? _value._participant
          : participant // ignore: cast_nullable_to_non_nullable
              as List<EncounterParticipant>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EncounterImpl implements _Encounter {
  _$EncounterImpl(
      {this.id, this.status, final List<EncounterParticipant>? participant})
      : _participant = participant;

  factory _$EncounterImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncounterImplFromJson(json);

  @override
  final String? id;
  @override
  final String? status;
  final List<EncounterParticipant>? _participant;
  @override
  List<EncounterParticipant>? get participant {
    final value = _participant;
    if (value == null) return null;
    if (_participant is EqualUnmodifiableListView) return _participant;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Encounter(id: $id, status: $status, participant: $participant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncounterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._participant, _participant));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status,
      const DeepCollectionEquality().hash(_participant));

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncounterImplCopyWith<_$EncounterImpl> get copyWith =>
      __$$EncounterImplCopyWithImpl<_$EncounterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncounterImplToJson(
      this,
    );
  }
}

abstract class _Encounter implements Encounter {
  factory _Encounter(
      {final String? id,
      final String? status,
      final List<EncounterParticipant>? participant}) = _$EncounterImpl;

  factory _Encounter.fromJson(Map<String, dynamic> json) =
      _$EncounterImpl.fromJson;

  @override
  String? get id;
  @override
  String? get status;
  @override
  List<EncounterParticipant>? get participant;

  /// Create a copy of Encounter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncounterImplCopyWith<_$EncounterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EncounterParticipant _$EncounterParticipantFromJson(Map<String, dynamic> json) {
  return _EncounterParticipant.fromJson(json);
}

/// @nodoc
mixin _$EncounterParticipant {
  Reference? get individual => throw _privateConstructorUsedError;

  /// Serializes this EncounterParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EncounterParticipantCopyWith<EncounterParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncounterParticipantCopyWith<$Res> {
  factory $EncounterParticipantCopyWith(EncounterParticipant value,
          $Res Function(EncounterParticipant) then) =
      _$EncounterParticipantCopyWithImpl<$Res, EncounterParticipant>;
  @useResult
  $Res call({Reference? individual});

  $ReferenceCopyWith<$Res>? get individual;
}

/// @nodoc
class _$EncounterParticipantCopyWithImpl<$Res,
        $Val extends EncounterParticipant>
    implements $EncounterParticipantCopyWith<$Res> {
  _$EncounterParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? individual = freezed,
  }) {
    return _then(_value.copyWith(
      individual: freezed == individual
          ? _value.individual
          : individual // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get individual {
    if (_value.individual == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.individual!, (value) {
      return _then(_value.copyWith(individual: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EncounterParticipantImplCopyWith<$Res>
    implements $EncounterParticipantCopyWith<$Res> {
  factory _$$EncounterParticipantImplCopyWith(_$EncounterParticipantImpl value,
          $Res Function(_$EncounterParticipantImpl) then) =
      __$$EncounterParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Reference? individual});

  @override
  $ReferenceCopyWith<$Res>? get individual;
}

/// @nodoc
class __$$EncounterParticipantImplCopyWithImpl<$Res>
    extends _$EncounterParticipantCopyWithImpl<$Res, _$EncounterParticipantImpl>
    implements _$$EncounterParticipantImplCopyWith<$Res> {
  __$$EncounterParticipantImplCopyWithImpl(_$EncounterParticipantImpl _value,
      $Res Function(_$EncounterParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? individual = freezed,
  }) {
    return _then(_$EncounterParticipantImpl(
      individual: freezed == individual
          ? _value.individual
          : individual // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EncounterParticipantImpl implements _EncounterParticipant {
  _$EncounterParticipantImpl({this.individual});

  factory _$EncounterParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncounterParticipantImplFromJson(json);

  @override
  final Reference? individual;

  @override
  String toString() {
    return 'EncounterParticipant(individual: $individual)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncounterParticipantImpl &&
            (identical(other.individual, individual) ||
                other.individual == individual));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, individual);

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncounterParticipantImplCopyWith<_$EncounterParticipantImpl>
      get copyWith =>
          __$$EncounterParticipantImplCopyWithImpl<_$EncounterParticipantImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncounterParticipantImplToJson(
      this,
    );
  }
}

abstract class _EncounterParticipant implements EncounterParticipant {
  factory _EncounterParticipant({final Reference? individual}) =
      _$EncounterParticipantImpl;

  factory _EncounterParticipant.fromJson(Map<String, dynamic> json) =
      _$EncounterParticipantImpl.fromJson;

  @override
  Reference? get individual;

  /// Create a copy of EncounterParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncounterParticipantImplCopyWith<_$EncounterParticipantImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Reference _$ReferenceFromJson(Map<String, dynamic> json) {
  return _Reference.fromJson(json);
}

/// @nodoc
mixin _$Reference {
  String? get reference => throw _privateConstructorUsedError;
  String? get display => throw _privateConstructorUsedError;

  /// Serializes this Reference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferenceCopyWith<Reference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceCopyWith<$Res> {
  factory $ReferenceCopyWith(Reference value, $Res Function(Reference) then) =
      _$ReferenceCopyWithImpl<$Res, Reference>;
  @useResult
  $Res call({String? reference, String? display});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? display = freezed,
  }) {
    return _then(_value.copyWith(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      display: freezed == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferenceImplCopyWith<$Res>
    implements $ReferenceCopyWith<$Res> {
  factory _$$ReferenceImplCopyWith(
          _$ReferenceImpl value, $Res Function(_$ReferenceImpl) then) =
      __$$ReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? reference, String? display});
}

/// @nodoc
class __$$ReferenceImplCopyWithImpl<$Res>
    extends _$ReferenceCopyWithImpl<$Res, _$ReferenceImpl>
    implements _$$ReferenceImplCopyWith<$Res> {
  __$$ReferenceImplCopyWithImpl(
      _$ReferenceImpl _value, $Res Function(_$ReferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = freezed,
    Object? display = freezed,
  }) {
    return _then(_$ReferenceImpl(
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
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
class _$ReferenceImpl implements _Reference {
  _$ReferenceImpl({this.reference, this.display});

  factory _$ReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferenceImplFromJson(json);

  @override
  final String? reference;
  @override
  final String? display;

  @override
  String toString() {
    return 'Reference(reference: $reference, display: $display)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferenceImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.display, display) || other.display == display));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reference, display);

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferenceImplCopyWith<_$ReferenceImpl> get copyWith =>
      __$$ReferenceImplCopyWithImpl<_$ReferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferenceImplToJson(
      this,
    );
  }
}

abstract class _Reference implements Reference {
  factory _Reference({final String? reference, final String? display}) =
      _$ReferenceImpl;

  factory _Reference.fromJson(Map<String, dynamic> json) =
      _$ReferenceImpl.fromJson;

  @override
  String? get reference;
  @override
  String? get display;

  /// Create a copy of Reference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferenceImplCopyWith<_$ReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
