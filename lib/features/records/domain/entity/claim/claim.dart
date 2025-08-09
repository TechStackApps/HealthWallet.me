import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_date_extractor.dart';

part 'claim.freezed.dart';

@freezed
class Claim with _$Claim implements IFhirResource {
  const Claim._();

  const factory Claim({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    FinancialResourceStatusCodes? status,
    CodeableConcept? type,
    CodeableConcept? subType,
    Use? use,
    Reference? patient,
    Period? billablePeriod,
    FhirDateTime? created,
    Reference? enterer,
    Reference? insurer,
    Reference? provider,
    CodeableConcept? priority,
    CodeableConcept? fundsReserve,
    List<ClaimRelated>? related,
    ClaimPayee? payee,
    Reference? referral,
    Reference? facility,
    List<ClaimCareTeam>? careTeam,
    List<ClaimSupportingInfo>? supportingInfo,
    List<ClaimDiagnosis>? diagnosis,
    List<ClaimProcedure>? procedure,
    List<ClaimInsurance>? insurance,
    ClaimAccident? accident,
    List<ClaimItem>? item,
    Money? total,
  }) = _Claim;

  @override
  FhirType get fhirType => FhirType.Claim;

  factory Claim.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirClaim = fhir_r4.Claim.fromJson(resourceJson);

    return Claim(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirClaim.text,
      identifier: fhirClaim.identifier,
      status: fhirClaim.status,
      type: fhirClaim.type,
      subType: fhirClaim.subType,
      use: fhirClaim.use,
      patient: fhirClaim.patient,
      billablePeriod: fhirClaim.billablePeriod,
      created: fhirClaim.created,
      enterer: fhirClaim.enterer,
      insurer: fhirClaim.insurer,
      provider: fhirClaim.provider,
      priority: fhirClaim.priority,
      fundsReserve: fhirClaim.fundsReserve,
      related: fhirClaim.related,
      payee: fhirClaim.payee,
      referral: fhirClaim.referral,
      facility: fhirClaim.facility,
      careTeam: fhirClaim.careTeam,
      supportingInfo: fhirClaim.supportingInfo,
      diagnosis: fhirClaim.diagnosis,
      procedure: fhirClaim.procedure,
      insurance: fhirClaim.insurance,
      accident: fhirClaim.accident,
      item: fhirClaim.item,
      total: fhirClaim.total,
    );
  }
}
