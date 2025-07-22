// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explanation_of_benefit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExplanationOfBenefit _$ExplanationOfBenefitFromJson(Map<String, dynamic> json) {
  return _ExplanationOfBenefit.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefit {
  String? get id => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_text')
  String? get codeText => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_id')
  String? get codeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'code_system')
  String? get codeSystem => throw _privateConstructorUsedError;
  String? get disposition => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  Reference? get insurer => throw _privateConstructorUsedError;
  double? get totalBenefit => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  bool? get hasInsurer => throw _privateConstructorUsedError;
  bool? get hasType => throw _privateConstructorUsedError;
  List<Coding>? get type => throw _privateConstructorUsedError;
  bool? get hasServices => throw _privateConstructorUsedError;
  bool? get hasInformation => throw _privateConstructorUsedError;
  String? get resourceStatus => throw _privateConstructorUsedError;
  String? get useCode => throw _privateConstructorUsedError;
  Reference? get patient => throw _privateConstructorUsedError;
  Reference? get provider => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitInsurance>? get insurance =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitTotal>? get total =>
      throw _privateConstructorUsedError;
  bool? get hasTotal => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitDiagnosis>? get diagnosis =>
      throw _privateConstructorUsedError;
  bool? get hasDiagnosis => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitSupportingInfo>? get supportingInfo =>
      throw _privateConstructorUsedError;
  bool? get hasSupportingInfo => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitItem>? get items =>
      throw _privateConstructorUsedError;
  bool? get hasItems => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitPayment>? get payment =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitBillablePeriod>? get billablePeriod =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitIdentifier>? get identifier =>
      throw _privateConstructorUsedError;
  String? get outcome => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitCareTeam>? get careTeam =>
      throw _privateConstructorUsedError;
  bool? get hasCareTeam => throw _privateConstructorUsedError;
  CodeableConcept? get payeeType => throw _privateConstructorUsedError;
  Reference? get payeeParty => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitRelated>? get related =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitProcedure>? get procedures =>
      throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitCopyWith<ExplanationOfBenefit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitCopyWith<$Res> {
  factory $ExplanationOfBenefitCopyWith(ExplanationOfBenefit value,
          $Res Function(ExplanationOfBenefit) then) =
      _$ExplanationOfBenefitCopyWithImpl<$Res, ExplanationOfBenefit>;
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'code_text') String? codeText,
      @JsonKey(name: 'code_id') String? codeId,
      @JsonKey(name: 'code_system') String? codeSystem,
      String? disposition,
      String? created,
      Reference? insurer,
      double? totalBenefit,
      double? totalCost,
      bool? hasInsurer,
      bool? hasType,
      List<Coding>? type,
      bool? hasServices,
      bool? hasInformation,
      String? resourceStatus,
      String? useCode,
      Reference? patient,
      Reference? provider,
      List<ExplanationOfBenefitInsurance>? insurance,
      List<ExplanationOfBenefitTotal>? total,
      bool? hasTotal,
      List<ExplanationOfBenefitDiagnosis>? diagnosis,
      bool? hasDiagnosis,
      List<ExplanationOfBenefitSupportingInfo>? supportingInfo,
      bool? hasSupportingInfo,
      List<ExplanationOfBenefitItem>? items,
      bool? hasItems,
      List<ExplanationOfBenefitPayment>? payment,
      List<ExplanationOfBenefitBillablePeriod>? billablePeriod,
      List<ExplanationOfBenefitIdentifier>? identifier,
      String? outcome,
      List<ExplanationOfBenefitCareTeam>? careTeam,
      bool? hasCareTeam,
      CodeableConcept? payeeType,
      Reference? payeeParty,
      List<ExplanationOfBenefitRelated>? related,
      List<ExplanationOfBenefitProcedure>? procedures});

  $CodeableConceptCopyWith<$Res>? get code;
  $ReferenceCopyWith<$Res>? get insurer;
  $ReferenceCopyWith<$Res>? get patient;
  $ReferenceCopyWith<$Res>? get provider;
  $CodeableConceptCopyWith<$Res>? get payeeType;
  $ReferenceCopyWith<$Res>? get payeeParty;
}

