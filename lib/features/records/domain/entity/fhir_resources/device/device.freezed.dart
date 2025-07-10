// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return _Device.fromJson(json);
}

/// @nodoc
mixin _$Device {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_expiry')
  bool? get hasExpiry => throw _privateConstructorUsedError;
  @JsonKey(name: 'get_expiry')
  String? get getExpiry => throw _privateConstructorUsedError;
  @JsonKey(name: 'get_type_coding')
  List<Coding>? get getTypeCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_type_coding')
  bool? get hasTypeCoding => throw _privateConstructorUsedError;
  @JsonKey(name: 'get_udi')
  String? get getUdi => throw _privateConstructorUsedError;
  @JsonKey(name: 'udi_carrier_aidc')
  String? get udiCarrierAidc => throw _privateConstructorUsedError;
  @JsonKey(name: 'udi_carrier_hrf')
  String? get udiCarrierHrf => throw _privateConstructorUsedError;
  String? get safety => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_safety')
  bool? get hasSafety => throw _privateConstructorUsedError;

  /// Serializes this Device to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceCopyWith<Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceCopyWith<$Res> {
  factory $DeviceCopyWith(Device value, $Res Function(Device) then) =
      _$DeviceCopyWithImpl<$Res, Device>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? model,
      String? status,
      @JsonKey(name: 'has_expiry') bool? hasExpiry,
      @JsonKey(name: 'get_expiry') String? getExpiry,
      @JsonKey(name: 'get_type_coding') List<Coding>? getTypeCoding,
      @JsonKey(name: 'has_type_coding') bool? hasTypeCoding,
      @JsonKey(name: 'get_udi') String? getUdi,
      @JsonKey(name: 'udi_carrier_aidc') String? udiCarrierAidc,
      @JsonKey(name: 'udi_carrier_hrf') String? udiCarrierHrf,
      String? safety,
      @JsonKey(name: 'has_safety') bool? hasSafety});

  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class _$DeviceCopyWithImpl<$Res, $Val extends Device>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? model = freezed,
    Object? status = freezed,
    Object? hasExpiry = freezed,
    Object? getExpiry = freezed,
    Object? getTypeCoding = freezed,
    Object? hasTypeCoding = freezed,
    Object? getUdi = freezed,
    Object? udiCarrierAidc = freezed,
    Object? udiCarrierHrf = freezed,
    Object? safety = freezed,
    Object? hasSafety = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      hasExpiry: freezed == hasExpiry
          ? _value.hasExpiry
          : hasExpiry // ignore: cast_nullable_to_non_nullable
              as bool?,
      getExpiry: freezed == getExpiry
          ? _value.getExpiry
          : getExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      getTypeCoding: freezed == getTypeCoding
          ? _value.getTypeCoding
          : getTypeCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasTypeCoding: freezed == hasTypeCoding
          ? _value.hasTypeCoding
          : hasTypeCoding // ignore: cast_nullable_to_non_nullable
              as bool?,
      getUdi: freezed == getUdi
          ? _value.getUdi
          : getUdi // ignore: cast_nullable_to_non_nullable
              as String?,
      udiCarrierAidc: freezed == udiCarrierAidc
          ? _value.udiCarrierAidc
          : udiCarrierAidc // ignore: cast_nullable_to_non_nullable
              as String?,
      udiCarrierHrf: freezed == udiCarrierHrf
          ? _value.udiCarrierHrf
          : udiCarrierHrf // ignore: cast_nullable_to_non_nullable
              as String?,
      safety: freezed == safety
          ? _value.safety
          : safety // ignore: cast_nullable_to_non_nullable
              as String?,
      hasSafety: freezed == hasSafety
          ? _value.hasSafety
          : hasSafety // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get code {
    if (_value.code == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.code!, (value) {
      return _then(_value.copyWith(code: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeviceImplCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$$DeviceImplCopyWith(
          _$DeviceImpl value, $Res Function(_$DeviceImpl) then) =
      __$$DeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      String? model,
      String? status,
      @JsonKey(name: 'has_expiry') bool? hasExpiry,
      @JsonKey(name: 'get_expiry') String? getExpiry,
      @JsonKey(name: 'get_type_coding') List<Coding>? getTypeCoding,
      @JsonKey(name: 'has_type_coding') bool? hasTypeCoding,
      @JsonKey(name: 'get_udi') String? getUdi,
      @JsonKey(name: 'udi_carrier_aidc') String? udiCarrierAidc,
      @JsonKey(name: 'udi_carrier_hrf') String? udiCarrierHrf,
      String? safety,
      @JsonKey(name: 'has_safety') bool? hasSafety});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
}

/// @nodoc
class __$$DeviceImplCopyWithImpl<$Res>
    extends _$DeviceCopyWithImpl<$Res, _$DeviceImpl>
    implements _$$DeviceImplCopyWith<$Res> {
  __$$DeviceImplCopyWithImpl(
      _$DeviceImpl _value, $Res Function(_$DeviceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? model = freezed,
    Object? status = freezed,
    Object? hasExpiry = freezed,
    Object? getExpiry = freezed,
    Object? getTypeCoding = freezed,
    Object? hasTypeCoding = freezed,
    Object? getUdi = freezed,
    Object? udiCarrierAidc = freezed,
    Object? udiCarrierHrf = freezed,
    Object? safety = freezed,
    Object? hasSafety = freezed,
  }) {
    return _then(_$DeviceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      hasExpiry: freezed == hasExpiry
          ? _value.hasExpiry
          : hasExpiry // ignore: cast_nullable_to_non_nullable
              as bool?,
      getExpiry: freezed == getExpiry
          ? _value.getExpiry
          : getExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      getTypeCoding: freezed == getTypeCoding
          ? _value._getTypeCoding
          : getTypeCoding // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasTypeCoding: freezed == hasTypeCoding
          ? _value.hasTypeCoding
          : hasTypeCoding // ignore: cast_nullable_to_non_nullable
              as bool?,
      getUdi: freezed == getUdi
          ? _value.getUdi
          : getUdi // ignore: cast_nullable_to_non_nullable
              as String?,
      udiCarrierAidc: freezed == udiCarrierAidc
          ? _value.udiCarrierAidc
          : udiCarrierAidc // ignore: cast_nullable_to_non_nullable
              as String?,
      udiCarrierHrf: freezed == udiCarrierHrf
          ? _value.udiCarrierHrf
          : udiCarrierHrf // ignore: cast_nullable_to_non_nullable
              as String?,
      safety: freezed == safety
          ? _value.safety
          : safety // ignore: cast_nullable_to_non_nullable
              as String?,
      hasSafety: freezed == hasSafety
          ? _value.hasSafety
          : hasSafety // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceImpl implements _Device {
  _$DeviceImpl(
      {this.id,
      this.code,
      this.model,
      this.status,
      @JsonKey(name: 'has_expiry') this.hasExpiry,
      @JsonKey(name: 'get_expiry') this.getExpiry,
      @JsonKey(name: 'get_type_coding') final List<Coding>? getTypeCoding,
      @JsonKey(name: 'has_type_coding') this.hasTypeCoding,
      @JsonKey(name: 'get_udi') this.getUdi,
      @JsonKey(name: 'udi_carrier_aidc') this.udiCarrierAidc,
      @JsonKey(name: 'udi_carrier_hrf') this.udiCarrierHrf,
      this.safety,
      @JsonKey(name: 'has_safety') this.hasSafety})
      : _getTypeCoding = getTypeCoding;

  factory _$DeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  final String? model;
  @override
  final String? status;
  @override
  @JsonKey(name: 'has_expiry')
  final bool? hasExpiry;
  @override
  @JsonKey(name: 'get_expiry')
  final String? getExpiry;
  final List<Coding>? _getTypeCoding;
  @override
  @JsonKey(name: 'get_type_coding')
  List<Coding>? get getTypeCoding {
    final value = _getTypeCoding;
    if (value == null) return null;
    if (_getTypeCoding is EqualUnmodifiableListView) return _getTypeCoding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'has_type_coding')
  final bool? hasTypeCoding;
  @override
  @JsonKey(name: 'get_udi')
  final String? getUdi;
  @override
  @JsonKey(name: 'udi_carrier_aidc')
  final String? udiCarrierAidc;
  @override
  @JsonKey(name: 'udi_carrier_hrf')
  final String? udiCarrierHrf;
  @override
  final String? safety;
  @override
  @JsonKey(name: 'has_safety')
  final bool? hasSafety;

  @override
  String toString() {
    return 'Device(id: $id, code: $code, model: $model, status: $status, hasExpiry: $hasExpiry, getExpiry: $getExpiry, getTypeCoding: $getTypeCoding, hasTypeCoding: $hasTypeCoding, getUdi: $getUdi, udiCarrierAidc: $udiCarrierAidc, udiCarrierHrf: $udiCarrierHrf, safety: $safety, hasSafety: $hasSafety)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hasExpiry, hasExpiry) ||
                other.hasExpiry == hasExpiry) &&
            (identical(other.getExpiry, getExpiry) ||
                other.getExpiry == getExpiry) &&
            const DeepCollectionEquality()
                .equals(other._getTypeCoding, _getTypeCoding) &&
            (identical(other.hasTypeCoding, hasTypeCoding) ||
                other.hasTypeCoding == hasTypeCoding) &&
            (identical(other.getUdi, getUdi) || other.getUdi == getUdi) &&
            (identical(other.udiCarrierAidc, udiCarrierAidc) ||
                other.udiCarrierAidc == udiCarrierAidc) &&
            (identical(other.udiCarrierHrf, udiCarrierHrf) ||
                other.udiCarrierHrf == udiCarrierHrf) &&
            (identical(other.safety, safety) || other.safety == safety) &&
            (identical(other.hasSafety, hasSafety) ||
                other.hasSafety == hasSafety));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      model,
      status,
      hasExpiry,
      getExpiry,
      const DeepCollectionEquality().hash(_getTypeCoding),
      hasTypeCoding,
      getUdi,
      udiCarrierAidc,
      udiCarrierHrf,
      safety,
      hasSafety);

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      __$$DeviceImplCopyWithImpl<_$DeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceImplToJson(
      this,
    );
  }
}

