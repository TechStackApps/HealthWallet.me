import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

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
    @Default({}) Map<String, dynamic> rawResource,
    @Default('') String encounterId,
    @Default('') String subjectId,
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
      rawResource: resourceJson,
      encounterId: data.encounterId ?? '',
      subjectId: data.subjectId ?? '',
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

  @override
  FhirResourceDto toLocalDto() => FhirResourceDto(
        id: id,
        sourceId: sourceId,
        resourceType: 'ServiceRequest',
        resourceId: resourceId,
        title: title,
        date: date,
        resourceRaw: rawResource,
        encounterId: encounterId,
        subjectId: subjectId,
      );

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText = FhirFieldExtractor.extractCodeableConceptText(code);
    if (displayText != null) return displayText;

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final statusDisplay = status?.valueString;
    if (statusDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: "Status: $statusDisplay",
      ));
    }

    final intentDisplay = intent?.valueString;
    if (intentDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: "Intent: $intentDisplay",
      ));
    }

    if (date != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.calendar,
        info: DateFormat.yMMMMd().format(date!),
      ));
    }

    return infoLines;
  }

  @override
  List<String?> get resourceReferences {
    return {
      subject?.reference?.valueString,
      encounter?.reference?.valueString,
      requester?.reference?.valueString,
      ...?basedOn?.map((reference) => reference.reference?.valueString),
      ...?replaces?.map((reference) => reference.reference?.valueString),
      ...?performer?.map((reference) => reference.reference?.valueString),
      ...?locationReference
          ?.map((reference) => reference.reference?.valueString),
      ...?reasonReference?.map((reference) => reference.reference?.valueString),
      ...?insurance?.map((reference) => reference.reference?.valueString),
      ...?supportingInfo?.map((reference) => reference.reference?.valueString),
      ...?specimen?.map((reference) => reference.reference?.valueString),
      ...?relevantHistory?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
