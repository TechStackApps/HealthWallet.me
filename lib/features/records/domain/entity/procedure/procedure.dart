import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'procedure.freezed.dart';

@freezed
class Procedure with _$Procedure implements IFhirResource {
  const Procedure._();

  factory Procedure({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    List<FhirCanonical>? instantiatesCanonical,
    List<FhirUri>? instantiatesUri,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    EventStatus? status,
    CodeableConcept? statusReason,
    CodeableConcept? category,
    CodeableConcept? code,
    Reference? subject,
    Reference? encounter,
    PerformedXProcedure? performedX,
    Reference? recorder,
    Reference? asserter,
    List<ProcedurePerformer>? performer,
    Reference? location,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<CodeableConcept>? bodySite,
    CodeableConcept? outcome,
    List<Reference>? report,
    List<CodeableConcept>? complication,
    List<Reference>? complicationDetail,
    List<CodeableConcept>? followUp,
    List<Annotation>? note,
    List<ProcedureFocalDevice>? focalDevice,
    List<Reference>? usedReference,
    List<CodeableConcept>? usedCode,
  }) = _Procedure;

  @override
  FhirType get fhirType => FhirType.Procedure;

  factory Procedure.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirProcedure = fhir_r4.Procedure.fromJson(resourceJson);

    return Procedure(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirProcedure.text,
      identifier: fhirProcedure.identifier,
      instantiatesCanonical: fhirProcedure.instantiatesCanonical,
      instantiatesUri: fhirProcedure.instantiatesUri,
      basedOn: fhirProcedure.basedOn,
      partOf: fhirProcedure.partOf,
      status: fhirProcedure.status,
      statusReason: fhirProcedure.statusReason,
      category: fhirProcedure.category,
      code: fhirProcedure.code,
      subject: fhirProcedure.subject,
      encounter: fhirProcedure.encounter,
      performedX: fhirProcedure.performedX,
      recorder: fhirProcedure.recorder,
      asserter: fhirProcedure.asserter,
      performer: fhirProcedure.performer,
      location: fhirProcedure.location,
      reasonCode: fhirProcedure.reasonCode,
      reasonReference: fhirProcedure.reasonReference,
      bodySite: fhirProcedure.bodySite,
      outcome: fhirProcedure.outcome,
      report: fhirProcedure.report,
      complication: fhirProcedure.complication,
      complicationDetail: fhirProcedure.complicationDetail,
      followUp: fhirProcedure.followUp,
      note: fhirProcedure.note,
      focalDevice: fhirProcedure.focalDevice,
      usedReference: fhirProcedure.usedReference,
      usedCode: fhirProcedure.usedCode,
    );
  }
}