/// @nodoc
class _$ExplanationOfBenefitCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefit>
    implements $ExplanationOfBenefitCopyWith<$Res> {
  _$ExplanationOfBenefitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? codeText = freezed,
    Object? codeId = freezed,
    Object? codeSystem = freezed,
    Object? disposition = freezed,
    Object? created = freezed,
    Object? insurer = freezed,
    Object? totalBenefit = freezed,
    Object? totalCost = freezed,
    Object? hasInsurer = freezed,
    Object? hasType = freezed,
    Object? type = freezed,
    Object? hasServices = freezed,
    Object? hasInformation = freezed,
    Object? resourceStatus = freezed,
    Object? useCode = freezed,
    Object? patient = freezed,
    Object? provider = freezed,
    Object? insurance = freezed,
    Object? total = freezed,
    Object? hasTotal = freezed,
    Object? diagnosis = freezed,
    Object? hasDiagnosis = freezed,
    Object? supportingInfo = freezed,
    Object? hasSupportingInfo = freezed,
    Object? items = freezed,
    Object? hasItems = freezed,
    Object? payment = freezed,
    Object? billablePeriod = freezed,
    Object? identifier = freezed,
    Object? outcome = freezed,
    Object? careTeam = freezed,
    Object? hasCareTeam = freezed,
    Object? payeeType = freezed,
    Object? payeeParty = freezed,
    Object? related = freezed,
    Object? procedures = freezed,
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
      codeText: freezed == codeText
          ? _value.codeText
          : codeText // ignore: cast_nullable_to_non_nullable
              as String?,
      codeId: freezed == codeId
          ? _value.codeId
          : codeId // ignore: cast_nullable_to_non_nullable
              as String?,
      codeSystem: freezed == codeSystem
          ? _value.codeSystem
          : codeSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      disposition: freezed == disposition
          ? _value.disposition
          : disposition // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      insurer: freezed == insurer
          ? _value.insurer
          : insurer // ignore: cast_nullable_to_non_nullable
              as Reference?,
      totalBenefit: freezed == totalBenefit
          ? _value.totalBenefit
          : totalBenefit // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      hasInsurer: freezed == hasInsurer
          ? _value.hasInsurer
          : hasInsurer // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasType: freezed == hasType
          ? _value.hasType
          : hasType // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasServices: freezed == hasServices
          ? _value.hasServices
          : hasServices // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasInformation: freezed == hasInformation
          ? _value.hasInformation
          : hasInformation // ignore: cast_nullable_to_non_nullable
              as bool?,
      resourceStatus: freezed == resourceStatus
          ? _value.resourceStatus
          : resourceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      useCode: freezed == useCode
          ? _value.useCode
          : useCode // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as Reference?,
      insurance: freezed == insurance
          ? _value.insurance
          : insurance // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitInsurance>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitTotal>?,
      hasTotal: freezed == hasTotal
          ? _value.hasTotal
          : hasTotal // ignore: cast_nullable_to_non_nullable
              as bool?,
      diagnosis: freezed == diagnosis
          ? _value.diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitDiagnosis>?,
      hasDiagnosis: freezed == hasDiagnosis
          ? _value.hasDiagnosis
          : hasDiagnosis // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportingInfo: freezed == supportingInfo
          ? _value.supportingInfo
          : supportingInfo // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitSupportingInfo>?,
      hasSupportingInfo: freezed == hasSupportingInfo
          ? _value.hasSupportingInfo
          : hasSupportingInfo // ignore: cast_nullable_to_non_nullable
              as bool?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitItem>?,
      hasItems: freezed == hasItems
          ? _value.hasItems
          : hasItems // ignore: cast_nullable_to_non_nullable
              as bool?,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitPayment>?,
      billablePeriod: freezed == billablePeriod
          ? _value.billablePeriod
          : billablePeriod // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitBillablePeriod>?,
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitIdentifier>?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      careTeam: freezed == careTeam
          ? _value.careTeam
          : careTeam // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitCareTeam>?,
      hasCareTeam: freezed == hasCareTeam
          ? _value.hasCareTeam
          : hasCareTeam // ignore: cast_nullable_to_non_nullable
              as bool?,
      payeeType: freezed == payeeType
          ? _value.payeeType
          : payeeType // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      payeeParty: freezed == payeeParty
          ? _value.payeeParty
          : payeeParty // ignore: cast_nullable_to_non_nullable
              as Reference?,
      related: freezed == related
          ? _value.related
          : related // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitRelated>?,
      procedures: freezed == procedures
          ? _value.procedures
          : procedures // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitProcedure>?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefit
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

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get insurer {
    if (_value.insurer == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.insurer!, (value) {
      return _then(_value.copyWith(insurer: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get provider {
    if (_value.provider == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.provider!, (value) {
      return _then(_value.copyWith(provider: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get payeeType {
    if (_value.payeeType == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.payeeType!, (value) {
      return _then(_value.copyWith(payeeType: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get payeeParty {
    if (_value.payeeParty == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.payeeParty!, (value) {
      return _then(_value.copyWith(payeeParty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitImplCopyWith<$Res>
    implements $ExplanationOfBenefitCopyWith<$Res> {
  factory _$$ExplanationOfBenefitImplCopyWith(_$ExplanationOfBenefitImpl value,
          $Res Function(_$ExplanationOfBenefitImpl) then) =
      __$$ExplanationOfBenefitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CodeableConcept? code,
      @JsonKey(name: 'code_text') String? codeText,
      @JsonKey(name: 'code_id') String? codeId,
      @JsonKey(name: 'code_system') String? codeSystem,
      String? disposition,
      String? created,
      Reference? insurer,
      double? totalBenefit,
      double? totalCost,
      bool? hasInsurer,
      bool? hasType,
      List<Coding>? type,
      bool? hasServices,
      bool? hasInformation,
      String? resourceStatus,
      String? useCode,
      Reference? patient,
      Reference? provider,
      List<ExplanationOfBenefitInsurance>? insurance,
      List<ExplanationOfBenefitTotal>? total,
      bool? hasTotal,
      List<ExplanationOfBenefitDiagnosis>? diagnosis,
      bool? hasDiagnosis,
      List<ExplanationOfBenefitSupportingInfo>? supportingInfo,
      bool? hasSupportingInfo,
      List<ExplanationOfBenefitItem>? items,
      bool? hasItems,
      List<ExplanationOfBenefitPayment>? payment,
      List<ExplanationOfBenefitBillablePeriod>? billablePeriod,
      List<ExplanationOfBenefitIdentifier>? identifier,
      String? outcome,
      List<ExplanationOfBenefitCareTeam>? careTeam,
      bool? hasCareTeam,
      CodeableConcept? payeeType,
      Reference? payeeParty,
      List<ExplanationOfBenefitRelated>? related,
      List<ExplanationOfBenefitProcedure>? procedures});

  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $ReferenceCopyWith<$Res>? get insurer;
  @override
  $ReferenceCopyWith<$Res>? get patient;
  @override
  $ReferenceCopyWith<$Res>? get provider;
  @override
  $CodeableConceptCopyWith<$Res>? get payeeType;
  @override
  $ReferenceCopyWith<$Res>? get payeeParty;
}

/// @nodoc
class __$$ExplanationOfBenefitImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitCopyWithImpl<$Res, _$ExplanationOfBenefitImpl>
    implements _$$ExplanationOfBenefitImplCopyWith<$Res> {
  __$$ExplanationOfBenefitImplCopyWithImpl(_$ExplanationOfBenefitImpl _value,
      $Res Function(_$ExplanationOfBenefitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
    Object? codeText = freezed,
    Object? codeId = freezed,
    Object? codeSystem = freezed,
    Object? disposition = freezed,
    Object? created = freezed,
    Object? insurer = freezed,
    Object? totalBenefit = freezed,
    Object? totalCost = freezed,
    Object? hasInsurer = freezed,
    Object? hasType = freezed,
    Object? type = freezed,
    Object? hasServices = freezed,
    Object? hasInformation = freezed,
    Object? resourceStatus = freezed,
    Object? useCode = freezed,
    Object? patient = freezed,
    Object? provider = freezed,
    Object? insurance = freezed,
    Object? total = freezed,
    Object? hasTotal = freezed,
    Object? diagnosis = freezed,
    Object? hasDiagnosis = freezed,
    Object? supportingInfo = freezed,
    Object? hasSupportingInfo = freezed,
    Object? items = freezed,
    Object? hasItems = freezed,
    Object? payment = freezed,
    Object? billablePeriod = freezed,
    Object? identifier = freezed,
    Object? outcome = freezed,
    Object? careTeam = freezed,
    Object? hasCareTeam = freezed,
    Object? payeeType = freezed,
    Object? payeeParty = freezed,
    Object? related = freezed,
    Object? procedures = freezed,
  }) {
    return _then(_$ExplanationOfBenefitImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      codeText: freezed == codeText
          ? _value.codeText
          : codeText // ignore: cast_nullable_to_non_nullable
              as String?,
      codeId: freezed == codeId
          ? _value.codeId
          : codeId // ignore: cast_nullable_to_non_nullable
              as String?,
      codeSystem: freezed == codeSystem
          ? _value.codeSystem
          : codeSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      disposition: freezed == disposition
          ? _value.disposition
          : disposition // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      insurer: freezed == insurer
          ? _value.insurer
          : insurer // ignore: cast_nullable_to_non_nullable
              as Reference?,
      totalBenefit: freezed == totalBenefit
          ? _value.totalBenefit
          : totalBenefit // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      hasInsurer: freezed == hasInsurer
          ? _value.hasInsurer
          : hasInsurer // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasType: freezed == hasType
          ? _value.hasType
          : hasType // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<Coding>?,
      hasServices: freezed == hasServices
          ? _value.hasServices
          : hasServices // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasInformation: freezed == hasInformation
          ? _value.hasInformation
          : hasInformation // ignore: cast_nullable_to_non_nullable
              as bool?,
      resourceStatus: freezed == resourceStatus
          ? _value.resourceStatus
          : resourceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      useCode: freezed == useCode
          ? _value.useCode
          : useCode // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as Reference?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as Reference?,
      insurance: freezed == insurance
          ? _value._insurance
          : insurance // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitInsurance>?,
      total: freezed == total
          ? _value._total
          : total // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitTotal>?,
      hasTotal: freezed == hasTotal
          ? _value.hasTotal
          : hasTotal // ignore: cast_nullable_to_non_nullable
              as bool?,
      diagnosis: freezed == diagnosis
          ? _value._diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitDiagnosis>?,
      hasDiagnosis: freezed == hasDiagnosis
          ? _value.hasDiagnosis
          : hasDiagnosis // ignore: cast_nullable_to_non_nullable
              as bool?,
      supportingInfo: freezed == supportingInfo
          ? _value._supportingInfo
          : supportingInfo // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitSupportingInfo>?,
      hasSupportingInfo: freezed == hasSupportingInfo
          ? _value.hasSupportingInfo
          : hasSupportingInfo // ignore: cast_nullable_to_non_nullable
              as bool?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitItem>?,
      hasItems: freezed == hasItems
          ? _value.hasItems
          : hasItems // ignore: cast_nullable_to_non_nullable
              as bool?,
      payment: freezed == payment
          ? _value._payment
          : payment // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitPayment>?,
      billablePeriod: freezed == billablePeriod
          ? _value._billablePeriod
          : billablePeriod // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitBillablePeriod>?,
      identifier: freezed == identifier
          ? _value._identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitIdentifier>?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      careTeam: freezed == careTeam
          ? _value._careTeam
          : careTeam // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitCareTeam>?,
      hasCareTeam: freezed == hasCareTeam
          ? _value.hasCareTeam
          : hasCareTeam // ignore: cast_nullable_to_non_nullable
              as bool?,
      payeeType: freezed == payeeType
          ? _value.payeeType
          : payeeType // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      payeeParty: freezed == payeeParty
          ? _value.payeeParty
          : payeeParty // ignore: cast_nullable_to_non_nullable
              as Reference?,
      related: freezed == related
          ? _value._related
          : related // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitRelated>?,
      procedures: freezed == procedures
          ? _value._procedures
          : procedures // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitProcedure>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitImpl implements _ExplanationOfBenefit {
  _$ExplanationOfBenefitImpl(
      {this.id,
      this.code,
      @JsonKey(name: 'code_text') this.codeText,
      @JsonKey(name: 'code_id') this.codeId,
      @JsonKey(name: 'code_system') this.codeSystem,
      this.disposition,
      this.created,
      this.insurer,
      this.totalBenefit,
      this.totalCost,
      this.hasInsurer,
      this.hasType,
      final List<Coding>? type,
      this.hasServices,
      this.hasInformation,
      this.resourceStatus,
      this.useCode,
      this.patient,
      this.provider,
      final List<ExplanationOfBenefitInsurance>? insurance,
      final List<ExplanationOfBenefitTotal>? total,
      this.hasTotal,
      final List<ExplanationOfBenefitDiagnosis>? diagnosis,
      this.hasDiagnosis,
      final List<ExplanationOfBenefitSupportingInfo>? supportingInfo,
      this.hasSupportingInfo,
      final List<ExplanationOfBenefitItem>? items,
      this.hasItems,
      final List<ExplanationOfBenefitPayment>? payment,
      final List<ExplanationOfBenefitBillablePeriod>? billablePeriod,
      final List<ExplanationOfBenefitIdentifier>? identifier,
      this.outcome,
      final List<ExplanationOfBenefitCareTeam>? careTeam,
      this.hasCareTeam,
      this.payeeType,
      this.payeeParty,
      final List<ExplanationOfBenefitRelated>? related,
      final List<ExplanationOfBenefitProcedure>? procedures})
      : _type = type,
        _insurance = insurance,
        _total = total,
        _diagnosis = diagnosis,
        _supportingInfo = supportingInfo,
        _items = items,
        _payment = payment,
        _billablePeriod = billablePeriod,
        _identifier = identifier,
        _careTeam = careTeam,
        _related = related,
        _procedures = procedures;

  factory _$ExplanationOfBenefitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitImplFromJson(json);

  @override
  final String? id;
  @override
  final CodeableConcept? code;
  @override
  @JsonKey(name: 'code_text')
  final String? codeText;
  @override
  @JsonKey(name: 'code_id')
  final String? codeId;
  @override
  @JsonKey(name: 'code_system')
  final String? codeSystem;
  @override
  final String? disposition;
  @override
  final String? created;
  @override
  final Reference? insurer;
  @override
  final double? totalBenefit;
  @override
  final double? totalCost;
  @override
  final bool? hasInsurer;
  @override
  final bool? hasType;
  final List<Coding>? _type;
  @override
  List<Coding>? get type {
    final value = _type;
    if (value == null) return null;
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasServices;
  @override
  final bool? hasInformation;
  @override
  final String? resourceStatus;
  @override
  final String? useCode;
  @override
  final Reference? patient;
  @override
  final Reference? provider;
  final List<ExplanationOfBenefitInsurance>? _insurance;
  @override
  List<ExplanationOfBenefitInsurance>? get insurance {
    final value = _insurance;
    if (value == null) return null;
    if (_insurance is EqualUnmodifiableListView) return _insurance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitTotal>? _total;
  @override
  List<ExplanationOfBenefitTotal>? get total {
    final value = _total;
    if (value == null) return null;
    if (_total is EqualUnmodifiableListView) return _total;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasTotal;
  final List<ExplanationOfBenefitDiagnosis>? _diagnosis;
  @override
  List<ExplanationOfBenefitDiagnosis>? get diagnosis {
    final value = _diagnosis;
    if (value == null) return null;
    if (_diagnosis is EqualUnmodifiableListView) return _diagnosis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasDiagnosis;
  final List<ExplanationOfBenefitSupportingInfo>? _supportingInfo;
  @override
  List<ExplanationOfBenefitSupportingInfo>? get supportingInfo {
    final value = _supportingInfo;
    if (value == null) return null;
    if (_supportingInfo is EqualUnmodifiableListView) return _supportingInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasSupportingInfo;
  final List<ExplanationOfBenefitItem>? _items;
  @override
  List<ExplanationOfBenefitItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasItems;
  final List<ExplanationOfBenefitPayment>? _payment;
  @override
  List<ExplanationOfBenefitPayment>? get payment {
    final value = _payment;
    if (value == null) return null;
    if (_payment is EqualUnmodifiableListView) return _payment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitBillablePeriod>? _billablePeriod;
  @override
  List<ExplanationOfBenefitBillablePeriod>? get billablePeriod {
    final value = _billablePeriod;
    if (value == null) return null;
    if (_billablePeriod is EqualUnmodifiableListView) return _billablePeriod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitIdentifier>? _identifier;
  @override
  List<ExplanationOfBenefitIdentifier>? get identifier {
    final value = _identifier;
    if (value == null) return null;
    if (_identifier is EqualUnmodifiableListView) return _identifier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? outcome;
  final List<ExplanationOfBenefitCareTeam>? _careTeam;
  @override
  List<ExplanationOfBenefitCareTeam>? get careTeam {
    final value = _careTeam;
    if (value == null) return null;
    if (_careTeam is EqualUnmodifiableListView) return _careTeam;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasCareTeam;
  @override
  final CodeableConcept? payeeType;
  @override
  final Reference? payeeParty;
  final List<ExplanationOfBenefitRelated>? _related;
  @override
  List<ExplanationOfBenefitRelated>? get related {
    final value = _related;
    if (value == null) return null;
    if (_related is EqualUnmodifiableListView) return _related;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitProcedure>? _procedures;
  @override
  List<ExplanationOfBenefitProcedure>? get procedures {
    final value = _procedures;
    if (value == null) return null;
    if (_procedures is EqualUnmodifiableListView) return _procedures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExplanationOfBenefit(id: $id, code: $code, codeText: $codeText, codeId: $codeId, codeSystem: $codeSystem, disposition: $disposition, created: $created, insurer: $insurer, totalBenefit: $totalBenefit, totalCost: $totalCost, hasInsurer: $hasInsurer, hasType: $hasType, type: $type, hasServices: $hasServices, hasInformation: $hasInformation, resourceStatus: $resourceStatus, useCode: $useCode, patient: $patient, provider: $provider, insurance: $insurance, total: $total, hasTotal: $hasTotal, diagnosis: $diagnosis, hasDiagnosis: $hasDiagnosis, supportingInfo: $supportingInfo, hasSupportingInfo: $hasSupportingInfo, items: $items, hasItems: $hasItems, payment: $payment, billablePeriod: $billablePeriod, identifier: $identifier, outcome: $outcome, careTeam: $careTeam, hasCareTeam: $hasCareTeam, payeeType: $payeeType, payeeParty: $payeeParty, related: $related, procedures: $procedures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codeText, codeText) ||
                other.codeText == codeText) &&
            (identical(other.codeId, codeId) || other.codeId == codeId) &&
            (identical(other.codeSystem, codeSystem) ||
                other.codeSystem == codeSystem) &&
            (identical(other.disposition, disposition) ||
                other.disposition == disposition) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.insurer, insurer) || other.insurer == insurer) &&
            (identical(other.totalBenefit, totalBenefit) ||
                other.totalBenefit == totalBenefit) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.hasInsurer, hasInsurer) ||
                other.hasInsurer == hasInsurer) &&
            (identical(other.hasType, hasType) || other.hasType == hasType) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.hasServices, hasServices) ||
                other.hasServices == hasServices) &&
            (identical(other.hasInformation, hasInformation) ||
                other.hasInformation == hasInformation) &&
            (identical(other.resourceStatus, resourceStatus) ||
                other.resourceStatus == resourceStatus) &&
            (identical(other.useCode, useCode) || other.useCode == useCode) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality()
                .equals(other._insurance, _insurance) &&
            const DeepCollectionEquality().equals(other._total, _total) &&
            (identical(other.hasTotal, hasTotal) ||
                other.hasTotal == hasTotal) &&
            const DeepCollectionEquality()
                .equals(other._diagnosis, _diagnosis) &&
            (identical(other.hasDiagnosis, hasDiagnosis) ||
                other.hasDiagnosis == hasDiagnosis) &&
            const DeepCollectionEquality()
                .equals(other._supportingInfo, _supportingInfo) &&
            (identical(other.hasSupportingInfo, hasSupportingInfo) ||
                other.hasSupportingInfo == hasSupportingInfo) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasItems, hasItems) ||
                other.hasItems == hasItems) &&
            const DeepCollectionEquality().equals(other._payment, _payment) &&
            const DeepCollectionEquality()
                .equals(other._billablePeriod, _billablePeriod) &&
            const DeepCollectionEquality()
                .equals(other._identifier, _identifier) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            const DeepCollectionEquality().equals(other._careTeam, _careTeam) &&
            (identical(other.hasCareTeam, hasCareTeam) ||
                other.hasCareTeam == hasCareTeam) &&
            (identical(other.payeeType, payeeType) ||
                other.payeeType == payeeType) &&
            (identical(other.payeeParty, payeeParty) ||
                other.payeeParty == payeeParty) &&
            const DeepCollectionEquality().equals(other._related, _related) &&
            const DeepCollectionEquality()
                .equals(other._procedures, _procedures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        code,
        codeText,
        codeId,
        codeSystem,
        disposition,
        created,
        insurer,
        totalBenefit,
        totalCost,
        hasInsurer,
        hasType,
        const DeepCollectionEquality().hash(_type),
        hasServices,
        hasInformation,
        resourceStatus,
        useCode,
        patient,
        provider,
        const DeepCollectionEquality().hash(_insurance),
        const DeepCollectionEquality().hash(_total),
        hasTotal,
        const DeepCollectionEquality().hash(_diagnosis),
        hasDiagnosis,
        const DeepCollectionEquality().hash(_supportingInfo),
        hasSupportingInfo,
        const DeepCollectionEquality().hash(_items),
        hasItems,
        const DeepCollectionEquality().hash(_payment),
        const DeepCollectionEquality().hash(_billablePeriod),
        const DeepCollectionEquality().hash(_identifier),
        outcome,
        const DeepCollectionEquality().hash(_careTeam),
        hasCareTeam,
        payeeType,
        payeeParty,
        const DeepCollectionEquality().hash(_related),
        const DeepCollectionEquality().hash(_procedures)
      ]);

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitImplCopyWith<_$ExplanationOfBenefitImpl>
      get copyWith =>
          __$$ExplanationOfBenefitImplCopyWithImpl<_$ExplanationOfBenefitImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefit implements ExplanationOfBenefit {
  factory _ExplanationOfBenefit(
          {final String? id,
          final CodeableConcept? code,
          @JsonKey(name: 'code_text') final String? codeText,
          @JsonKey(name: 'code_id') final String? codeId,
          @JsonKey(name: 'code_system') final String? codeSystem,
          final String? disposition,
          final String? created,
          final Reference? insurer,
          final double? totalBenefit,
          final double? totalCost,
          final bool? hasInsurer,
          final bool? hasType,
          final List<Coding>? type,
          final bool? hasServices,
          final bool? hasInformation,
          final String? resourceStatus,
          final String? useCode,
          final Reference? patient,
          final Reference? provider,
          final List<ExplanationOfBenefitInsurance>? insurance,
          final List<ExplanationOfBenefitTotal>? total,
          final bool? hasTotal,
          final List<ExplanationOfBenefitDiagnosis>? diagnosis,
          final bool? hasDiagnosis,
          final List<ExplanationOfBenefitSupportingInfo>? supportingInfo,
          final bool? hasSupportingInfo,
          final List<ExplanationOfBenefitItem>? items,
          final bool? hasItems,
          final List<ExplanationOfBenefitPayment>? payment,
          final List<ExplanationOfBenefitBillablePeriod>? billablePeriod,
          final List<ExplanationOfBenefitIdentifier>? identifier,
          final String? outcome,
          final List<ExplanationOfBenefitCareTeam>? careTeam,
          final bool? hasCareTeam,
          final CodeableConcept? payeeType,
          final Reference? payeeParty,
          final List<ExplanationOfBenefitRelated>? related,
          final List<ExplanationOfBenefitProcedure>? procedures}) =
      _$ExplanationOfBenefitImpl;

  factory _ExplanationOfBenefit.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitImpl.fromJson;

  @override
  String? get id;
  @override
  CodeableConcept? get code;
  @override
  @JsonKey(name: 'code_text')
  String? get codeText;
  @override
  @JsonKey(name: 'code_id')
  String? get codeId;
  @override
  @JsonKey(name: 'code_system')
  String? get codeSystem;
  @override
  String? get disposition;
  @override
  String? get created;
  @override
  Reference? get insurer;
  @override
  double? get totalBenefit;
  @override
  double? get totalCost;
  @override
  bool? get hasInsurer;
  @override
  bool? get hasType;
  @override
  List<Coding>? get type;
  @override
  bool? get hasServices;
  @override
  bool? get hasInformation;
  @override
  String? get resourceStatus;
  @override
  String? get useCode;
  @override
  Reference? get patient;
  @override
  Reference? get provider;
  @override
  List<ExplanationOfBenefitInsurance>? get insurance;
  @override
  List<ExplanationOfBenefitTotal>? get total;
  @override
  bool? get hasTotal;
  @override
  List<ExplanationOfBenefitDiagnosis>? get diagnosis;
  @override
  bool? get hasDiagnosis;
  @override
  List<ExplanationOfBenefitSupportingInfo>? get supportingInfo;
  @override
  bool? get hasSupportingInfo;
  @override
  List<ExplanationOfBenefitItem>? get items;
  @override
  bool? get hasItems;
  @override
  List<ExplanationOfBenefitPayment>? get payment;
  @override
  List<ExplanationOfBenefitBillablePeriod>? get billablePeriod;
  @override
  List<ExplanationOfBenefitIdentifier>? get identifier;
  @override
  String? get outcome;
  @override
  List<ExplanationOfBenefitCareTeam>? get careTeam;
  @override
  bool? get hasCareTeam;
  @override
  CodeableConcept? get payeeType;
  @override
  Reference? get payeeParty;
  @override
  List<ExplanationOfBenefitRelated>? get related;
  @override
  List<ExplanationOfBenefitProcedure>? get procedures;

  /// Create a copy of ExplanationOfBenefit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitImplCopyWith<_$ExplanationOfBenefitImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitInsurance _$ExplanationOfBenefitInsuranceFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitInsurance.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitInsurance {
  bool? get focal => throw _privateConstructorUsedError;
  Reference? get coverage => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitInsurance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitInsuranceCopyWith<ExplanationOfBenefitInsurance>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitInsuranceCopyWith<$Res> {
  factory $ExplanationOfBenefitInsuranceCopyWith(
          ExplanationOfBenefitInsurance value,
          $Res Function(ExplanationOfBenefitInsurance) then) =
      _$ExplanationOfBenefitInsuranceCopyWithImpl<$Res,
          ExplanationOfBenefitInsurance>;
  @useResult
  $Res call({bool? focal, Reference? coverage});

  $ReferenceCopyWith<$Res>? get coverage;
}

/// @nodoc
class _$ExplanationOfBenefitInsuranceCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitInsurance>
    implements $ExplanationOfBenefitInsuranceCopyWith<$Res> {
  _$ExplanationOfBenefitInsuranceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focal = freezed,
    Object? coverage = freezed,
  }) {
    return _then(_value.copyWith(
      focal: freezed == focal
          ? _value.focal
          : focal // ignore: cast_nullable_to_non_nullable
              as bool?,
      coverage: freezed == coverage
          ? _value.coverage
          : coverage // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get coverage {
    if (_value.coverage == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.coverage!, (value) {
      return _then(_value.copyWith(coverage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitInsuranceImplCopyWith<$Res>
    implements $ExplanationOfBenefitInsuranceCopyWith<$Res> {
  factory _$$ExplanationOfBenefitInsuranceImplCopyWith(
          _$ExplanationOfBenefitInsuranceImpl value,
          $Res Function(_$ExplanationOfBenefitInsuranceImpl) then) =
      __$$ExplanationOfBenefitInsuranceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? focal, Reference? coverage});

  @override
  $ReferenceCopyWith<$Res>? get coverage;
}

/// @nodoc
class __$$ExplanationOfBenefitInsuranceImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitInsuranceCopyWithImpl<$Res,
        _$ExplanationOfBenefitInsuranceImpl>
    implements _$$ExplanationOfBenefitInsuranceImplCopyWith<$Res> {
  __$$ExplanationOfBenefitInsuranceImplCopyWithImpl(
      _$ExplanationOfBenefitInsuranceImpl _value,
      $Res Function(_$ExplanationOfBenefitInsuranceImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? focal = freezed,
    Object? coverage = freezed,
  }) {
    return _then(_$ExplanationOfBenefitInsuranceImpl(
      focal: freezed == focal
          ? _value.focal
          : focal // ignore: cast_nullable_to_non_nullable
              as bool?,
      coverage: freezed == coverage
          ? _value.coverage
          : coverage // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitInsuranceImpl
    implements _ExplanationOfBenefitInsurance {
  _$ExplanationOfBenefitInsuranceImpl({this.focal, this.coverage});

  factory _$ExplanationOfBenefitInsuranceImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitInsuranceImplFromJson(json);

  @override
  final bool? focal;
  @override
  final Reference? coverage;

  @override
  String toString() {
    return 'ExplanationOfBenefitInsurance(focal: $focal, coverage: $coverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitInsuranceImpl &&
            (identical(other.focal, focal) || other.focal == focal) &&
            (identical(other.coverage, coverage) ||
                other.coverage == coverage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, focal, coverage);

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitInsuranceImplCopyWith<
          _$ExplanationOfBenefitInsuranceImpl>
      get copyWith => __$$ExplanationOfBenefitInsuranceImplCopyWithImpl<
          _$ExplanationOfBenefitInsuranceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitInsuranceImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitInsurance
    implements ExplanationOfBenefitInsurance {
  factory _ExplanationOfBenefitInsurance(
      {final bool? focal,
      final Reference? coverage}) = _$ExplanationOfBenefitInsuranceImpl;

  factory _ExplanationOfBenefitInsurance.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitInsuranceImpl.fromJson;

  @override
  bool? get focal;
  @override
  Reference? get coverage;

  /// Create a copy of ExplanationOfBenefitInsurance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitInsuranceImplCopyWith<
          _$ExplanationOfBenefitInsuranceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitTotal _$ExplanationOfBenefitTotalFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitTotal.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitTotal {
  CodeableConcept? get category => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get amount => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitTotal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitTotalCopyWith<ExplanationOfBenefitTotal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitTotalCopyWith<$Res> {
  factory $ExplanationOfBenefitTotalCopyWith(ExplanationOfBenefitTotal value,
          $Res Function(ExplanationOfBenefitTotal) then) =
      _$ExplanationOfBenefitTotalCopyWithImpl<$Res, ExplanationOfBenefitTotal>;
  @useResult
  $Res call({CodeableConcept? category, ExplanationOfBenefitMoney? amount});

  $CodeableConceptCopyWith<$Res>? get category;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
}

/// @nodoc
class _$ExplanationOfBenefitTotalCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitTotal>
    implements $ExplanationOfBenefitTotalCopyWith<$Res> {
  _$ExplanationOfBenefitTotalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount {
    if (_value.amount == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.amount!, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitTotalImplCopyWith<$Res>
    implements $ExplanationOfBenefitTotalCopyWith<$Res> {
  factory _$$ExplanationOfBenefitTotalImplCopyWith(
          _$ExplanationOfBenefitTotalImpl value,
          $Res Function(_$ExplanationOfBenefitTotalImpl) then) =
      __$$ExplanationOfBenefitTotalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CodeableConcept? category, ExplanationOfBenefitMoney? amount});

  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
}

/// @nodoc
class __$$ExplanationOfBenefitTotalImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitTotalCopyWithImpl<$Res,
        _$ExplanationOfBenefitTotalImpl>
    implements _$$ExplanationOfBenefitTotalImplCopyWith<$Res> {
  __$$ExplanationOfBenefitTotalImplCopyWithImpl(
      _$ExplanationOfBenefitTotalImpl _value,
      $Res Function(_$ExplanationOfBenefitTotalImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$ExplanationOfBenefitTotalImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitTotalImpl implements _ExplanationOfBenefitTotal {
  _$ExplanationOfBenefitTotalImpl({this.category, this.amount});

  factory _$ExplanationOfBenefitTotalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitTotalImplFromJson(json);

  @override
  final CodeableConcept? category;
  @override
  final ExplanationOfBenefitMoney? amount;

  @override
  String toString() {
    return 'ExplanationOfBenefitTotal(category: $category, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitTotalImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, amount);

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitTotalImplCopyWith<_$ExplanationOfBenefitTotalImpl>
      get copyWith => __$$ExplanationOfBenefitTotalImplCopyWithImpl<
          _$ExplanationOfBenefitTotalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitTotalImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitTotal implements ExplanationOfBenefitTotal {
  factory _ExplanationOfBenefitTotal(
          {final CodeableConcept? category,
          final ExplanationOfBenefitMoney? amount}) =
      _$ExplanationOfBenefitTotalImpl;

  factory _ExplanationOfBenefitTotal.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitTotalImpl.fromJson;

  @override
  CodeableConcept? get category;
  @override
  ExplanationOfBenefitMoney? get amount;

  /// Create a copy of ExplanationOfBenefitTotal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitTotalImplCopyWith<_$ExplanationOfBenefitTotalImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitMoney _$ExplanationOfBenefitMoneyFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitMoney.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitMoney {
  double? get value => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitMoney to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitMoney
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitMoneyCopyWith<ExplanationOfBenefitMoney> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitMoneyCopyWith<$Res> {
  factory $ExplanationOfBenefitMoneyCopyWith(ExplanationOfBenefitMoney value,
          $Res Function(ExplanationOfBenefitMoney) then) =
      _$ExplanationOfBenefitMoneyCopyWithImpl<$Res, ExplanationOfBenefitMoney>;
  @useResult
  $Res call({double? value, String? currency});
}

/// @nodoc
class _$ExplanationOfBenefitMoneyCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitMoney>
    implements $ExplanationOfBenefitMoneyCopyWith<$Res> {
  _$ExplanationOfBenefitMoneyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitMoney
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitMoneyImplCopyWith<$Res>
    implements $ExplanationOfBenefitMoneyCopyWith<$Res> {
  factory _$$ExplanationOfBenefitMoneyImplCopyWith(
          _$ExplanationOfBenefitMoneyImpl value,
          $Res Function(_$ExplanationOfBenefitMoneyImpl) then) =
      __$$ExplanationOfBenefitMoneyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? value, String? currency});
}

/// @nodoc
class __$$ExplanationOfBenefitMoneyImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitMoneyCopyWithImpl<$Res,
        _$ExplanationOfBenefitMoneyImpl>
    implements _$$ExplanationOfBenefitMoneyImplCopyWith<$Res> {
  __$$ExplanationOfBenefitMoneyImplCopyWithImpl(
      _$ExplanationOfBenefitMoneyImpl _value,
      $Res Function(_$ExplanationOfBenefitMoneyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitMoney
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$ExplanationOfBenefitMoneyImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitMoneyImpl implements _ExplanationOfBenefitMoney {
  _$ExplanationOfBenefitMoneyImpl({this.value, this.currency});

  factory _$ExplanationOfBenefitMoneyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitMoneyImplFromJson(json);

  @override
  final double? value;
  @override
  final String? currency;

  @override
  String toString() {
    return 'ExplanationOfBenefitMoney(value: $value, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitMoneyImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, currency);

  /// Create a copy of ExplanationOfBenefitMoney
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitMoneyImplCopyWith<_$ExplanationOfBenefitMoneyImpl>
      get copyWith => __$$ExplanationOfBenefitMoneyImplCopyWithImpl<
          _$ExplanationOfBenefitMoneyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitMoneyImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitMoney implements ExplanationOfBenefitMoney {
  factory _ExplanationOfBenefitMoney(
      {final double? value,
      final String? currency}) = _$ExplanationOfBenefitMoneyImpl;

  factory _ExplanationOfBenefitMoney.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitMoneyImpl.fromJson;

  @override
  double? get value;
  @override
  String? get currency;

  /// Create a copy of ExplanationOfBenefitMoney
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitMoneyImplCopyWith<_$ExplanationOfBenefitMoneyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitDiagnosis _$ExplanationOfBenefitDiagnosisFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitDiagnosis.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitDiagnosis {
  int? get sequence => throw _privateConstructorUsedError;
  CodeableConcept? get diagnosisCodeableConcept =>
      throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitDiagnosis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitDiagnosisCopyWith<ExplanationOfBenefitDiagnosis>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitDiagnosisCopyWith<$Res> {
  factory $ExplanationOfBenefitDiagnosisCopyWith(
          ExplanationOfBenefitDiagnosis value,
          $Res Function(ExplanationOfBenefitDiagnosis) then) =
      _$ExplanationOfBenefitDiagnosisCopyWithImpl<$Res,
          ExplanationOfBenefitDiagnosis>;
  @useResult
  $Res call({int? sequence, CodeableConcept? diagnosisCodeableConcept});

  $CodeableConceptCopyWith<$Res>? get diagnosisCodeableConcept;
}

/// @nodoc
class _$ExplanationOfBenefitDiagnosisCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitDiagnosis>
    implements $ExplanationOfBenefitDiagnosisCopyWith<$Res> {
  _$ExplanationOfBenefitDiagnosisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? diagnosisCodeableConcept = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      diagnosisCodeableConcept: freezed == diagnosisCodeableConcept
          ? _value.diagnosisCodeableConcept
          : diagnosisCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get diagnosisCodeableConcept {
    if (_value.diagnosisCodeableConcept == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.diagnosisCodeableConcept!,
        (value) {
      return _then(_value.copyWith(diagnosisCodeableConcept: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitDiagnosisImplCopyWith<$Res>
    implements $ExplanationOfBenefitDiagnosisCopyWith<$Res> {
  factory _$$ExplanationOfBenefitDiagnosisImplCopyWith(
          _$ExplanationOfBenefitDiagnosisImpl value,
          $Res Function(_$ExplanationOfBenefitDiagnosisImpl) then) =
      __$$ExplanationOfBenefitDiagnosisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? sequence, CodeableConcept? diagnosisCodeableConcept});

  @override
  $CodeableConceptCopyWith<$Res>? get diagnosisCodeableConcept;
}

/// @nodoc
class __$$ExplanationOfBenefitDiagnosisImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitDiagnosisCopyWithImpl<$Res,
        _$ExplanationOfBenefitDiagnosisImpl>
    implements _$$ExplanationOfBenefitDiagnosisImplCopyWith<$Res> {
  __$$ExplanationOfBenefitDiagnosisImplCopyWithImpl(
      _$ExplanationOfBenefitDiagnosisImpl _value,
      $Res Function(_$ExplanationOfBenefitDiagnosisImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? diagnosisCodeableConcept = freezed,
  }) {
    return _then(_$ExplanationOfBenefitDiagnosisImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      diagnosisCodeableConcept: freezed == diagnosisCodeableConcept
          ? _value.diagnosisCodeableConcept
          : diagnosisCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitDiagnosisImpl
    implements _ExplanationOfBenefitDiagnosis {
  _$ExplanationOfBenefitDiagnosisImpl(
      {this.sequence, this.diagnosisCodeableConcept});

  factory _$ExplanationOfBenefitDiagnosisImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitDiagnosisImplFromJson(json);

  @override
  final int? sequence;
  @override
  final CodeableConcept? diagnosisCodeableConcept;

  @override
  String toString() {
    return 'ExplanationOfBenefitDiagnosis(sequence: $sequence, diagnosisCodeableConcept: $diagnosisCodeableConcept)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitDiagnosisImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(
                    other.diagnosisCodeableConcept, diagnosisCodeableConcept) ||
                other.diagnosisCodeableConcept == diagnosisCodeableConcept));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sequence, diagnosisCodeableConcept);

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitDiagnosisImplCopyWith<
          _$ExplanationOfBenefitDiagnosisImpl>
      get copyWith => __$$ExplanationOfBenefitDiagnosisImplCopyWithImpl<
          _$ExplanationOfBenefitDiagnosisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitDiagnosisImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitDiagnosis
    implements ExplanationOfBenefitDiagnosis {
  factory _ExplanationOfBenefitDiagnosis(
          {final int? sequence,
          final CodeableConcept? diagnosisCodeableConcept}) =
      _$ExplanationOfBenefitDiagnosisImpl;

  factory _ExplanationOfBenefitDiagnosis.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitDiagnosisImpl.fromJson;

  @override
  int? get sequence;
  @override
  CodeableConcept? get diagnosisCodeableConcept;

  /// Create a copy of ExplanationOfBenefitDiagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitDiagnosisImplCopyWith<
          _$ExplanationOfBenefitDiagnosisImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitSupportingInfo _$ExplanationOfBenefitSupportingInfoFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitSupportingInfo.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitSupportingInfo {
  int? get sequence => throw _privateConstructorUsedError;
  CodeableConcept? get category => throw _privateConstructorUsedError;
  CodeableConcept? get code => throw _privateConstructorUsedError;
  String? get timingDate => throw _privateConstructorUsedError;
  String? get timingPeriod => throw _privateConstructorUsedError;
  bool? get valueBoolean => throw _privateConstructorUsedError;
  String? get valueString => throw _privateConstructorUsedError;
  int? get valueQuantity => throw _privateConstructorUsedError;
  Attachment? get valueAttachment => throw _privateConstructorUsedError;
  Reference? get valueReference => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitSupportingInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitSupportingInfoCopyWith<
          ExplanationOfBenefitSupportingInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitSupportingInfoCopyWith<$Res> {
  factory $ExplanationOfBenefitSupportingInfoCopyWith(
          ExplanationOfBenefitSupportingInfo value,
          $Res Function(ExplanationOfBenefitSupportingInfo) then) =
      _$ExplanationOfBenefitSupportingInfoCopyWithImpl<$Res,
          ExplanationOfBenefitSupportingInfo>;
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? category,
      CodeableConcept? code,
      String? timingDate,
      String? timingPeriod,
      bool? valueBoolean,
      String? valueString,
      int? valueQuantity,
      Attachment? valueAttachment,
      Reference? valueReference});

  $CodeableConceptCopyWith<$Res>? get category;
  $CodeableConceptCopyWith<$Res>? get code;
  $AttachmentCopyWith<$Res>? get valueAttachment;
  $ReferenceCopyWith<$Res>? get valueReference;
}

/// @nodoc
class _$ExplanationOfBenefitSupportingInfoCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitSupportingInfo>
    implements $ExplanationOfBenefitSupportingInfoCopyWith<$Res> {
  _$ExplanationOfBenefitSupportingInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? category = freezed,
    Object? code = freezed,
    Object? timingDate = freezed,
    Object? timingPeriod = freezed,
    Object? valueBoolean = freezed,
    Object? valueString = freezed,
    Object? valueQuantity = freezed,
    Object? valueAttachment = freezed,
    Object? valueReference = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      timingDate: freezed == timingDate
          ? _value.timingDate
          : timingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timingPeriod: freezed == timingPeriod
          ? _value.timingPeriod
          : timingPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      valueBoolean: freezed == valueBoolean
          ? _value.valueBoolean
          : valueBoolean // ignore: cast_nullable_to_non_nullable
              as bool?,
      valueString: freezed == valueString
          ? _value.valueString
          : valueString // ignore: cast_nullable_to_non_nullable
              as String?,
      valueQuantity: freezed == valueQuantity
          ? _value.valueQuantity
          : valueQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      valueAttachment: freezed == valueAttachment
          ? _value.valueAttachment
          : valueAttachment // ignore: cast_nullable_to_non_nullable
              as Attachment?,
      valueReference: freezed == valueReference
          ? _value.valueReference
          : valueReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSupportingInfo
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

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttachmentCopyWith<$Res>? get valueAttachment {
    if (_value.valueAttachment == null) {
      return null;
    }

    return $AttachmentCopyWith<$Res>(_value.valueAttachment!, (value) {
      return _then(_value.copyWith(valueAttachment: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get valueReference {
    if (_value.valueReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.valueReference!, (value) {
      return _then(_value.copyWith(valueReference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitSupportingInfoImplCopyWith<$Res>
    implements $ExplanationOfBenefitSupportingInfoCopyWith<$Res> {
  factory _$$ExplanationOfBenefitSupportingInfoImplCopyWith(
          _$ExplanationOfBenefitSupportingInfoImpl value,
          $Res Function(_$ExplanationOfBenefitSupportingInfoImpl) then) =
      __$$ExplanationOfBenefitSupportingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? category,
      CodeableConcept? code,
      String? timingDate,
      String? timingPeriod,
      bool? valueBoolean,
      String? valueString,
      int? valueQuantity,
      Attachment? valueAttachment,
      Reference? valueReference});

  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodeableConceptCopyWith<$Res>? get code;
  @override
  $AttachmentCopyWith<$Res>? get valueAttachment;
  @override
  $ReferenceCopyWith<$Res>? get valueReference;
}

/// @nodoc
class __$$ExplanationOfBenefitSupportingInfoImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitSupportingInfoCopyWithImpl<$Res,
        _$ExplanationOfBenefitSupportingInfoImpl>
    implements _$$ExplanationOfBenefitSupportingInfoImplCopyWith<$Res> {
  __$$ExplanationOfBenefitSupportingInfoImplCopyWithImpl(
      _$ExplanationOfBenefitSupportingInfoImpl _value,
      $Res Function(_$ExplanationOfBenefitSupportingInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? category = freezed,
    Object? code = freezed,
    Object? timingDate = freezed,
    Object? timingPeriod = freezed,
    Object? valueBoolean = freezed,
    Object? valueString = freezed,
    Object? valueQuantity = freezed,
    Object? valueAttachment = freezed,
    Object? valueReference = freezed,
  }) {
    return _then(_$ExplanationOfBenefitSupportingInfoImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      timingDate: freezed == timingDate
          ? _value.timingDate
          : timingDate // ignore: cast_nullable_to_non_nullable
              as String?,
      timingPeriod: freezed == timingPeriod
          ? _value.timingPeriod
          : timingPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      valueBoolean: freezed == valueBoolean
          ? _value.valueBoolean
          : valueBoolean // ignore: cast_nullable_to_non_nullable
              as bool?,
      valueString: freezed == valueString
          ? _value.valueString
          : valueString // ignore: cast_nullable_to_non_nullable
              as String?,
      valueQuantity: freezed == valueQuantity
          ? _value.valueQuantity
          : valueQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      valueAttachment: freezed == valueAttachment
          ? _value.valueAttachment
          : valueAttachment // ignore: cast_nullable_to_non_nullable
              as Attachment?,
      valueReference: freezed == valueReference
          ? _value.valueReference
          : valueReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitSupportingInfoImpl
    implements _ExplanationOfBenefitSupportingInfo {
  _$ExplanationOfBenefitSupportingInfoImpl(
      {this.sequence,
      this.category,
      this.code,
      this.timingDate,
      this.timingPeriod,
      this.valueBoolean,
      this.valueString,
      this.valueQuantity,
      this.valueAttachment,
      this.valueReference});

  factory _$ExplanationOfBenefitSupportingInfoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitSupportingInfoImplFromJson(json);

  @override
  final int? sequence;
  @override
  final CodeableConcept? category;
  @override
  final CodeableConcept? code;
  @override
  final String? timingDate;
  @override
  final String? timingPeriod;
  @override
  final bool? valueBoolean;
  @override
  final String? valueString;
  @override
  final int? valueQuantity;
  @override
  final Attachment? valueAttachment;
  @override
  final Reference? valueReference;

  @override
  String toString() {
    return 'ExplanationOfBenefitSupportingInfo(sequence: $sequence, category: $category, code: $code, timingDate: $timingDate, timingPeriod: $timingPeriod, valueBoolean: $valueBoolean, valueString: $valueString, valueQuantity: $valueQuantity, valueAttachment: $valueAttachment, valueReference: $valueReference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitSupportingInfoImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.timingDate, timingDate) ||
                other.timingDate == timingDate) &&
            (identical(other.timingPeriod, timingPeriod) ||
                other.timingPeriod == timingPeriod) &&
            (identical(other.valueBoolean, valueBoolean) ||
                other.valueBoolean == valueBoolean) &&
            (identical(other.valueString, valueString) ||
                other.valueString == valueString) &&
            (identical(other.valueQuantity, valueQuantity) ||
                other.valueQuantity == valueQuantity) &&
            (identical(other.valueAttachment, valueAttachment) ||
                other.valueAttachment == valueAttachment) &&
            (identical(other.valueReference, valueReference) ||
                other.valueReference == valueReference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sequence,
      category,
      code,
      timingDate,
      timingPeriod,
      valueBoolean,
      valueString,
      valueQuantity,
      valueAttachment,
      valueReference);

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitSupportingInfoImplCopyWith<
          _$ExplanationOfBenefitSupportingInfoImpl>
      get copyWith => __$$ExplanationOfBenefitSupportingInfoImplCopyWithImpl<
          _$ExplanationOfBenefitSupportingInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitSupportingInfoImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitSupportingInfo
    implements ExplanationOfBenefitSupportingInfo {
  factory _ExplanationOfBenefitSupportingInfo(
          {final int? sequence,
          final CodeableConcept? category,
          final CodeableConcept? code,
          final String? timingDate,
          final String? timingPeriod,
          final bool? valueBoolean,
          final String? valueString,
          final int? valueQuantity,
          final Attachment? valueAttachment,
          final Reference? valueReference}) =
      _$ExplanationOfBenefitSupportingInfoImpl;

  factory _ExplanationOfBenefitSupportingInfo.fromJson(
          Map<String, dynamic> json) =
      _$ExplanationOfBenefitSupportingInfoImpl.fromJson;

  @override
  int? get sequence;
  @override
  CodeableConcept? get category;
  @override
  CodeableConcept? get code;
  @override
  String? get timingDate;
  @override
  String? get timingPeriod;
  @override
  bool? get valueBoolean;
  @override
  String? get valueString;
  @override
  int? get valueQuantity;
  @override
  Attachment? get valueAttachment;
  @override
  Reference? get valueReference;

  /// Create a copy of ExplanationOfBenefitSupportingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitSupportingInfoImplCopyWith<
          _$ExplanationOfBenefitSupportingInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitItem _$ExplanationOfBenefitItemFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitItem.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitItem {
  int? get sequence => throw _privateConstructorUsedError;
  List<int>? get careTeamSequence => throw _privateConstructorUsedError;
  List<int>? get diagnosisSequence => throw _privateConstructorUsedError;
  List<int>? get procedureSequence => throw _privateConstructorUsedError;
  List<int>? get informationSequence => throw _privateConstructorUsedError;
  CodeableConcept? get revenue => throw _privateConstructorUsedError;
  CodeableConcept? get category => throw _privateConstructorUsedError;
  CodeableConcept? get productOrService => throw _privateConstructorUsedError;
  List<CodeableConcept>? get modifier => throw _privateConstructorUsedError;
  List<CodeableConcept>? get programCode => throw _privateConstructorUsedError;
  String? get servicedDate => throw _privateConstructorUsedError;
  String? get servicedPeriod => throw _privateConstructorUsedError;
  CodeableConcept? get locationCodeableConcept =>
      throw _privateConstructorUsedError;
  Address? get locationAddress => throw _privateConstructorUsedError;
  Reference? get locationReference => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get unitPrice =>
      throw _privateConstructorUsedError;
  double? get factor => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get net => throw _privateConstructorUsedError;
  List<Reference>? get udi => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitAdjudication>? get adjudication =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitDetail>? get detail =>
      throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitItemCopyWith<ExplanationOfBenefitItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitItemCopyWith<$Res> {
  factory $ExplanationOfBenefitItemCopyWith(ExplanationOfBenefitItem value,
          $Res Function(ExplanationOfBenefitItem) then) =
      _$ExplanationOfBenefitItemCopyWithImpl<$Res, ExplanationOfBenefitItem>;
  @useResult
  $Res call(
      {int? sequence,
      List<int>? careTeamSequence,
      List<int>? diagnosisSequence,
      List<int>? procedureSequence,
      List<int>? informationSequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      String? servicedDate,
      String? servicedPeriod,
      CodeableConcept? locationCodeableConcept,
      Address? locationAddress,
      Reference? locationReference,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication,
      List<ExplanationOfBenefitDetail>? detail});

  $CodeableConceptCopyWith<$Res>? get revenue;
  $CodeableConceptCopyWith<$Res>? get category;
  $CodeableConceptCopyWith<$Res>? get productOrService;
  $CodeableConceptCopyWith<$Res>? get locationCodeableConcept;
  $AddressCopyWith<$Res>? get locationAddress;
  $ReferenceCopyWith<$Res>? get locationReference;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class _$ExplanationOfBenefitItemCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitItem>
    implements $ExplanationOfBenefitItemCopyWith<$Res> {
  _$ExplanationOfBenefitItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? careTeamSequence = freezed,
    Object? diagnosisSequence = freezed,
    Object? procedureSequence = freezed,
    Object? informationSequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? servicedDate = freezed,
    Object? servicedPeriod = freezed,
    Object? locationCodeableConcept = freezed,
    Object? locationAddress = freezed,
    Object? locationReference = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      careTeamSequence: freezed == careTeamSequence
          ? _value.careTeamSequence
          : careTeamSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      diagnosisSequence: freezed == diagnosisSequence
          ? _value.diagnosisSequence
          : diagnosisSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      procedureSequence: freezed == procedureSequence
          ? _value.procedureSequence
          : procedureSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      informationSequence: freezed == informationSequence
          ? _value.informationSequence
          : informationSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value.programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      servicedDate: freezed == servicedDate
          ? _value.servicedDate
          : servicedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      servicedPeriod: freezed == servicedPeriod
          ? _value.servicedPeriod
          : servicedPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      locationCodeableConcept: freezed == locationCodeableConcept
          ? _value.locationCodeableConcept
          : locationCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      locationReference: freezed == locationReference
          ? _value.locationReference
          : locationReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value.adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitDetail>?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get revenue {
    if (_value.revenue == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.revenue!, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get productOrService {
    if (_value.productOrService == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.productOrService!, (value) {
      return _then(_value.copyWith(productOrService: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get locationCodeableConcept {
    if (_value.locationCodeableConcept == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.locationCodeableConcept!,
        (value) {
      return _then(_value.copyWith(locationCodeableConcept: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get locationAddress {
    if (_value.locationAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.locationAddress!, (value) {
      return _then(_value.copyWith(locationAddress: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get locationReference {
    if (_value.locationReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.locationReference!, (value) {
      return _then(_value.copyWith(locationReference: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice {
    if (_value.unitPrice == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.unitPrice!, (value) {
      return _then(_value.copyWith(unitPrice: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net {
    if (_value.net == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.net!, (value) {
      return _then(_value.copyWith(net: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitItemImplCopyWith<$Res>
    implements $ExplanationOfBenefitItemCopyWith<$Res> {
  factory _$$ExplanationOfBenefitItemImplCopyWith(
          _$ExplanationOfBenefitItemImpl value,
          $Res Function(_$ExplanationOfBenefitItemImpl) then) =
      __$$ExplanationOfBenefitItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      List<int>? careTeamSequence,
      List<int>? diagnosisSequence,
      List<int>? procedureSequence,
      List<int>? informationSequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      String? servicedDate,
      String? servicedPeriod,
      CodeableConcept? locationCodeableConcept,
      Address? locationAddress,
      Reference? locationReference,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication,
      List<ExplanationOfBenefitDetail>? detail});

  @override
  $CodeableConceptCopyWith<$Res>? get revenue;
  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodeableConceptCopyWith<$Res>? get productOrService;
  @override
  $CodeableConceptCopyWith<$Res>? get locationCodeableConcept;
  @override
  $AddressCopyWith<$Res>? get locationAddress;
  @override
  $ReferenceCopyWith<$Res>? get locationReference;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class __$$ExplanationOfBenefitItemImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitItemCopyWithImpl<$Res,
        _$ExplanationOfBenefitItemImpl>
    implements _$$ExplanationOfBenefitItemImplCopyWith<$Res> {
  __$$ExplanationOfBenefitItemImplCopyWithImpl(
      _$ExplanationOfBenefitItemImpl _value,
      $Res Function(_$ExplanationOfBenefitItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? careTeamSequence = freezed,
    Object? diagnosisSequence = freezed,
    Object? procedureSequence = freezed,
    Object? informationSequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? servicedDate = freezed,
    Object? servicedPeriod = freezed,
    Object? locationCodeableConcept = freezed,
    Object? locationAddress = freezed,
    Object? locationReference = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
    Object? detail = freezed,
  }) {
    return _then(_$ExplanationOfBenefitItemImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      careTeamSequence: freezed == careTeamSequence
          ? _value._careTeamSequence
          : careTeamSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      diagnosisSequence: freezed == diagnosisSequence
          ? _value._diagnosisSequence
          : diagnosisSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      procedureSequence: freezed == procedureSequence
          ? _value._procedureSequence
          : procedureSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      informationSequence: freezed == informationSequence
          ? _value._informationSequence
          : informationSequence // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value._modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value._programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      servicedDate: freezed == servicedDate
          ? _value.servicedDate
          : servicedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      servicedPeriod: freezed == servicedPeriod
          ? _value.servicedPeriod
          : servicedPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      locationCodeableConcept: freezed == locationCodeableConcept
          ? _value.locationCodeableConcept
          : locationCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      locationAddress: freezed == locationAddress
          ? _value.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      locationReference: freezed == locationReference
          ? _value.locationReference
          : locationReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value._udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value._adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
      detail: freezed == detail
          ? _value._detail
          : detail // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitDetail>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitItemImpl implements _ExplanationOfBenefitItem {
  _$ExplanationOfBenefitItemImpl(
      {this.sequence,
      final List<int>? careTeamSequence,
      final List<int>? diagnosisSequence,
      final List<int>? procedureSequence,
      final List<int>? informationSequence,
      this.revenue,
      this.category,
      this.productOrService,
      final List<CodeableConcept>? modifier,
      final List<CodeableConcept>? programCode,
      this.servicedDate,
      this.servicedPeriod,
      this.locationCodeableConcept,
      this.locationAddress,
      this.locationReference,
      this.quantity,
      this.unitPrice,
      this.factor,
      this.net,
      final List<Reference>? udi,
      final List<ExplanationOfBenefitAdjudication>? adjudication,
      final List<ExplanationOfBenefitDetail>? detail})
      : _careTeamSequence = careTeamSequence,
        _diagnosisSequence = diagnosisSequence,
        _procedureSequence = procedureSequence,
        _informationSequence = informationSequence,
        _modifier = modifier,
        _programCode = programCode,
        _udi = udi,
        _adjudication = adjudication,
        _detail = detail;

  factory _$ExplanationOfBenefitItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitItemImplFromJson(json);

  @override
  final int? sequence;
  final List<int>? _careTeamSequence;
  @override
  List<int>? get careTeamSequence {
    final value = _careTeamSequence;
    if (value == null) return null;
    if (_careTeamSequence is EqualUnmodifiableListView)
      return _careTeamSequence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _diagnosisSequence;
  @override
  List<int>? get diagnosisSequence {
    final value = _diagnosisSequence;
    if (value == null) return null;
    if (_diagnosisSequence is EqualUnmodifiableListView)
      return _diagnosisSequence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _procedureSequence;
  @override
  List<int>? get procedureSequence {
    final value = _procedureSequence;
    if (value == null) return null;
    if (_procedureSequence is EqualUnmodifiableListView)
      return _procedureSequence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _informationSequence;
  @override
  List<int>? get informationSequence {
    final value = _informationSequence;
    if (value == null) return null;
    if (_informationSequence is EqualUnmodifiableListView)
      return _informationSequence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CodeableConcept? revenue;
  @override
  final CodeableConcept? category;
  @override
  final CodeableConcept? productOrService;
  final List<CodeableConcept>? _modifier;
  @override
  List<CodeableConcept>? get modifier {
    final value = _modifier;
    if (value == null) return null;
    if (_modifier is EqualUnmodifiableListView) return _modifier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _programCode;
  @override
  List<CodeableConcept>? get programCode {
    final value = _programCode;
    if (value == null) return null;
    if (_programCode is EqualUnmodifiableListView) return _programCode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? servicedDate;
  @override
  final String? servicedPeriod;
  @override
  final CodeableConcept? locationCodeableConcept;
  @override
  final Address? locationAddress;
  @override
  final Reference? locationReference;
  @override
  final int? quantity;
  @override
  final ExplanationOfBenefitMoney? unitPrice;
  @override
  final double? factor;
  @override
  final ExplanationOfBenefitMoney? net;
  final List<Reference>? _udi;
  @override
  List<Reference>? get udi {
    final value = _udi;
    if (value == null) return null;
    if (_udi is EqualUnmodifiableListView) return _udi;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitAdjudication>? _adjudication;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication {
    final value = _adjudication;
    if (value == null) return null;
    if (_adjudication is EqualUnmodifiableListView) return _adjudication;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitDetail>? _detail;
  @override
  List<ExplanationOfBenefitDetail>? get detail {
    final value = _detail;
    if (value == null) return null;
    if (_detail is EqualUnmodifiableListView) return _detail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExplanationOfBenefitItem(sequence: $sequence, careTeamSequence: $careTeamSequence, diagnosisSequence: $diagnosisSequence, procedureSequence: $procedureSequence, informationSequence: $informationSequence, revenue: $revenue, category: $category, productOrService: $productOrService, modifier: $modifier, programCode: $programCode, servicedDate: $servicedDate, servicedPeriod: $servicedPeriod, locationCodeableConcept: $locationCodeableConcept, locationAddress: $locationAddress, locationReference: $locationReference, quantity: $quantity, unitPrice: $unitPrice, factor: $factor, net: $net, udi: $udi, adjudication: $adjudication, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitItemImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            const DeepCollectionEquality()
                .equals(other._careTeamSequence, _careTeamSequence) &&
            const DeepCollectionEquality()
                .equals(other._diagnosisSequence, _diagnosisSequence) &&
            const DeepCollectionEquality()
                .equals(other._procedureSequence, _procedureSequence) &&
            const DeepCollectionEquality()
                .equals(other._informationSequence, _informationSequence) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.productOrService, productOrService) ||
                other.productOrService == productOrService) &&
            const DeepCollectionEquality().equals(other._modifier, _modifier) &&
            const DeepCollectionEquality()
                .equals(other._programCode, _programCode) &&
            (identical(other.servicedDate, servicedDate) ||
                other.servicedDate == servicedDate) &&
            (identical(other.servicedPeriod, servicedPeriod) ||
                other.servicedPeriod == servicedPeriod) &&
            (identical(
                    other.locationCodeableConcept, locationCodeableConcept) ||
                other.locationCodeableConcept == locationCodeableConcept) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.locationReference, locationReference) ||
                other.locationReference == locationReference) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.net, net) || other.net == net) &&
            const DeepCollectionEquality().equals(other._udi, _udi) &&
            const DeepCollectionEquality()
                .equals(other._adjudication, _adjudication) &&
            const DeepCollectionEquality().equals(other._detail, _detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        sequence,
        const DeepCollectionEquality().hash(_careTeamSequence),
        const DeepCollectionEquality().hash(_diagnosisSequence),
        const DeepCollectionEquality().hash(_procedureSequence),
        const DeepCollectionEquality().hash(_informationSequence),
        revenue,
        category,
        productOrService,
        const DeepCollectionEquality().hash(_modifier),
        const DeepCollectionEquality().hash(_programCode),
        servicedDate,
        servicedPeriod,
        locationCodeableConcept,
        locationAddress,
        locationReference,
        quantity,
        unitPrice,
        factor,
        net,
        const DeepCollectionEquality().hash(_udi),
        const DeepCollectionEquality().hash(_adjudication),
        const DeepCollectionEquality().hash(_detail)
      ]);

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitItemImplCopyWith<_$ExplanationOfBenefitItemImpl>
      get copyWith => __$$ExplanationOfBenefitItemImplCopyWithImpl<
          _$ExplanationOfBenefitItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitItemImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitItem implements ExplanationOfBenefitItem {
  factory _ExplanationOfBenefitItem(
          {final int? sequence,
          final List<int>? careTeamSequence,
          final List<int>? diagnosisSequence,
          final List<int>? procedureSequence,
          final List<int>? informationSequence,
          final CodeableConcept? revenue,
          final CodeableConcept? category,
          final CodeableConcept? productOrService,
          final List<CodeableConcept>? modifier,
          final List<CodeableConcept>? programCode,
          final String? servicedDate,
          final String? servicedPeriod,
          final CodeableConcept? locationCodeableConcept,
          final Address? locationAddress,
          final Reference? locationReference,
          final int? quantity,
          final ExplanationOfBenefitMoney? unitPrice,
          final double? factor,
          final ExplanationOfBenefitMoney? net,
          final List<Reference>? udi,
          final List<ExplanationOfBenefitAdjudication>? adjudication,
          final List<ExplanationOfBenefitDetail>? detail}) =
      _$ExplanationOfBenefitItemImpl;

  factory _ExplanationOfBenefitItem.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitItemImpl.fromJson;

  @override
  int? get sequence;
  @override
  List<int>? get careTeamSequence;
  @override
  List<int>? get diagnosisSequence;
  @override
  List<int>? get procedureSequence;
  @override
  List<int>? get informationSequence;
  @override
  CodeableConcept? get revenue;
  @override
  CodeableConcept? get category;
  @override
  CodeableConcept? get productOrService;
  @override
  List<CodeableConcept>? get modifier;
  @override
  List<CodeableConcept>? get programCode;
  @override
  String? get servicedDate;
  @override
  String? get servicedPeriod;
  @override
  CodeableConcept? get locationCodeableConcept;
  @override
  Address? get locationAddress;
  @override
  Reference? get locationReference;
  @override
  int? get quantity;
  @override
  ExplanationOfBenefitMoney? get unitPrice;
  @override
  double? get factor;
  @override
  ExplanationOfBenefitMoney? get net;
  @override
  List<Reference>? get udi;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication;
  @override
  List<ExplanationOfBenefitDetail>? get detail;

  /// Create a copy of ExplanationOfBenefitItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitItemImplCopyWith<_$ExplanationOfBenefitItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitAdjudication _$ExplanationOfBenefitAdjudicationFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitAdjudication.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitAdjudication {
  CodeableConcept? get category => throw _privateConstructorUsedError;
  CodeableConcept? get reason => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get amount => throw _privateConstructorUsedError;
  double? get value => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitAdjudication to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitAdjudicationCopyWith<ExplanationOfBenefitAdjudication>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitAdjudicationCopyWith<$Res> {
  factory $ExplanationOfBenefitAdjudicationCopyWith(
          ExplanationOfBenefitAdjudication value,
          $Res Function(ExplanationOfBenefitAdjudication) then) =
      _$ExplanationOfBenefitAdjudicationCopyWithImpl<$Res,
          ExplanationOfBenefitAdjudication>;
  @useResult
  $Res call(
      {CodeableConcept? category,
      CodeableConcept? reason,
      ExplanationOfBenefitMoney? amount,
      double? value});

  $CodeableConceptCopyWith<$Res>? get category;
  $CodeableConceptCopyWith<$Res>? get reason;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
}

/// @nodoc
class _$ExplanationOfBenefitAdjudicationCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitAdjudication>
    implements $ExplanationOfBenefitAdjudicationCopyWith<$Res> {
  _$ExplanationOfBenefitAdjudicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? reason = freezed,
    Object? amount = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get reason {
    if (_value.reason == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.reason!, (value) {
      return _then(_value.copyWith(reason: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount {
    if (_value.amount == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.amount!, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitAdjudicationImplCopyWith<$Res>
    implements $ExplanationOfBenefitAdjudicationCopyWith<$Res> {
  factory _$$ExplanationOfBenefitAdjudicationImplCopyWith(
          _$ExplanationOfBenefitAdjudicationImpl value,
          $Res Function(_$ExplanationOfBenefitAdjudicationImpl) then) =
      __$$ExplanationOfBenefitAdjudicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CodeableConcept? category,
      CodeableConcept? reason,
      ExplanationOfBenefitMoney? amount,
      double? value});

  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodeableConceptCopyWith<$Res>? get reason;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
}

/// @nodoc
class __$$ExplanationOfBenefitAdjudicationImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitAdjudicationCopyWithImpl<$Res,
        _$ExplanationOfBenefitAdjudicationImpl>
    implements _$$ExplanationOfBenefitAdjudicationImplCopyWith<$Res> {
  __$$ExplanationOfBenefitAdjudicationImplCopyWithImpl(
      _$ExplanationOfBenefitAdjudicationImpl _value,
      $Res Function(_$ExplanationOfBenefitAdjudicationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? reason = freezed,
    Object? amount = freezed,
    Object? value = freezed,
  }) {
    return _then(_$ExplanationOfBenefitAdjudicationImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitAdjudicationImpl
    implements _ExplanationOfBenefitAdjudication {
  _$ExplanationOfBenefitAdjudicationImpl(
      {this.category, this.reason, this.amount, this.value});

  factory _$ExplanationOfBenefitAdjudicationImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitAdjudicationImplFromJson(json);

  @override
  final CodeableConcept? category;
  @override
  final CodeableConcept? reason;
  @override
  final ExplanationOfBenefitMoney? amount;
  @override
  final double? value;

  @override
  String toString() {
    return 'ExplanationOfBenefitAdjudication(category: $category, reason: $reason, amount: $amount, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitAdjudicationImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, reason, amount, value);

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitAdjudicationImplCopyWith<
          _$ExplanationOfBenefitAdjudicationImpl>
      get copyWith => __$$ExplanationOfBenefitAdjudicationImplCopyWithImpl<
          _$ExplanationOfBenefitAdjudicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitAdjudicationImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitAdjudication
    implements ExplanationOfBenefitAdjudication {
  factory _ExplanationOfBenefitAdjudication(
      {final CodeableConcept? category,
      final CodeableConcept? reason,
      final ExplanationOfBenefitMoney? amount,
      final double? value}) = _$ExplanationOfBenefitAdjudicationImpl;

  factory _ExplanationOfBenefitAdjudication.fromJson(
          Map<String, dynamic> json) =
      _$ExplanationOfBenefitAdjudicationImpl.fromJson;

  @override
  CodeableConcept? get category;
  @override
  CodeableConcept? get reason;
  @override
  ExplanationOfBenefitMoney? get amount;
  @override
  double? get value;

  /// Create a copy of ExplanationOfBenefitAdjudication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitAdjudicationImplCopyWith<
          _$ExplanationOfBenefitAdjudicationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitDetail _$ExplanationOfBenefitDetailFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitDetail.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitDetail {
  int? get sequence => throw _privateConstructorUsedError;
  CodeableConcept? get revenue => throw _privateConstructorUsedError;
  CodeableConcept? get category => throw _privateConstructorUsedError;
  CodeableConcept? get productOrService => throw _privateConstructorUsedError;
  List<CodeableConcept>? get modifier => throw _privateConstructorUsedError;
  List<CodeableConcept>? get programCode => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get unitPrice =>
      throw _privateConstructorUsedError;
  double? get factor => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get net => throw _privateConstructorUsedError;
  List<Reference>? get udi => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitAdjudication>? get adjudication =>
      throw _privateConstructorUsedError;
  List<ExplanationOfBenefitSubDetail>? get subDetail =>
      throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitDetailCopyWith<ExplanationOfBenefitDetail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitDetailCopyWith<$Res> {
  factory $ExplanationOfBenefitDetailCopyWith(ExplanationOfBenefitDetail value,
          $Res Function(ExplanationOfBenefitDetail) then) =
      _$ExplanationOfBenefitDetailCopyWithImpl<$Res,
          ExplanationOfBenefitDetail>;
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication,
      List<ExplanationOfBenefitSubDetail>? subDetail});

  $CodeableConceptCopyWith<$Res>? get revenue;
  $CodeableConceptCopyWith<$Res>? get category;
  $CodeableConceptCopyWith<$Res>? get productOrService;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class _$ExplanationOfBenefitDetailCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitDetail>
    implements $ExplanationOfBenefitDetailCopyWith<$Res> {
  _$ExplanationOfBenefitDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
    Object? subDetail = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value.programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value.adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
      subDetail: freezed == subDetail
          ? _value.subDetail
          : subDetail // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitSubDetail>?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get revenue {
    if (_value.revenue == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.revenue!, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get productOrService {
    if (_value.productOrService == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.productOrService!, (value) {
      return _then(_value.copyWith(productOrService: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice {
    if (_value.unitPrice == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.unitPrice!, (value) {
      return _then(_value.copyWith(unitPrice: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net {
    if (_value.net == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.net!, (value) {
      return _then(_value.copyWith(net: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitDetailImplCopyWith<$Res>
    implements $ExplanationOfBenefitDetailCopyWith<$Res> {
  factory _$$ExplanationOfBenefitDetailImplCopyWith(
          _$ExplanationOfBenefitDetailImpl value,
          $Res Function(_$ExplanationOfBenefitDetailImpl) then) =
      __$$ExplanationOfBenefitDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication,
      List<ExplanationOfBenefitSubDetail>? subDetail});

  @override
  $CodeableConceptCopyWith<$Res>? get revenue;
  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodeableConceptCopyWith<$Res>? get productOrService;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class __$$ExplanationOfBenefitDetailImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitDetailCopyWithImpl<$Res,
        _$ExplanationOfBenefitDetailImpl>
    implements _$$ExplanationOfBenefitDetailImplCopyWith<$Res> {
  __$$ExplanationOfBenefitDetailImplCopyWithImpl(
      _$ExplanationOfBenefitDetailImpl _value,
      $Res Function(_$ExplanationOfBenefitDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
    Object? subDetail = freezed,
  }) {
    return _then(_$ExplanationOfBenefitDetailImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value._modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value._programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value._udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value._adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
      subDetail: freezed == subDetail
          ? _value._subDetail
          : subDetail // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitSubDetail>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitDetailImpl implements _ExplanationOfBenefitDetail {
  _$ExplanationOfBenefitDetailImpl(
      {this.sequence,
      this.revenue,
      this.category,
      this.productOrService,
      final List<CodeableConcept>? modifier,
      final List<CodeableConcept>? programCode,
      this.quantity,
      this.unitPrice,
      this.factor,
      this.net,
      final List<Reference>? udi,
      final List<ExplanationOfBenefitAdjudication>? adjudication,
      final List<ExplanationOfBenefitSubDetail>? subDetail})
      : _modifier = modifier,
        _programCode = programCode,
        _udi = udi,
        _adjudication = adjudication,
        _subDetail = subDetail;

  factory _$ExplanationOfBenefitDetailImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitDetailImplFromJson(json);

  @override
  final int? sequence;
  @override
  final CodeableConcept? revenue;
  @override
  final CodeableConcept? category;
  @override
  final CodeableConcept? productOrService;
  final List<CodeableConcept>? _modifier;
  @override
  List<CodeableConcept>? get modifier {
    final value = _modifier;
    if (value == null) return null;
    if (_modifier is EqualUnmodifiableListView) return _modifier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _programCode;
  @override
  List<CodeableConcept>? get programCode {
    final value = _programCode;
    if (value == null) return null;
    if (_programCode is EqualUnmodifiableListView) return _programCode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? quantity;
  @override
  final ExplanationOfBenefitMoney? unitPrice;
  @override
  final double? factor;
  @override
  final ExplanationOfBenefitMoney? net;
  final List<Reference>? _udi;
  @override
  List<Reference>? get udi {
    final value = _udi;
    if (value == null) return null;
    if (_udi is EqualUnmodifiableListView) return _udi;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitAdjudication>? _adjudication;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication {
    final value = _adjudication;
    if (value == null) return null;
    if (_adjudication is EqualUnmodifiableListView) return _adjudication;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitSubDetail>? _subDetail;
  @override
  List<ExplanationOfBenefitSubDetail>? get subDetail {
    final value = _subDetail;
    if (value == null) return null;
    if (_subDetail is EqualUnmodifiableListView) return _subDetail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExplanationOfBenefitDetail(sequence: $sequence, revenue: $revenue, category: $category, productOrService: $productOrService, modifier: $modifier, programCode: $programCode, quantity: $quantity, unitPrice: $unitPrice, factor: $factor, net: $net, udi: $udi, adjudication: $adjudication, subDetail: $subDetail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitDetailImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.productOrService, productOrService) ||
                other.productOrService == productOrService) &&
            const DeepCollectionEquality().equals(other._modifier, _modifier) &&
            const DeepCollectionEquality()
                .equals(other._programCode, _programCode) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.net, net) || other.net == net) &&
            const DeepCollectionEquality().equals(other._udi, _udi) &&
            const DeepCollectionEquality()
                .equals(other._adjudication, _adjudication) &&
            const DeepCollectionEquality()
                .equals(other._subDetail, _subDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sequence,
      revenue,
      category,
      productOrService,
      const DeepCollectionEquality().hash(_modifier),
      const DeepCollectionEquality().hash(_programCode),
      quantity,
      unitPrice,
      factor,
      net,
      const DeepCollectionEquality().hash(_udi),
      const DeepCollectionEquality().hash(_adjudication),
      const DeepCollectionEquality().hash(_subDetail));

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitDetailImplCopyWith<_$ExplanationOfBenefitDetailImpl>
      get copyWith => __$$ExplanationOfBenefitDetailImplCopyWithImpl<
          _$ExplanationOfBenefitDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitDetailImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitDetail
    implements ExplanationOfBenefitDetail {
  factory _ExplanationOfBenefitDetail(
          {final int? sequence,
          final CodeableConcept? revenue,
          final CodeableConcept? category,
          final CodeableConcept? productOrService,
          final List<CodeableConcept>? modifier,
          final List<CodeableConcept>? programCode,
          final int? quantity,
          final ExplanationOfBenefitMoney? unitPrice,
          final double? factor,
          final ExplanationOfBenefitMoney? net,
          final List<Reference>? udi,
          final List<ExplanationOfBenefitAdjudication>? adjudication,
          final List<ExplanationOfBenefitSubDetail>? subDetail}) =
      _$ExplanationOfBenefitDetailImpl;

  factory _ExplanationOfBenefitDetail.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitDetailImpl.fromJson;

  @override
  int? get sequence;
  @override
  CodeableConcept? get revenue;
  @override
  CodeableConcept? get category;
  @override
  CodeableConcept? get productOrService;
  @override
  List<CodeableConcept>? get modifier;
  @override
  List<CodeableConcept>? get programCode;
  @override
  int? get quantity;
  @override
  ExplanationOfBenefitMoney? get unitPrice;
  @override
  double? get factor;
  @override
  ExplanationOfBenefitMoney? get net;
  @override
  List<Reference>? get udi;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication;
  @override
  List<ExplanationOfBenefitSubDetail>? get subDetail;

  /// Create a copy of ExplanationOfBenefitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitDetailImplCopyWith<_$ExplanationOfBenefitDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitSubDetail _$ExplanationOfBenefitSubDetailFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitSubDetail.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitSubDetail {
  int? get sequence => throw _privateConstructorUsedError;
  CodeableConcept? get revenue => throw _privateConstructorUsedError;
  CodeableConcept? get category => throw _privateConstructorUsedError;
  CodeableConcept? get productOrService => throw _privateConstructorUsedError;
  List<CodeableConcept>? get modifier => throw _privateConstructorUsedError;
  List<CodeableConcept>? get programCode => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get unitPrice =>
      throw _privateConstructorUsedError;
  double? get factor => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get net => throw _privateConstructorUsedError;
  List<Reference>? get udi => throw _privateConstructorUsedError;
  List<ExplanationOfBenefitAdjudication>? get adjudication =>
      throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitSubDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitSubDetailCopyWith<ExplanationOfBenefitSubDetail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitSubDetailCopyWith<$Res> {
  factory $ExplanationOfBenefitSubDetailCopyWith(
          ExplanationOfBenefitSubDetail value,
          $Res Function(ExplanationOfBenefitSubDetail) then) =
      _$ExplanationOfBenefitSubDetailCopyWithImpl<$Res,
          ExplanationOfBenefitSubDetail>;
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication});

  $CodeableConceptCopyWith<$Res>? get revenue;
  $CodeableConceptCopyWith<$Res>? get category;
  $CodeableConceptCopyWith<$Res>? get productOrService;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class _$ExplanationOfBenefitSubDetailCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitSubDetail>
    implements $ExplanationOfBenefitSubDetailCopyWith<$Res> {
  _$ExplanationOfBenefitSubDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value.programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value.adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get revenue {
    if (_value.revenue == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.revenue!, (value) {
      return _then(_value.copyWith(revenue: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get productOrService {
    if (_value.productOrService == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.productOrService!, (value) {
      return _then(_value.copyWith(productOrService: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice {
    if (_value.unitPrice == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.unitPrice!, (value) {
      return _then(_value.copyWith(unitPrice: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net {
    if (_value.net == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.net!, (value) {
      return _then(_value.copyWith(net: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitSubDetailImplCopyWith<$Res>
    implements $ExplanationOfBenefitSubDetailCopyWith<$Res> {
  factory _$$ExplanationOfBenefitSubDetailImplCopyWith(
          _$ExplanationOfBenefitSubDetailImpl value,
          $Res Function(_$ExplanationOfBenefitSubDetailImpl) then) =
      __$$ExplanationOfBenefitSubDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      CodeableConcept? revenue,
      CodeableConcept? category,
      CodeableConcept? productOrService,
      List<CodeableConcept>? modifier,
      List<CodeableConcept>? programCode,
      int? quantity,
      ExplanationOfBenefitMoney? unitPrice,
      double? factor,
      ExplanationOfBenefitMoney? net,
      List<Reference>? udi,
      List<ExplanationOfBenefitAdjudication>? adjudication});

  @override
  $CodeableConceptCopyWith<$Res>? get revenue;
  @override
  $CodeableConceptCopyWith<$Res>? get category;
  @override
  $CodeableConceptCopyWith<$Res>? get productOrService;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get unitPrice;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get net;
}

/// @nodoc
class __$$ExplanationOfBenefitSubDetailImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitSubDetailCopyWithImpl<$Res,
        _$ExplanationOfBenefitSubDetailImpl>
    implements _$$ExplanationOfBenefitSubDetailImplCopyWith<$Res> {
  __$$ExplanationOfBenefitSubDetailImplCopyWithImpl(
      _$ExplanationOfBenefitSubDetailImpl _value,
      $Res Function(_$ExplanationOfBenefitSubDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? revenue = freezed,
    Object? category = freezed,
    Object? productOrService = freezed,
    Object? modifier = freezed,
    Object? programCode = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? factor = freezed,
    Object? net = freezed,
    Object? udi = freezed,
    Object? adjudication = freezed,
  }) {
    return _then(_$ExplanationOfBenefitSubDetailImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      productOrService: freezed == productOrService
          ? _value.productOrService
          : productOrService // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      modifier: freezed == modifier
          ? _value._modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      programCode: freezed == programCode
          ? _value._programCode
          : programCode // ignore: cast_nullable_to_non_nullable
              as List<CodeableConcept>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      factor: freezed == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double?,
      net: freezed == net
          ? _value.net
          : net // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      udi: freezed == udi
          ? _value._udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
      adjudication: freezed == adjudication
          ? _value._adjudication
          : adjudication // ignore: cast_nullable_to_non_nullable
              as List<ExplanationOfBenefitAdjudication>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitSubDetailImpl
    implements _ExplanationOfBenefitSubDetail {
  _$ExplanationOfBenefitSubDetailImpl(
      {this.sequence,
      this.revenue,
      this.category,
      this.productOrService,
      final List<CodeableConcept>? modifier,
      final List<CodeableConcept>? programCode,
      this.quantity,
      this.unitPrice,
      this.factor,
      this.net,
      final List<Reference>? udi,
      final List<ExplanationOfBenefitAdjudication>? adjudication})
      : _modifier = modifier,
        _programCode = programCode,
        _udi = udi,
        _adjudication = adjudication;

  factory _$ExplanationOfBenefitSubDetailImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitSubDetailImplFromJson(json);

  @override
  final int? sequence;
  @override
  final CodeableConcept? revenue;
  @override
  final CodeableConcept? category;
  @override
  final CodeableConcept? productOrService;
  final List<CodeableConcept>? _modifier;
  @override
  List<CodeableConcept>? get modifier {
    final value = _modifier;
    if (value == null) return null;
    if (_modifier is EqualUnmodifiableListView) return _modifier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CodeableConcept>? _programCode;
  @override
  List<CodeableConcept>? get programCode {
    final value = _programCode;
    if (value == null) return null;
    if (_programCode is EqualUnmodifiableListView) return _programCode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? quantity;
  @override
  final ExplanationOfBenefitMoney? unitPrice;
  @override
  final double? factor;
  @override
  final ExplanationOfBenefitMoney? net;
  final List<Reference>? _udi;
  @override
  List<Reference>? get udi {
    final value = _udi;
    if (value == null) return null;
    if (_udi is EqualUnmodifiableListView) return _udi;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExplanationOfBenefitAdjudication>? _adjudication;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication {
    final value = _adjudication;
    if (value == null) return null;
    if (_adjudication is EqualUnmodifiableListView) return _adjudication;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExplanationOfBenefitSubDetail(sequence: $sequence, revenue: $revenue, category: $category, productOrService: $productOrService, modifier: $modifier, programCode: $programCode, quantity: $quantity, unitPrice: $unitPrice, factor: $factor, net: $net, udi: $udi, adjudication: $adjudication)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitSubDetailImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.productOrService, productOrService) ||
                other.productOrService == productOrService) &&
            const DeepCollectionEquality().equals(other._modifier, _modifier) &&
            const DeepCollectionEquality()
                .equals(other._programCode, _programCode) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.net, net) || other.net == net) &&
            const DeepCollectionEquality().equals(other._udi, _udi) &&
            const DeepCollectionEquality()
                .equals(other._adjudication, _adjudication));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sequence,
      revenue,
      category,
      productOrService,
      const DeepCollectionEquality().hash(_modifier),
      const DeepCollectionEquality().hash(_programCode),
      quantity,
      unitPrice,
      factor,
      net,
      const DeepCollectionEquality().hash(_udi),
      const DeepCollectionEquality().hash(_adjudication));

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitSubDetailImplCopyWith<
          _$ExplanationOfBenefitSubDetailImpl>
      get copyWith => __$$ExplanationOfBenefitSubDetailImplCopyWithImpl<
          _$ExplanationOfBenefitSubDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitSubDetailImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitSubDetail
    implements ExplanationOfBenefitSubDetail {
  factory _ExplanationOfBenefitSubDetail(
          {final int? sequence,
          final CodeableConcept? revenue,
          final CodeableConcept? category,
          final CodeableConcept? productOrService,
          final List<CodeableConcept>? modifier,
          final List<CodeableConcept>? programCode,
          final int? quantity,
          final ExplanationOfBenefitMoney? unitPrice,
          final double? factor,
          final ExplanationOfBenefitMoney? net,
          final List<Reference>? udi,
          final List<ExplanationOfBenefitAdjudication>? adjudication}) =
      _$ExplanationOfBenefitSubDetailImpl;

  factory _ExplanationOfBenefitSubDetail.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitSubDetailImpl.fromJson;

  @override
  int? get sequence;
  @override
  CodeableConcept? get revenue;
  @override
  CodeableConcept? get category;
  @override
  CodeableConcept? get productOrService;
  @override
  List<CodeableConcept>? get modifier;
  @override
  List<CodeableConcept>? get programCode;
  @override
  int? get quantity;
  @override
  ExplanationOfBenefitMoney? get unitPrice;
  @override
  double? get factor;
  @override
  ExplanationOfBenefitMoney? get net;
  @override
  List<Reference>? get udi;
  @override
  List<ExplanationOfBenefitAdjudication>? get adjudication;

  /// Create a copy of ExplanationOfBenefitSubDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitSubDetailImplCopyWith<
          _$ExplanationOfBenefitSubDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitPayment _$ExplanationOfBenefitPaymentFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitPayment.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitPayment {
  CodeableConcept? get type => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get adjustment =>
      throw _privateConstructorUsedError;
  CodeableConcept? get adjustmentReason => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  ExplanationOfBenefitMoney? get amount => throw _privateConstructorUsedError;
  Identifier? get identifier => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitPaymentCopyWith<ExplanationOfBenefitPayment>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitPaymentCopyWith<$Res> {
  factory $ExplanationOfBenefitPaymentCopyWith(
          ExplanationOfBenefitPayment value,
          $Res Function(ExplanationOfBenefitPayment) then) =
      _$ExplanationOfBenefitPaymentCopyWithImpl<$Res,
          ExplanationOfBenefitPayment>;
  @useResult
  $Res call(
      {CodeableConcept? type,
      ExplanationOfBenefitMoney? adjustment,
      CodeableConcept? adjustmentReason,
      String? date,
      ExplanationOfBenefitMoney? amount,
      Identifier? identifier});

  $CodeableConceptCopyWith<$Res>? get type;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get adjustment;
  $CodeableConceptCopyWith<$Res>? get adjustmentReason;
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
  $IdentifierCopyWith<$Res>? get identifier;
}

/// @nodoc
class _$ExplanationOfBenefitPaymentCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitPayment>
    implements $ExplanationOfBenefitPaymentCopyWith<$Res> {
  _$ExplanationOfBenefitPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? adjustment = freezed,
    Object? adjustmentReason = freezed,
    Object? date = freezed,
    Object? amount = freezed,
    Object? identifier = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      adjustment: freezed == adjustment
          ? _value.adjustment
          : adjustment // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      adjustmentReason: freezed == adjustmentReason
          ? _value.adjustmentReason
          : adjustmentReason // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as Identifier?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.type!, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get adjustment {
    if (_value.adjustment == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.adjustment!,
        (value) {
      return _then(_value.copyWith(adjustment: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get adjustmentReason {
    if (_value.adjustmentReason == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.adjustmentReason!, (value) {
      return _then(_value.copyWith(adjustmentReason: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount {
    if (_value.amount == null) {
      return null;
    }

    return $ExplanationOfBenefitMoneyCopyWith<$Res>(_value.amount!, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IdentifierCopyWith<$Res>? get identifier {
    if (_value.identifier == null) {
      return null;
    }

    return $IdentifierCopyWith<$Res>(_value.identifier!, (value) {
      return _then(_value.copyWith(identifier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitPaymentImplCopyWith<$Res>
    implements $ExplanationOfBenefitPaymentCopyWith<$Res> {
  factory _$$ExplanationOfBenefitPaymentImplCopyWith(
          _$ExplanationOfBenefitPaymentImpl value,
          $Res Function(_$ExplanationOfBenefitPaymentImpl) then) =
      __$$ExplanationOfBenefitPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CodeableConcept? type,
      ExplanationOfBenefitMoney? adjustment,
      CodeableConcept? adjustmentReason,
      String? date,
      ExplanationOfBenefitMoney? amount,
      Identifier? identifier});

  @override
  $CodeableConceptCopyWith<$Res>? get type;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get adjustment;
  @override
  $CodeableConceptCopyWith<$Res>? get adjustmentReason;
  @override
  $ExplanationOfBenefitMoneyCopyWith<$Res>? get amount;
  @override
  $IdentifierCopyWith<$Res>? get identifier;
}

/// @nodoc
class __$$ExplanationOfBenefitPaymentImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitPaymentCopyWithImpl<$Res,
        _$ExplanationOfBenefitPaymentImpl>
    implements _$$ExplanationOfBenefitPaymentImplCopyWith<$Res> {
  __$$ExplanationOfBenefitPaymentImplCopyWithImpl(
      _$ExplanationOfBenefitPaymentImpl _value,
      $Res Function(_$ExplanationOfBenefitPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? adjustment = freezed,
    Object? adjustmentReason = freezed,
    Object? date = freezed,
    Object? amount = freezed,
    Object? identifier = freezed,
  }) {
    return _then(_$ExplanationOfBenefitPaymentImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      adjustment: freezed == adjustment
          ? _value.adjustment
          : adjustment // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      adjustmentReason: freezed == adjustmentReason
          ? _value.adjustmentReason
          : adjustmentReason // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as ExplanationOfBenefitMoney?,
      identifier: freezed == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as Identifier?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitPaymentImpl
    implements _ExplanationOfBenefitPayment {
  _$ExplanationOfBenefitPaymentImpl(
      {this.type,
      this.adjustment,
      this.adjustmentReason,
      this.date,
      this.amount,
      this.identifier});

  factory _$ExplanationOfBenefitPaymentImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitPaymentImplFromJson(json);

  @override
  final CodeableConcept? type;
  @override
  final ExplanationOfBenefitMoney? adjustment;
  @override
  final CodeableConcept? adjustmentReason;
  @override
  final String? date;
  @override
  final ExplanationOfBenefitMoney? amount;
  @override
  final Identifier? identifier;

  @override
  String toString() {
    return 'ExplanationOfBenefitPayment(type: $type, adjustment: $adjustment, adjustmentReason: $adjustmentReason, date: $date, amount: $amount, identifier: $identifier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitPaymentImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.adjustment, adjustment) ||
                other.adjustment == adjustment) &&
            (identical(other.adjustmentReason, adjustmentReason) ||
                other.adjustmentReason == adjustmentReason) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, adjustment,
      adjustmentReason, date, amount, identifier);

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitPaymentImplCopyWith<_$ExplanationOfBenefitPaymentImpl>
      get copyWith => __$$ExplanationOfBenefitPaymentImplCopyWithImpl<
          _$ExplanationOfBenefitPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitPaymentImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitPayment
    implements ExplanationOfBenefitPayment {
  factory _ExplanationOfBenefitPayment(
      {final CodeableConcept? type,
      final ExplanationOfBenefitMoney? adjustment,
      final CodeableConcept? adjustmentReason,
      final String? date,
      final ExplanationOfBenefitMoney? amount,
      final Identifier? identifier}) = _$ExplanationOfBenefitPaymentImpl;

  factory _ExplanationOfBenefitPayment.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitPaymentImpl.fromJson;

  @override
  CodeableConcept? get type;
  @override
  ExplanationOfBenefitMoney? get adjustment;
  @override
  CodeableConcept? get adjustmentReason;
  @override
  String? get date;
  @override
  ExplanationOfBenefitMoney? get amount;
  @override
  Identifier? get identifier;

  /// Create a copy of ExplanationOfBenefitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitPaymentImplCopyWith<_$ExplanationOfBenefitPaymentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitBillablePeriod _$ExplanationOfBenefitBillablePeriodFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitBillablePeriod.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitBillablePeriod {
  String? get start => throw _privateConstructorUsedError;
  String? get end => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitBillablePeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitBillablePeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitBillablePeriodCopyWith<
          ExplanationOfBenefitBillablePeriod>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitBillablePeriodCopyWith<$Res> {
  factory $ExplanationOfBenefitBillablePeriodCopyWith(
          ExplanationOfBenefitBillablePeriod value,
          $Res Function(ExplanationOfBenefitBillablePeriod) then) =
      _$ExplanationOfBenefitBillablePeriodCopyWithImpl<$Res,
          ExplanationOfBenefitBillablePeriod>;
  @useResult
  $Res call({String? start, String? end});
}

/// @nodoc
class _$ExplanationOfBenefitBillablePeriodCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitBillablePeriod>
    implements $ExplanationOfBenefitBillablePeriodCopyWith<$Res> {
  _$ExplanationOfBenefitBillablePeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitBillablePeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitBillablePeriodImplCopyWith<$Res>
    implements $ExplanationOfBenefitBillablePeriodCopyWith<$Res> {
  factory _$$ExplanationOfBenefitBillablePeriodImplCopyWith(
          _$ExplanationOfBenefitBillablePeriodImpl value,
          $Res Function(_$ExplanationOfBenefitBillablePeriodImpl) then) =
      __$$ExplanationOfBenefitBillablePeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? start, String? end});
}

/// @nodoc
class __$$ExplanationOfBenefitBillablePeriodImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitBillablePeriodCopyWithImpl<$Res,
        _$ExplanationOfBenefitBillablePeriodImpl>
    implements _$$ExplanationOfBenefitBillablePeriodImplCopyWith<$Res> {
  __$$ExplanationOfBenefitBillablePeriodImplCopyWithImpl(
      _$ExplanationOfBenefitBillablePeriodImpl _value,
      $Res Function(_$ExplanationOfBenefitBillablePeriodImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitBillablePeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(_$ExplanationOfBenefitBillablePeriodImpl(
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitBillablePeriodImpl
    implements _ExplanationOfBenefitBillablePeriod {
  _$ExplanationOfBenefitBillablePeriodImpl({this.start, this.end});

  factory _$ExplanationOfBenefitBillablePeriodImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitBillablePeriodImplFromJson(json);

  @override
  final String? start;
  @override
  final String? end;

  @override
  String toString() {
    return 'ExplanationOfBenefitBillablePeriod(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitBillablePeriodImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of ExplanationOfBenefitBillablePeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitBillablePeriodImplCopyWith<
          _$ExplanationOfBenefitBillablePeriodImpl>
      get copyWith => __$$ExplanationOfBenefitBillablePeriodImplCopyWithImpl<
          _$ExplanationOfBenefitBillablePeriodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitBillablePeriodImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitBillablePeriod
    implements ExplanationOfBenefitBillablePeriod {
  factory _ExplanationOfBenefitBillablePeriod(
      {final String? start,
      final String? end}) = _$ExplanationOfBenefitBillablePeriodImpl;

  factory _ExplanationOfBenefitBillablePeriod.fromJson(
          Map<String, dynamic> json) =
      _$ExplanationOfBenefitBillablePeriodImpl.fromJson;

  @override
  String? get start;
  @override
  String? get end;

  /// Create a copy of ExplanationOfBenefitBillablePeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitBillablePeriodImplCopyWith<
          _$ExplanationOfBenefitBillablePeriodImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitIdentifier _$ExplanationOfBenefitIdentifierFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitIdentifier.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitIdentifier {
  String? get system => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitIdentifier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitIdentifierCopyWith<ExplanationOfBenefitIdentifier>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitIdentifierCopyWith<$Res> {
  factory $ExplanationOfBenefitIdentifierCopyWith(
          ExplanationOfBenefitIdentifier value,
          $Res Function(ExplanationOfBenefitIdentifier) then) =
      _$ExplanationOfBenefitIdentifierCopyWithImpl<$Res,
          ExplanationOfBenefitIdentifier>;
  @useResult
  $Res call({String? system, String? value});
}

/// @nodoc
class _$ExplanationOfBenefitIdentifierCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitIdentifier>
    implements $ExplanationOfBenefitIdentifierCopyWith<$Res> {
  _$ExplanationOfBenefitIdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitIdentifierImplCopyWith<$Res>
    implements $ExplanationOfBenefitIdentifierCopyWith<$Res> {
  factory _$$ExplanationOfBenefitIdentifierImplCopyWith(
          _$ExplanationOfBenefitIdentifierImpl value,
          $Res Function(_$ExplanationOfBenefitIdentifierImpl) then) =
      __$$ExplanationOfBenefitIdentifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? system, String? value});
}

/// @nodoc
class __$$ExplanationOfBenefitIdentifierImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitIdentifierCopyWithImpl<$Res,
        _$ExplanationOfBenefitIdentifierImpl>
    implements _$$ExplanationOfBenefitIdentifierImplCopyWith<$Res> {
  __$$ExplanationOfBenefitIdentifierImplCopyWithImpl(
      _$ExplanationOfBenefitIdentifierImpl _value,
      $Res Function(_$ExplanationOfBenefitIdentifierImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? system = freezed,
    Object? value = freezed,
  }) {
    return _then(_$ExplanationOfBenefitIdentifierImpl(
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitIdentifierImpl
    implements _ExplanationOfBenefitIdentifier {
  _$ExplanationOfBenefitIdentifierImpl({this.system, this.value});

  factory _$ExplanationOfBenefitIdentifierImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitIdentifierImplFromJson(json);

  @override
  final String? system;
  @override
  final String? value;

  @override
  String toString() {
    return 'ExplanationOfBenefitIdentifier(system: $system, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitIdentifierImpl &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, system, value);

  /// Create a copy of ExplanationOfBenefitIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitIdentifierImplCopyWith<
          _$ExplanationOfBenefitIdentifierImpl>
      get copyWith => __$$ExplanationOfBenefitIdentifierImplCopyWithImpl<
          _$ExplanationOfBenefitIdentifierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitIdentifierImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitIdentifier
    implements ExplanationOfBenefitIdentifier {
  factory _ExplanationOfBenefitIdentifier(
      {final String? system,
      final String? value}) = _$ExplanationOfBenefitIdentifierImpl;

  factory _ExplanationOfBenefitIdentifier.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitIdentifierImpl.fromJson;

  @override
  String? get system;
  @override
  String? get value;

  /// Create a copy of ExplanationOfBenefitIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitIdentifierImplCopyWith<
          _$ExplanationOfBenefitIdentifierImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitCareTeam _$ExplanationOfBenefitCareTeamFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitCareTeam.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitCareTeam {
  int? get sequence => throw _privateConstructorUsedError;
  Reference? get provider => throw _privateConstructorUsedError;
  bool? get responsible => throw _privateConstructorUsedError;
  CodeableConcept? get role => throw _privateConstructorUsedError;
  CodeableConcept? get qualification => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitCareTeam to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitCareTeamCopyWith<ExplanationOfBenefitCareTeam>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitCareTeamCopyWith<$Res> {
  factory $ExplanationOfBenefitCareTeamCopyWith(
          ExplanationOfBenefitCareTeam value,
          $Res Function(ExplanationOfBenefitCareTeam) then) =
      _$ExplanationOfBenefitCareTeamCopyWithImpl<$Res,
          ExplanationOfBenefitCareTeam>;
  @useResult
  $Res call(
      {int? sequence,
      Reference? provider,
      bool? responsible,
      CodeableConcept? role,
      CodeableConcept? qualification});

  $ReferenceCopyWith<$Res>? get provider;
  $CodeableConceptCopyWith<$Res>? get role;
  $CodeableConceptCopyWith<$Res>? get qualification;
}

/// @nodoc
class _$ExplanationOfBenefitCareTeamCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitCareTeam>
    implements $ExplanationOfBenefitCareTeamCopyWith<$Res> {
  _$ExplanationOfBenefitCareTeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? provider = freezed,
    Object? responsible = freezed,
    Object? role = freezed,
    Object? qualification = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as Reference?,
      responsible: freezed == responsible
          ? _value.responsible
          : responsible // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      qualification: freezed == qualification
          ? _value.qualification
          : qualification // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get provider {
    if (_value.provider == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.provider!, (value) {
      return _then(_value.copyWith(provider: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get role {
    if (_value.role == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.role!, (value) {
      return _then(_value.copyWith(role: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get qualification {
    if (_value.qualification == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.qualification!, (value) {
      return _then(_value.copyWith(qualification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitCareTeamImplCopyWith<$Res>
    implements $ExplanationOfBenefitCareTeamCopyWith<$Res> {
  factory _$$ExplanationOfBenefitCareTeamImplCopyWith(
          _$ExplanationOfBenefitCareTeamImpl value,
          $Res Function(_$ExplanationOfBenefitCareTeamImpl) then) =
      __$$ExplanationOfBenefitCareTeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      Reference? provider,
      bool? responsible,
      CodeableConcept? role,
      CodeableConcept? qualification});

  @override
  $ReferenceCopyWith<$Res>? get provider;
  @override
  $CodeableConceptCopyWith<$Res>? get role;
  @override
  $CodeableConceptCopyWith<$Res>? get qualification;
}

/// @nodoc
class __$$ExplanationOfBenefitCareTeamImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitCareTeamCopyWithImpl<$Res,
        _$ExplanationOfBenefitCareTeamImpl>
    implements _$$ExplanationOfBenefitCareTeamImplCopyWith<$Res> {
  __$$ExplanationOfBenefitCareTeamImplCopyWithImpl(
      _$ExplanationOfBenefitCareTeamImpl _value,
      $Res Function(_$ExplanationOfBenefitCareTeamImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? provider = freezed,
    Object? responsible = freezed,
    Object? role = freezed,
    Object? qualification = freezed,
  }) {
    return _then(_$ExplanationOfBenefitCareTeamImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as Reference?,
      responsible: freezed == responsible
          ? _value.responsible
          : responsible // ignore: cast_nullable_to_non_nullable
              as bool?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      qualification: freezed == qualification
          ? _value.qualification
          : qualification // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitCareTeamImpl
    implements _ExplanationOfBenefitCareTeam {
  _$ExplanationOfBenefitCareTeamImpl(
      {this.sequence,
      this.provider,
      this.responsible,
      this.role,
      this.qualification});

  factory _$ExplanationOfBenefitCareTeamImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitCareTeamImplFromJson(json);

  @override
  final int? sequence;
  @override
  final Reference? provider;
  @override
  final bool? responsible;
  @override
  final CodeableConcept? role;
  @override
  final CodeableConcept? qualification;

  @override
  String toString() {
    return 'ExplanationOfBenefitCareTeam(sequence: $sequence, provider: $provider, responsible: $responsible, role: $role, qualification: $qualification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitCareTeamImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.responsible, responsible) ||
                other.responsible == responsible) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.qualification, qualification) ||
                other.qualification == qualification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sequence, provider, responsible, role, qualification);

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitCareTeamImplCopyWith<
          _$ExplanationOfBenefitCareTeamImpl>
      get copyWith => __$$ExplanationOfBenefitCareTeamImplCopyWithImpl<
          _$ExplanationOfBenefitCareTeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitCareTeamImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitCareTeam
    implements ExplanationOfBenefitCareTeam {
  factory _ExplanationOfBenefitCareTeam(
          {final int? sequence,
          final Reference? provider,
          final bool? responsible,
          final CodeableConcept? role,
          final CodeableConcept? qualification}) =
      _$ExplanationOfBenefitCareTeamImpl;

  factory _ExplanationOfBenefitCareTeam.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitCareTeamImpl.fromJson;

  @override
  int? get sequence;
  @override
  Reference? get provider;
  @override
  bool? get responsible;
  @override
  CodeableConcept? get role;
  @override
  CodeableConcept? get qualification;

  /// Create a copy of ExplanationOfBenefitCareTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitCareTeamImplCopyWith<
          _$ExplanationOfBenefitCareTeamImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitRelated _$ExplanationOfBenefitRelatedFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitRelated.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitRelated {
  Reference? get claim => throw _privateConstructorUsedError;
  CodeableConcept? get relationship => throw _privateConstructorUsedError;
  Identifier? get reference => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitRelated to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitRelatedCopyWith<ExplanationOfBenefitRelated>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitRelatedCopyWith<$Res> {
  factory $ExplanationOfBenefitRelatedCopyWith(
          ExplanationOfBenefitRelated value,
          $Res Function(ExplanationOfBenefitRelated) then) =
      _$ExplanationOfBenefitRelatedCopyWithImpl<$Res,
          ExplanationOfBenefitRelated>;
  @useResult
  $Res call(
      {Reference? claim, CodeableConcept? relationship, Identifier? reference});

  $ReferenceCopyWith<$Res>? get claim;
  $CodeableConceptCopyWith<$Res>? get relationship;
  $IdentifierCopyWith<$Res>? get reference;
}

/// @nodoc
class _$ExplanationOfBenefitRelatedCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitRelated>
    implements $ExplanationOfBenefitRelatedCopyWith<$Res> {
  _$ExplanationOfBenefitRelatedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claim = freezed,
    Object? relationship = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      claim: freezed == claim
          ? _value.claim
          : claim // ignore: cast_nullable_to_non_nullable
              as Reference?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Identifier?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get claim {
    if (_value.claim == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.claim!, (value) {
      return _then(_value.copyWith(claim: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get relationship {
    if (_value.relationship == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.relationship!, (value) {
      return _then(_value.copyWith(relationship: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IdentifierCopyWith<$Res>? get reference {
    if (_value.reference == null) {
      return null;
    }

    return $IdentifierCopyWith<$Res>(_value.reference!, (value) {
      return _then(_value.copyWith(reference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitRelatedImplCopyWith<$Res>
    implements $ExplanationOfBenefitRelatedCopyWith<$Res> {
  factory _$$ExplanationOfBenefitRelatedImplCopyWith(
          _$ExplanationOfBenefitRelatedImpl value,
          $Res Function(_$ExplanationOfBenefitRelatedImpl) then) =
      __$$ExplanationOfBenefitRelatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Reference? claim, CodeableConcept? relationship, Identifier? reference});

  @override
  $ReferenceCopyWith<$Res>? get claim;
  @override
  $CodeableConceptCopyWith<$Res>? get relationship;
  @override
  $IdentifierCopyWith<$Res>? get reference;
}

/// @nodoc
class __$$ExplanationOfBenefitRelatedImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitRelatedCopyWithImpl<$Res,
        _$ExplanationOfBenefitRelatedImpl>
    implements _$$ExplanationOfBenefitRelatedImplCopyWith<$Res> {
  __$$ExplanationOfBenefitRelatedImplCopyWithImpl(
      _$ExplanationOfBenefitRelatedImpl _value,
      $Res Function(_$ExplanationOfBenefitRelatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? claim = freezed,
    Object? relationship = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$ExplanationOfBenefitRelatedImpl(
      claim: freezed == claim
          ? _value.claim
          : claim // ignore: cast_nullable_to_non_nullable
              as Reference?,
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as Identifier?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitRelatedImpl
    implements _ExplanationOfBenefitRelated {
  _$ExplanationOfBenefitRelatedImpl(
      {this.claim, this.relationship, this.reference});

  factory _$ExplanationOfBenefitRelatedImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitRelatedImplFromJson(json);

  @override
  final Reference? claim;
  @override
  final CodeableConcept? relationship;
  @override
  final Identifier? reference;

  @override
  String toString() {
    return 'ExplanationOfBenefitRelated(claim: $claim, relationship: $relationship, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitRelatedImpl &&
            (identical(other.claim, claim) || other.claim == claim) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, claim, relationship, reference);

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitRelatedImplCopyWith<_$ExplanationOfBenefitRelatedImpl>
      get copyWith => __$$ExplanationOfBenefitRelatedImplCopyWithImpl<
          _$ExplanationOfBenefitRelatedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitRelatedImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitRelated
    implements ExplanationOfBenefitRelated {
  factory _ExplanationOfBenefitRelated(
      {final Reference? claim,
      final CodeableConcept? relationship,
      final Identifier? reference}) = _$ExplanationOfBenefitRelatedImpl;

  factory _ExplanationOfBenefitRelated.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitRelatedImpl.fromJson;

  @override
  Reference? get claim;
  @override
  CodeableConcept? get relationship;
  @override
  Identifier? get reference;

  /// Create a copy of ExplanationOfBenefitRelated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitRelatedImplCopyWith<_$ExplanationOfBenefitRelatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ExplanationOfBenefitProcedure _$ExplanationOfBenefitProcedureFromJson(
    Map<String, dynamic> json) {
  return _ExplanationOfBenefitProcedure.fromJson(json);
}

/// @nodoc
mixin _$ExplanationOfBenefitProcedure {
  int? get sequence => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  CodeableConcept? get procedureCodeableConcept =>
      throw _privateConstructorUsedError;
  Reference? get procedureReference => throw _privateConstructorUsedError;
  List<Reference>? get udi => throw _privateConstructorUsedError;

  /// Serializes this ExplanationOfBenefitProcedure to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExplanationOfBenefitProcedureCopyWith<ExplanationOfBenefitProcedure>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplanationOfBenefitProcedureCopyWith<$Res> {
  factory $ExplanationOfBenefitProcedureCopyWith(
          ExplanationOfBenefitProcedure value,
          $Res Function(ExplanationOfBenefitProcedure) then) =
      _$ExplanationOfBenefitProcedureCopyWithImpl<$Res,
          ExplanationOfBenefitProcedure>;
  @useResult
  $Res call(
      {int? sequence,
      String? date,
      CodeableConcept? procedureCodeableConcept,
      Reference? procedureReference,
      List<Reference>? udi});

  $CodeableConceptCopyWith<$Res>? get procedureCodeableConcept;
  $ReferenceCopyWith<$Res>? get procedureReference;
}

/// @nodoc
class _$ExplanationOfBenefitProcedureCopyWithImpl<$Res,
        $Val extends ExplanationOfBenefitProcedure>
    implements $ExplanationOfBenefitProcedureCopyWith<$Res> {
  _$ExplanationOfBenefitProcedureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? date = freezed,
    Object? procedureCodeableConcept = freezed,
    Object? procedureReference = freezed,
    Object? udi = freezed,
  }) {
    return _then(_value.copyWith(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      procedureCodeableConcept: freezed == procedureCodeableConcept
          ? _value.procedureCodeableConcept
          : procedureCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      procedureReference: freezed == procedureReference
          ? _value.procedureReference
          : procedureReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      udi: freezed == udi
          ? _value.udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
    ) as $Val);
  }

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get procedureCodeableConcept {
    if (_value.procedureCodeableConcept == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.procedureCodeableConcept!,
        (value) {
      return _then(_value.copyWith(procedureCodeableConcept: value) as $Val);
    });
  }

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get procedureReference {
    if (_value.procedureReference == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.procedureReference!, (value) {
      return _then(_value.copyWith(procedureReference: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExplanationOfBenefitProcedureImplCopyWith<$Res>
    implements $ExplanationOfBenefitProcedureCopyWith<$Res> {
  factory _$$ExplanationOfBenefitProcedureImplCopyWith(
          _$ExplanationOfBenefitProcedureImpl value,
          $Res Function(_$ExplanationOfBenefitProcedureImpl) then) =
      __$$ExplanationOfBenefitProcedureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? sequence,
      String? date,
      CodeableConcept? procedureCodeableConcept,
      Reference? procedureReference,
      List<Reference>? udi});

  @override
  $CodeableConceptCopyWith<$Res>? get procedureCodeableConcept;
  @override
  $ReferenceCopyWith<$Res>? get procedureReference;
}

/// @nodoc
class __$$ExplanationOfBenefitProcedureImplCopyWithImpl<$Res>
    extends _$ExplanationOfBenefitProcedureCopyWithImpl<$Res,
        _$ExplanationOfBenefitProcedureImpl>
    implements _$$ExplanationOfBenefitProcedureImplCopyWith<$Res> {
  __$$ExplanationOfBenefitProcedureImplCopyWithImpl(
      _$ExplanationOfBenefitProcedureImpl _value,
      $Res Function(_$ExplanationOfBenefitProcedureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = freezed,
    Object? date = freezed,
    Object? procedureCodeableConcept = freezed,
    Object? procedureReference = freezed,
    Object? udi = freezed,
  }) {
    return _then(_$ExplanationOfBenefitProcedureImpl(
      sequence: freezed == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      procedureCodeableConcept: freezed == procedureCodeableConcept
          ? _value.procedureCodeableConcept
          : procedureCodeableConcept // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      procedureReference: freezed == procedureReference
          ? _value.procedureReference
          : procedureReference // ignore: cast_nullable_to_non_nullable
              as Reference?,
      udi: freezed == udi
          ? _value._udi
          : udi // ignore: cast_nullable_to_non_nullable
              as List<Reference>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExplanationOfBenefitProcedureImpl
    implements _ExplanationOfBenefitProcedure {
  _$ExplanationOfBenefitProcedureImpl(
      {this.sequence,
      this.date,
      this.procedureCodeableConcept,
      this.procedureReference,
      final List<Reference>? udi})
      : _udi = udi;

  factory _$ExplanationOfBenefitProcedureImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ExplanationOfBenefitProcedureImplFromJson(json);

  @override
  final int? sequence;
  @override
  final String? date;
  @override
  final CodeableConcept? procedureCodeableConcept;
  @override
  final Reference? procedureReference;
  final List<Reference>? _udi;
  @override
  List<Reference>? get udi {
    final value = _udi;
    if (value == null) return null;
    if (_udi is EqualUnmodifiableListView) return _udi;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExplanationOfBenefitProcedure(sequence: $sequence, date: $date, procedureCodeableConcept: $procedureCodeableConcept, procedureReference: $procedureReference, udi: $udi)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExplanationOfBenefitProcedureImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(
                    other.procedureCodeableConcept, procedureCodeableConcept) ||
                other.procedureCodeableConcept == procedureCodeableConcept) &&
            (identical(other.procedureReference, procedureReference) ||
                other.procedureReference == procedureReference) &&
            const DeepCollectionEquality().equals(other._udi, _udi));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sequence,
      date,
      procedureCodeableConcept,
      procedureReference,
      const DeepCollectionEquality().hash(_udi));

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExplanationOfBenefitProcedureImplCopyWith<
          _$ExplanationOfBenefitProcedureImpl>
      get copyWith => __$$ExplanationOfBenefitProcedureImplCopyWithImpl<
          _$ExplanationOfBenefitProcedureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExplanationOfBenefitProcedureImplToJson(
      this,
    );
  }
}

abstract class _ExplanationOfBenefitProcedure
    implements ExplanationOfBenefitProcedure {
  factory _ExplanationOfBenefitProcedure(
      {final int? sequence,
      final String? date,
      final CodeableConcept? procedureCodeableConcept,
      final Reference? procedureReference,
      final List<Reference>? udi}) = _$ExplanationOfBenefitProcedureImpl;

  factory _ExplanationOfBenefitProcedure.fromJson(Map<String, dynamic> json) =
      _$ExplanationOfBenefitProcedureImpl.fromJson;

  @override
  int? get sequence;
  @override
  String? get date;
  @override
  CodeableConcept? get procedureCodeableConcept;
  @override
  Reference? get procedureReference;
  @override
  List<Reference>? get udi;

  /// Create a copy of ExplanationOfBenefitProcedure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExplanationOfBenefitProcedureImplCopyWith<
          _$ExplanationOfBenefitProcedureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  String? get contentType => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  String? get hash => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get creation => throw _privateConstructorUsedError;

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call(
      {String? contentType,
      String? language,
      String? data,
      String? url,
      int? size,
      String? hash,
      String? title,
      String? creation});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentType = freezed,
    Object? language = freezed,
    Object? data = freezed,
    Object? url = freezed,
    Object? size = freezed,
    Object? hash = freezed,
    Object? title = freezed,
    Object? creation = freezed,
  }) {
    return _then(_value.copyWith(
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
          _$AttachmentImpl value, $Res Function(_$AttachmentImpl) then) =
      __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? contentType,
      String? language,
      String? data,
      String? url,
      int? size,
      String? hash,
      String? title,
      String? creation});
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
      _$AttachmentImpl _value, $Res Function(_$AttachmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentType = freezed,
    Object? language = freezed,
    Object? data = freezed,
    Object? url = freezed,
    Object? size = freezed,
    Object? hash = freezed,
    Object? title = freezed,
    Object? creation = freezed,
  }) {
    return _then(_$AttachmentImpl(
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentImpl implements _Attachment {
  _$AttachmentImpl(
      {this.contentType,
      this.language,
      this.data,
      this.url,
      this.size,
      this.hash,
      this.title,
      this.creation});

  factory _$AttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentImplFromJson(json);

  @override
  final String? contentType;
  @override
  final String? language;
  @override
  final String? data;
  @override
  final String? url;
  @override
  final int? size;
  @override
  final String? hash;
  @override
  final String? title;
  @override
  final String? creation;

  @override
  String toString() {
    return 'Attachment(contentType: $contentType, language: $language, data: $data, url: $url, size: $size, hash: $hash, title: $title, creation: $creation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.creation, creation) ||
                other.creation == creation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentType, language, data, url,
      size, hash, title, creation);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentImplToJson(
      this,
    );
  }
}

abstract class _Attachment implements Attachment {
  factory _Attachment(
      {final String? contentType,
      final String? language,
      final String? data,
      final String? url,
      final int? size,
      final String? hash,
      final String? title,
      final String? creation}) = _$AttachmentImpl;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$AttachmentImpl.fromJson;

  @override
  String? get contentType;
  @override
  String? get language;
  @override
  String? get data;
  @override
  String? get url;
  @override
  int? get size;
  @override
  String? get hash;
  @override
  String? get title;
  @override
  String? get creation;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get use => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  List<String>? get line => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get period => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String? use,
      String? type,
      String? text,
      List<String>? line,
      String? city,
      String? district,
      String? state,
      String? postalCode,
      String? country,
      String? period});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? use = freezed,
    Object? type = freezed,
    Object? text = freezed,
    Object? line = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? state = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? period = freezed,
  }) {
    return _then(_value.copyWith(
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? use,
      String? type,
      String? text,
      List<String>? line,
      String? city,
      String? district,
      String? state,
      String? postalCode,
      String? country,
      String? period});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? use = freezed,
    Object? type = freezed,
    Object? text = freezed,
    Object? line = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? state = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? period = freezed,
  }) {
    return _then(_$AddressImpl(
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value._line
          : line // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  _$AddressImpl(
      {this.use,
      this.type,
      this.text,
      final List<String>? line,
      this.city,
      this.district,
      this.state,
      this.postalCode,
      this.country,
      this.period})
      : _line = line;

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String? use;
  @override
  final String? type;
  @override
  final String? text;
  final List<String>? _line;
  @override
  List<String>? get line {
    final value = _line;
    if (value == null) return null;
    if (_line is EqualUnmodifiableListView) return _line;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? state;
  @override
  final String? postalCode;
  @override
  final String? country;
  @override
  final String? period;

  @override
  String toString() {
    return 'Address(use: $use, type: $type, text: $text, line: $line, city: $city, district: $district, state: $state, postalCode: $postalCode, country: $country, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.use, use) || other.use == use) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._line, _line) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      use,
      type,
      text,
      const DeepCollectionEquality().hash(_line),
      city,
      district,
      state,
      postalCode,
      country,
      period);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  factory _Address(
      {final String? use,
      final String? type,
      final String? text,
      final List<String>? line,
      final String? city,
      final String? district,
      final String? state,
      final String? postalCode,
      final String? country,
      final String? period}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String? get use;
  @override
  String? get type;
  @override
  String? get text;
  @override
  List<String>? get line;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get state;
  @override
  String? get postalCode;
  @override
  String? get country;
  @override
  String? get period;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Identifier _$IdentifierFromJson(Map<String, dynamic> json) {
  return _Identifier.fromJson(json);
}

/// @nodoc
mixin _$Identifier {
  String? get use => throw _privateConstructorUsedError;
  CodeableConcept? get type => throw _privateConstructorUsedError;
  String? get system => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  String? get period => throw _privateConstructorUsedError;
  Reference? get assigner => throw _privateConstructorUsedError;

  /// Serializes this Identifier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IdentifierCopyWith<Identifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdentifierCopyWith<$Res> {
  factory $IdentifierCopyWith(
          Identifier value, $Res Function(Identifier) then) =
      _$IdentifierCopyWithImpl<$Res, Identifier>;
  @useResult
  $Res call(
      {String? use,
      CodeableConcept? type,
      String? system,
      String? value,
      String? period,
      Reference? assigner});

  $CodeableConceptCopyWith<$Res>? get type;
  $ReferenceCopyWith<$Res>? get assigner;
}

/// @nodoc
class _$IdentifierCopyWithImpl<$Res, $Val extends Identifier>
    implements $IdentifierCopyWith<$Res> {
  _$IdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? use = freezed,
    Object? type = freezed,
    Object? system = freezed,
    Object? value = freezed,
    Object? period = freezed,
    Object? assigner = freezed,
  }) {
    return _then(_value.copyWith(
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String?,
      assigner: freezed == assigner
          ? _value.assigner
          : assigner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ) as $Val);
  }

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CodeableConceptCopyWith<$Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CodeableConceptCopyWith<$Res>(_value.type!, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReferenceCopyWith<$Res>? get assigner {
    if (_value.assigner == null) {
      return null;
    }

    return $ReferenceCopyWith<$Res>(_value.assigner!, (value) {
      return _then(_value.copyWith(assigner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IdentifierImplCopyWith<$Res>
    implements $IdentifierCopyWith<$Res> {
  factory _$$IdentifierImplCopyWith(
          _$IdentifierImpl value, $Res Function(_$IdentifierImpl) then) =
      __$$IdentifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? use,
      CodeableConcept? type,
      String? system,
      String? value,
      String? period,
      Reference? assigner});

  @override
  $CodeableConceptCopyWith<$Res>? get type;
  @override
  $ReferenceCopyWith<$Res>? get assigner;
}

/// @nodoc
class __$$IdentifierImplCopyWithImpl<$Res>
    extends _$IdentifierCopyWithImpl<$Res, _$IdentifierImpl>
    implements _$$IdentifierImplCopyWith<$Res> {
  __$$IdentifierImplCopyWithImpl(
      _$IdentifierImpl _value, $Res Function(_$IdentifierImpl) _then)
      : super(_value, _then);

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? use = freezed,
    Object? type = freezed,
    Object? system = freezed,
    Object? value = freezed,
    Object? period = freezed,
    Object? assigner = freezed,
  }) {
    return _then(_$IdentifierImpl(
      use: freezed == use
          ? _value.use
          : use // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CodeableConcept?,
      system: freezed == system
          ? _value.system
          : system // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      period: freezed == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String?,
      assigner: freezed == assigner
          ? _value.assigner
          : assigner // ignore: cast_nullable_to_non_nullable
              as Reference?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IdentifierImpl implements _Identifier {
  _$IdentifierImpl(
      {this.use,
      this.type,
      this.system,
      this.value,
      this.period,
      this.assigner});

  factory _$IdentifierImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdentifierImplFromJson(json);

  @override
  final String? use;
  @override
  final CodeableConcept? type;
  @override
  final String? system;
  @override
  final String? value;
  @override
  final String? period;
  @override
  final Reference? assigner;

  @override
  String toString() {
    return 'Identifier(use: $use, type: $type, system: $system, value: $value, period: $period, assigner: $assigner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdentifierImpl &&
            (identical(other.use, use) || other.use == use) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.assigner, assigner) ||
                other.assigner == assigner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, use, type, system, value, period, assigner);

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IdentifierImplCopyWith<_$IdentifierImpl> get copyWith =>
      __$$IdentifierImplCopyWithImpl<_$IdentifierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IdentifierImplToJson(
      this,
    );
  }
}

abstract class _Identifier implements Identifier {
  factory _Identifier(
      {final String? use,
      final CodeableConcept? type,
      final String? system,
      final String? value,
      final String? period,
      final Reference? assigner}) = _$IdentifierImpl;

  factory _Identifier.fromJson(Map<String, dynamic> json) =
      _$IdentifierImpl.fromJson;

  @override
  String? get use;
  @override
  CodeableConcept? get type;
  @override
  String? get system;
  @override
  String? get value;
  @override
  String? get period;
  @override
  Reference? get assigner;

  /// Create a copy of Identifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IdentifierImplCopyWith<_$IdentifierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
