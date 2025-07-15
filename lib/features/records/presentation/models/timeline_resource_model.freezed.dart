// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_resource_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimelineResourceModel {
  String get id => throw _privateConstructorUsedError;
  String get resourceType => throw _privateConstructorUsedError;
  String get primaryDisplay => throw _privateConstructorUsedError;
  String? get secondaryDisplay => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  bool get isEncounter => throw _privateConstructorUsedError;
  bool get isStandalone => throw _privateConstructorUsedError;
  EncounterDisplayModel? get encounterModel =>
      throw _privateConstructorUsedError;
  FhirResourceDisplayModel? get resourceModel =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get rawResource => throw _privateConstructorUsedError;

  /// Create a copy of TimelineResourceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimelineResourceModelCopyWith<TimelineResourceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineResourceModelCopyWith<$Res> {
  factory $TimelineResourceModelCopyWith(TimelineResourceModel value,
          $Res Function(TimelineResourceModel) then) =
      _$TimelineResourceModelCopyWithImpl<$Res, TimelineResourceModel>;
  @useResult
  $Res call(
      {String id,
      String resourceType,
      String primaryDisplay,
      String? secondaryDisplay,
      String? date,
      String? status,
      String? category,
      bool isEncounter,
      bool isStandalone,
      EncounterDisplayModel? encounterModel,
      FhirResourceDisplayModel? resourceModel,
      Map<String, dynamic> rawResource});
}

/// @nodoc
class _$TimelineResourceModelCopyWithImpl<$Res,
        $Val extends TimelineResourceModel>
    implements $TimelineResourceModelCopyWith<$Res> {
  _$TimelineResourceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimelineResourceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? resourceType = null,
    Object? primaryDisplay = null,
    Object? secondaryDisplay = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? category = freezed,
    Object? isEncounter = null,
    Object? isStandalone = null,
    Object? encounterModel = freezed,
    Object? resourceModel = freezed,
    Object? rawResource = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      primaryDisplay: null == primaryDisplay
          ? _value.primaryDisplay
          : primaryDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDisplay: freezed == secondaryDisplay
          ? _value.secondaryDisplay
          : secondaryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isEncounter: null == isEncounter
          ? _value.isEncounter
          : isEncounter // ignore: cast_nullable_to_non_nullable
              as bool,
      isStandalone: null == isStandalone
          ? _value.isStandalone
          : isStandalone // ignore: cast_nullable_to_non_nullable
              as bool,
      encounterModel: freezed == encounterModel
          ? _value.encounterModel
          : encounterModel // ignore: cast_nullable_to_non_nullable
              as EncounterDisplayModel?,
      resourceModel: freezed == resourceModel
          ? _value.resourceModel
          : resourceModel // ignore: cast_nullable_to_non_nullable
              as FhirResourceDisplayModel?,
      rawResource: null == rawResource
          ? _value.rawResource
          : rawResource // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineResourceModelImplCopyWith<$Res>
    implements $TimelineResourceModelCopyWith<$Res> {
  factory _$$TimelineResourceModelImplCopyWith(
          _$TimelineResourceModelImpl value,
          $Res Function(_$TimelineResourceModelImpl) then) =
      __$$TimelineResourceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String resourceType,
      String primaryDisplay,
      String? secondaryDisplay,
      String? date,
      String? status,
      String? category,
      bool isEncounter,
      bool isStandalone,
      EncounterDisplayModel? encounterModel,
      FhirResourceDisplayModel? resourceModel,
      Map<String, dynamic> rawResource});
}

