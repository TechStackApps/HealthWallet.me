import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'explanation_of_benefit.freezed.dart';
part 'explanation_of_benefit.g.dart';

@freezed
class ExplanationOfBenefit with _$ExplanationOfBenefit {
  factory ExplanationOfBenefit({
    String? id,
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
    List<ExplanationOfBenefitProcedure>? procedures,
  }) = _ExplanationOfBenefit;

  factory ExplanationOfBenefit.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitFromJson(json);
}

@freezed
class ExplanationOfBenefitInsurance with _$ExplanationOfBenefitInsurance {
  factory ExplanationOfBenefitInsurance({
    bool? focal,
    Reference? coverage,
  }) = _ExplanationOfBenefitInsurance;

  factory ExplanationOfBenefitInsurance.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitInsuranceFromJson(json);
}

@freezed
class ExplanationOfBenefitTotal with _$ExplanationOfBenefitTotal {
  factory ExplanationOfBenefitTotal({
    CodeableConcept? category,
    ExplanationOfBenefitMoney? amount,
  }) = _ExplanationOfBenefitTotal;

  factory ExplanationOfBenefitTotal.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitTotalFromJson(json);
}

@freezed
class ExplanationOfBenefitMoney with _$ExplanationOfBenefitMoney {
  factory ExplanationOfBenefitMoney({
    double? value,
    String? currency,
  }) = _ExplanationOfBenefitMoney;

  factory ExplanationOfBenefitMoney.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitMoneyFromJson(json);
}

@freezed
class ExplanationOfBenefitDiagnosis with _$ExplanationOfBenefitDiagnosis {
  factory ExplanationOfBenefitDiagnosis({
    int? sequence,
    CodeableConcept? diagnosisCodeableConcept,
  }) = _ExplanationOfBenefitDiagnosis;

  factory ExplanationOfBenefitDiagnosis.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitDiagnosisFromJson(json);
}

@freezed
class ExplanationOfBenefitSupportingInfo
    with _$ExplanationOfBenefitSupportingInfo {
  factory ExplanationOfBenefitSupportingInfo({
    int? sequence,
    CodeableConcept? category,
    CodeableConcept? code,
    String? timingDate,
    String? timingPeriod,
    bool? valueBoolean,
    String? valueString,
    int? valueQuantity,
    Attachment? valueAttachment,
    Reference? valueReference,
  }) = _ExplanationOfBenefitSupportingInfo;

  factory ExplanationOfBenefitSupportingInfo.fromJson(
          Map<String, dynamic> json) =>
      _$ExplanationOfBenefitSupportingInfoFromJson(json);
}

@freezed
class ExplanationOfBenefitItem with _$ExplanationOfBenefitItem {
  factory ExplanationOfBenefitItem({
    int? sequence,
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
    List<ExplanationOfBenefitDetail>? detail,
  }) = _ExplanationOfBenefitItem;

  factory ExplanationOfBenefitItem.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitItemFromJson(json);
}

@freezed
class ExplanationOfBenefitAdjudication with _$ExplanationOfBenefitAdjudication {
  factory ExplanationOfBenefitAdjudication({
    CodeableConcept? category,
    CodeableConcept? reason,
    ExplanationOfBenefitMoney? amount,
    double? value,
  }) = _ExplanationOfBenefitAdjudication;

  factory ExplanationOfBenefitAdjudication.fromJson(
          Map<String, dynamic> json) =>
      _$ExplanationOfBenefitAdjudicationFromJson(json);
}

@freezed
class ExplanationOfBenefitDetail with _$ExplanationOfBenefitDetail {
  factory ExplanationOfBenefitDetail({
    int? sequence,
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
    List<ExplanationOfBenefitSubDetail>? subDetail,
  }) = _ExplanationOfBenefitDetail;

  factory ExplanationOfBenefitDetail.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitDetailFromJson(json);
}

@freezed
class ExplanationOfBenefitSubDetail with _$ExplanationOfBenefitSubDetail {
  factory ExplanationOfBenefitSubDetail({
    int? sequence,
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
  }) = _ExplanationOfBenefitSubDetail;

  factory ExplanationOfBenefitSubDetail.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitSubDetailFromJson(json);
}

@freezed
class ExplanationOfBenefitPayment with _$ExplanationOfBenefitPayment {
  factory ExplanationOfBenefitPayment({
    CodeableConcept? type,
    ExplanationOfBenefitMoney? adjustment,
    CodeableConcept? adjustmentReason,
    String? date,
    ExplanationOfBenefitMoney? amount,
    Identifier? identifier,
  }) = _ExplanationOfBenefitPayment;

  factory ExplanationOfBenefitPayment.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitPaymentFromJson(json);
}

@freezed
class ExplanationOfBenefitBillablePeriod
    with _$ExplanationOfBenefitBillablePeriod {
  factory ExplanationOfBenefitBillablePeriod({
    String? start,
    String? end,
  }) = _ExplanationOfBenefitBillablePeriod;

  factory ExplanationOfBenefitBillablePeriod.fromJson(
          Map<String, dynamic> json) =>
      _$ExplanationOfBenefitBillablePeriodFromJson(json);
}

@freezed
class ExplanationOfBenefitIdentifier with _$ExplanationOfBenefitIdentifier {
  factory ExplanationOfBenefitIdentifier({
    String? system,
    String? value,
  }) = _ExplanationOfBenefitIdentifier;

  factory ExplanationOfBenefitIdentifier.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitIdentifierFromJson(json);
}

@freezed
class ExplanationOfBenefitCareTeam with _$ExplanationOfBenefitCareTeam {
  factory ExplanationOfBenefitCareTeam({
    int? sequence,
    Reference? provider,
    bool? responsible,
    CodeableConcept? role,
    CodeableConcept? qualification,
  }) = _ExplanationOfBenefitCareTeam;

  factory ExplanationOfBenefitCareTeam.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitCareTeamFromJson(json);
}

@freezed
class ExplanationOfBenefitRelated with _$ExplanationOfBenefitRelated {
  factory ExplanationOfBenefitRelated({
    Reference? claim,
    CodeableConcept? relationship,
    Identifier? reference,
  }) = _ExplanationOfBenefitRelated;

  factory ExplanationOfBenefitRelated.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitRelatedFromJson(json);
}

@freezed
class ExplanationOfBenefitProcedure with _$ExplanationOfBenefitProcedure {
  factory ExplanationOfBenefitProcedure({
    int? sequence,
    String? date,
    CodeableConcept? procedureCodeableConcept,
    Reference? procedureReference,
    List<Reference>? udi,
  }) = _ExplanationOfBenefitProcedure;

  factory ExplanationOfBenefitProcedure.fromJson(Map<String, dynamic> json) =>
      _$ExplanationOfBenefitProcedureFromJson(json);
}

@freezed
class Attachment with _$Attachment {
  factory Attachment({
    String? contentType,
    String? language,
    String? data,
    String? url,
    int? size,
    String? hash,
    String? title,
    String? creation,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}

@freezed
class Address with _$Address {
  factory Address({
    String? use,
    String? type,
    String? text,
    List<String>? line,
    String? city,
    String? district,
    String? state,
    String? postalCode,
    String? country,
    String? period,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class Identifier with _$Identifier {
  factory Identifier({
    String? use,
    CodeableConcept? type,
    String? system,
    String? value,
    String? period,
    Reference? assigner,
  }) = _Identifier;

  factory Identifier.fromJson(Map<String, dynamic> json) =>
      _$IdentifierFromJson(json);
}