abstract class _Device implements Device {
  factory _Device(
      {final String? id,
      final CodeableConcept? code,
      final String? model,
      final String? status,
      @JsonKey(name: 'has_expiry') final bool? hasExpiry,
      @JsonKey(name: 'get_expiry') final String? getExpiry,
      @JsonKey(name: 'get_type_coding') final List<Coding>? getTypeCoding,
      @JsonKey(name: 'has_type_coding') final bool? hasTypeCoding,
      @JsonKey(name: 'get_udi') final String? getUdi,
      @JsonKey(name: 'udi_carrier_aidc') final String? udiCarrierAidc,
      @JsonKey(name: 'udi_carrier_hrf') final String? udiCarrierHrf,
      final String? safety,
      @JsonKey(name: 'has_safety') final bool? hasSafety}) = _$DeviceImpl;

  factory _Device.fromJson(Map<String, dynamic> json) = _$DeviceImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  String? get model;
  @override
  String? get status;
  @override
  @JsonKey(name: 'has_expiry')
  bool? get hasExpiry;
  @override
  @JsonKey(name: 'get_expiry')
  String? get getExpiry;
  @override
  @JsonKey(name: 'get_type_coding')
  List<Coding>? get getTypeCoding;
  @override
  @JsonKey(name: 'has_type_coding')
  bool? get hasTypeCoding;
  @override
  @JsonKey(name: 'get_udi')
  String? get getUdi;
  @override
  @JsonKey(name: 'udi_carrier_aidc')
  String? get udiCarrierAidc;
  @override
  @JsonKey(name: 'udi_carrier_hrf')
  String? get udiCarrierHrf;
  @override
  String? get safety;
  @override
  @JsonKey(name: 'has_safety')
  bool? get hasSafety;

  /// Create a copy of Device
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceImplCopyWith<_$DeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