/// @nodoc
class __$$TimelineResourceModelImplCopyWithImpl<$Res>
    extends _$TimelineResourceModelCopyWithImpl<$Res,
        _$TimelineResourceModelImpl>
    implements _$$TimelineResourceModelImplCopyWith<$Res> {
  __$$TimelineResourceModelImplCopyWithImpl(_$TimelineResourceModelImpl _value,
      $Res Function(_$TimelineResourceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimelineResourceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? resourceType = null,
    Object? primaryDisplay = null,
    Object? secondaryDisplay = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? category = freezed,
    Object? isEncounter = null,
    Object? isStandalone = null,
    Object? encounterModel = freezed,
    Object? resourceModel = freezed,
    Object? rawResource = null,
  }) {
    return _then(_$TimelineResourceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      resourceType: null == resourceType
          ? _value.resourceType
          : resourceType // ignore: cast_nullable_to_non_nullable
              as String,
      primaryDisplay: null == primaryDisplay
          ? _value.primaryDisplay
          : primaryDisplay // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDisplay: freezed == secondaryDisplay
          ? _value.secondaryDisplay
          : secondaryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isEncounter: null == isEncounter
          ? _value.isEncounter
          : isEncounter // ignore: cast_nullable_to_non_nullable
              as bool,
      isStandalone: null == isStandalone
          ? _value.isStandalone
          : isStandalone // ignore: cast_nullable_to_non_nullable
              as bool,
      encounterModel: freezed == encounterModel
          ? _value.encounterModel
          : encounterModel // ignore: cast_nullable_to_non_nullable
              as EncounterDisplayModel?,
      resourceModel: freezed == resourceModel
          ? _value.resourceModel
          : resourceModel // ignore: cast_nullable_to_non_nullable
              as FhirResourceDisplayModel?,
      rawResource: null == rawResource
          ? _value._rawResource
          : rawResource // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$TimelineResourceModelImpl implements _TimelineResourceModel {
  const _$TimelineResourceModelImpl(
      {required this.id,
      required this.resourceType,
      required this.primaryDisplay,
      this.secondaryDisplay,
      this.date,
      this.status,
      this.category,
      required this.isEncounter,
      required this.isStandalone,
      this.encounterModel,
      this.resourceModel,
      required final Map<String, dynamic> rawResource})
      : _rawResource = rawResource;

  @override
  final String id;
  @override
  final String resourceType;
  @override
  final String primaryDisplay;
  @override
  final String? secondaryDisplay;
  @override
  final String? date;
  @override
  final String? status;
  @override
  final String? category;
  @override
  final bool isEncounter;
  @override
  final bool isStandalone;
  @override
  final EncounterDisplayModel? encounterModel;
  @override
  final FhirResourceDisplayModel? resourceModel;
  final Map<String, dynamic> _rawResource;
  @override
  Map<String, dynamic> get rawResource {
    if (_rawResource is EqualUnmodifiableMapView) return _rawResource;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rawResource);
  }

  @override
  String toString() {
    return 'TimelineResourceModel(id: $id, resourceType: $resourceType, primaryDisplay: $primaryDisplay, secondaryDisplay: $secondaryDisplay, date: $date, status: $status, category: $category, isEncounter: $isEncounter, isStandalone: $isStandalone, encounterModel: $encounterModel, resourceModel: $resourceModel, rawResource: $rawResource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineResourceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType) &&
            (identical(other.primaryDisplay, primaryDisplay) ||
                other.primaryDisplay == primaryDisplay) &&
            (identical(other.secondaryDisplay, secondaryDisplay) ||
                other.secondaryDisplay == secondaryDisplay) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isEncounter, isEncounter) ||
                other.isEncounter == isEncounter) &&
            (identical(other.isStandalone, isStandalone) ||
                other.isStandalone == isStandalone) &&
            (identical(other.encounterModel, encounterModel) ||
                other.encounterModel == encounterModel) &&
            (identical(other.resourceModel, resourceModel) ||
                other.resourceModel == resourceModel) &&
            const DeepCollectionEquality()
                .equals(other._rawResource, _rawResource));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      resourceType,
      primaryDisplay,
      secondaryDisplay,
      date,
      status,
      category,
      isEncounter,
      isStandalone,
      encounterModel,
      resourceModel,
      const DeepCollectionEquality().hash(_rawResource));

  /// Create a copy of TimelineResourceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineResourceModelImplCopyWith<_$TimelineResourceModelImpl>
      get copyWith => __$$TimelineResourceModelImplCopyWithImpl<
          _$TimelineResourceModelImpl>(this, _$identity);
}

abstract class _TimelineResourceModel implements TimelineResourceModel {
  const factory _TimelineResourceModel(
          {required final String id,
          required final String resourceType,
          required final String primaryDisplay,
          final String? secondaryDisplay,
          final String? date,
          final String? status,
          final String? category,
          required final bool isEncounter,
          required final bool isStandalone,
          final EncounterDisplayModel? encounterModel,
          final FhirResourceDisplayModel? resourceModel,
          required final Map<String, dynamic> rawResource}) =
      _$TimelineResourceModelImpl;

  @override
  String get id;
  @override
  String get resourceType;
  @override
  String get primaryDisplay;
  @override
  String? get secondaryDisplay;
  @override
  String? get date;
  @override
  String? get status;
  @override
  String? get category;
  @override
  bool get isEncounter;
  @override
  bool get isStandalone;
  @override
  EncounterDisplayModel? get encounterModel;
  @override
  FhirResourceDisplayModel? get resourceModel;
  @override
  Map<String, dynamic> get rawResource;

  /// Create a copy of TimelineResourceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimelineResourceModelImplCopyWith<_$TimelineResourceModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
