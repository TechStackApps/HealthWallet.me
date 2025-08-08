import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'service_request.freezed.dart';

@freezed
class ServiceRequest with _$ServiceRequest implements IFhirResource {
  const ServiceRequest._();

  const factory ServiceRequest({
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
    List<Reference>? replaces,
    Identifier? requisition,
    RequestStatus? status,
    RequestIntent? intent,
    List<CodeableConcept>? category,
    RequestPriority? priority,
    FhirBoolean? doNotPerform,
    CodeableConcept? code,
    List<CodeableConcept>? orderDetail,
    QuantityXServiceRequest? quantityX,
    Reference? subject,
    Reference? encounter,
    OccurrenceXServiceRequest? occurrenceX,
    AsNeededXServiceRequest? asNeededX,
    FhirDateTime? authoredOn,
    Reference? requester,
    CodeableConcept? performerType,
    List<Reference>? performer,
    List<CodeableConcept>? locationCode,
    List<Reference>? locationReference,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<Reference>? insurance,
    List<Reference>? supportingInfo,
    List<Reference>? specimen,
    List<CodeableConcept>? bodySite,
    List<Annotation>? note,
    FhirString? patientInstruction,
    List<Reference>? relevantHistory,
  }) = _ServiceRequest;

  @override
  FhirType get fhirType => FhirType.ServiceRequest;

  factory ServiceRequest.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirServiceRequest = fhir_r4.ServiceRequest.fromJson(resourceJson);

    return ServiceRequest(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirServiceRequest.text,
      identifier: fhirServiceRequest.identifier,
      instantiatesCanonical: fhirServiceRequest.instantiatesCanonical,
      instantiatesUri: fhirServiceRequest.instantiatesUri,
      basedOn: fhirServiceRequest.basedOn,
      replaces: fhirServiceRequest.replaces,
      requisition: fhirServiceRequest.requisition,
      status: fhirServiceRequest.status,
      intent: fhirServiceRequest.intent,
      category: fhirServiceRequest.category,
      priority: fhirServiceRequest.priority,
      doNotPerform: fhirServiceRequest.doNotPerform,
      code: fhirServiceRequest.code,
      orderDetail: fhirServiceRequest.orderDetail,
      quantityX: fhirServiceRequest.quantityX,
      subject: fhirServiceRequest.subject,
      encounter: fhirServiceRequest.encounter,
      occurrenceX: fhirServiceRequest.occurrenceX,
      asNeededX: fhirServiceRequest.asNeededX,
      authoredOn: fhirServiceRequest.authoredOn,
      requester: fhirServiceRequest.requester,
      performerType: fhirServiceRequest.performerType,
      performer: fhirServiceRequest.performer,
      locationCode: fhirServiceRequest.locationCode,
      locationReference: fhirServiceRequest.locationReference,
      reasonCode: fhirServiceRequest.reasonCode,
      reasonReference: fhirServiceRequest.reasonReference,
      insurance: fhirServiceRequest.insurance,
      supportingInfo: fhirServiceRequest.supportingInfo,
      specimen: fhirServiceRequest.specimen,
      bodySite: fhirServiceRequest.bodySite,
      note: fhirServiceRequest.note,
      patientInstruction: fhirServiceRequest.patientInstruction,
      relevantHistory: fhirServiceRequest.relevantHistory,
    );
  }
}
