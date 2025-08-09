import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'explanation_of_benefit.freezed.dart';

@freezed
class ExplanationOfBenefit
    with _$ExplanationOfBenefit
    implements IFhirResource {
  const ExplanationOfBenefit._();

  const factory ExplanationOfBenefit({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    String? status,
    CodeableConcept? type,
    String? use,
    Reference? patient,
    Period? billablePeriod,
    FhirDateTime? created,
    Reference? insurer,
    Reference? provider,
    Reference? referral,
    Reference? claim,
    String? outcome,
    FhirString? disposition,
    List<fhir_r4.ExplanationOfBenefitCareTeam>? careTeam,
    List<fhir_r4.ExplanationOfBenefitInsurance>? insurance,
    List<fhir_r4.ExplanationOfBenefitItem>? item,
    List<fhir_r4.ExplanationOfBenefitTotal>? total,
    fhir_r4.ExplanationOfBenefitPayment? payment,
  }) = _ExplanationOfBenefit;

  @override
  FhirType get fhirType => FhirType.ExplanationOfBenefit;

  factory ExplanationOfBenefit.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirEob = fhir_r4.ExplanationOfBenefit.fromJson(resourceJson);

    return ExplanationOfBenefit(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirEob.text,
      identifier: fhirEob.identifier,
      status: fhirEob.status?.toString(),
      type: fhirEob.type,
      use: fhirEob.use?.toString(),
      patient: fhirEob.patient,
      billablePeriod: fhirEob.billablePeriod,
      created: fhirEob.created,
      insurer: fhirEob.insurer,
      provider: fhirEob.provider,
      referral: fhirEob.referral,
      claim: fhirEob.claim,
      outcome: fhirEob.outcome?.toString(),
      disposition: fhirEob.disposition,
      careTeam: fhirEob.careTeam,
      insurance: fhirEob.insurance,
      item: fhirEob.item,
      total: fhirEob.total,
      payment: fhirEob.payment,
    );
  }
}
