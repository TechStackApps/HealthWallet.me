import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_date_extractor.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'observation.freezed.dart';

@freezed
class Observation with _$Observation implements IFhirResource {
  const Observation._();

  const factory Observation({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    ObservationStatus? status,
    List<CodeableConcept>? category,
    CodeableConcept? code,
    Reference? subject,
    List<Reference>? focus,
    Reference? encounter,
    EffectiveXObservation? effectiveX,
    FhirInstant? issued,
    List<Reference>? performer,
    ValueXObservation? valueX,
    CodeableConcept? dataAbsentReason,
    List<CodeableConcept>? interpretation,
    List<Annotation>? note,
    CodeableConcept? bodySite,
    CodeableConcept? method,
    Reference? specimen,
    Reference? device,
    List<ObservationReferenceRange>? referenceRange,
    List<Reference>? hasMember,
    List<Reference>? derivedFrom,
    List<ObservationComponent>? component,
  }) = _Observation;

  @override
  FhirType get fhirType => FhirType.Observation;

  factory Observation.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirObservation = fhir_r4.Observation.fromJson(resourceJson);

    return Observation(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirObservation.text,
      identifier: fhirObservation.identifier,
      basedOn: fhirObservation.basedOn,
      partOf: fhirObservation.partOf,
      status: fhirObservation.status,
      category: fhirObservation.category,
      code: fhirObservation.code,
      subject: fhirObservation.subject,
      focus: fhirObservation.focus,
      encounter: fhirObservation.encounter,
      effectiveX: fhirObservation.effectiveX,
      issued: fhirObservation.issued,
      performer: fhirObservation.performer,
      valueX: fhirObservation.valueX,
      dataAbsentReason: fhirObservation.dataAbsentReason,
      interpretation: fhirObservation.interpretation,
      note: fhirObservation.note,
      bodySite: fhirObservation.bodySite,
      method: fhirObservation.method,
      specimen: fhirObservation.specimen,
      device: fhirObservation.device,
      referenceRange: fhirObservation.referenceRange,
      hasMember: fhirObservation.hasMember,
      derivedFrom: fhirObservation.derivedFrom,
      component: fhirObservation.component,
    );
  }

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

    final valueDisplay = FhirFieldExtractor.extractObservationValue(valueX);
    if (valueDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.drop,
        info: valueDisplay,
      ));
    }

    if (component != null && component!.isNotEmpty) {
      final componentValues = component!
          .map((component) =>
              FhirFieldExtractor.extractObservationValue(component.valueX))
          .toList();

      final componentValuesDisplay =
          FhirFieldExtractor.joinNullable(componentValues, ", ");

      infoLines.add(RecordInfoLine(
        icon: Assets.icons.drop,
        info: componentValuesDisplay!,
      ));
    }

    final categoryDisplay =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(category);
    if (categoryDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: categoryDisplay,
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
      specimen?.reference?.valueString,
      device?.reference?.valueString,
      ...?basedOn?.map((reference) => reference.reference?.valueString),
      ...?partOf?.map((reference) => reference.reference?.valueString),
      ...?focus?.map((reference) => reference.reference?.valueString),
      ...?performer?.map((reference) => reference.reference?.valueString),
      ...?hasMember?.map((reference) => reference.reference?.valueString),
      ...?derivedFrom?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';

  /// Convert the domain entity to a proper FHIR R4 Observation resource
  Map<String, dynamic> toFhirResource() {
    final Map<String, dynamic> result = {
      'resourceType': 'Observation',
      'id': resourceId,
      'status': status?.valueString ?? 'final',
      'category': category?.map((c) => c.toJson()).toList(),
      'code': code?.toJson(),
      'subject': subject?.toJson(),
      'encounter': encounter?.toJson(),
      'issued': issued?.toIso8601String(),
      'performer': performer?.map((p) => p.toJson()).toList(),
      'dataAbsentReason': dataAbsentReason?.toJson(),
      'interpretation': interpretation?.map((i) => i.toJson()).toList(),
      'note': note?.map((n) => n.toJson()).toList(),
      'bodySite': bodySite?.toJson(),
      'method': method?.toJson(),
      'specimen': specimen?.toJson(),
      'device': device?.toJson(),
      'referenceRange': referenceRange?.map((r) => r.toJson()).toList(),
      'hasMember': hasMember?.map((h) => h.toJson()).toList(),
      'derivedFrom': derivedFrom?.map((d) => d.toJson()).toList(),
      'component': component?.map((c) => c.toJson()).toList(),
    };

    // Handle effectiveX union type
    if (effectiveX != null) {
      final effectiveDateTime = effectiveX?.isAs<FhirDateTime>();
      if (effectiveDateTime != null) {
        result['effectiveDateTime'] = effectiveDateTime.toIso8601String();
      }
    }

    // Handle valueX union type
    if (valueX != null) {
      final valueQuantity = valueX?.isAs<Quantity>();
      if (valueQuantity != null) {
        result['valueQuantity'] = valueQuantity.toJson();
      }

      final valueCodeableConcept = valueX?.isAs<CodeableConcept>();
      if (valueCodeableConcept != null) {
        result['valueCodeableConcept'] = valueCodeableConcept.toJson();
      }

      final valueString = valueX?.isAs<FhirString>();
      if (valueString != null) {
        result['valueString'] = valueString.valueString;
      }
    }

    return result;
  }
}
