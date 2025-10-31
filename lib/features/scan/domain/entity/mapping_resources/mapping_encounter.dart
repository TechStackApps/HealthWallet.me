import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/core/utils/validator.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:uuid/uuid.dart';

part 'mapping_encounter.freezed.dart';

@freezed
class MappingEncounter with _$MappingEncounter implements MappingResource {
  const MappingEncounter._();

  const factory MappingEncounter({
    @Default('') String id,
    @Default(MappedProperty()) MappedProperty encounterType,
    @Default(MappedProperty()) MappedProperty location,
    @Default(MappedProperty()) MappedProperty periodStart,
  }) = _MappingEncounter;

  factory MappingEncounter.fromJson(Map<String, dynamic> json) {
    return MappingEncounter(
      id: const Uuid().v4(),
      encounterType: MappedProperty(value: json['encounterType'] ?? ''),
      location: MappedProperty(value: json['location'] ?? ''),
      periodStart: MappedProperty(value: json['periodStart'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource({
    String? sourceId,
    String? encounterId,
    String? subjectId,
  }) {
    fhir_r4.Encounter encounter = fhir_r4.Encounter(
        type: [
          fhir_r4.CodeableConcept(text: fhir_r4.FhirString(encounterType.value))
        ],
        location: [
          fhir_r4.EncounterLocation(
            location:
                fhir_r4.Reference(display: fhir_r4.FhirString(location.value)),
          )
        ],
        period: fhir_r4.Period(
          start: fhir_r4.FhirDateTime.fromString(periodStart.value),
        ),
        status: fhir_r4.EncounterStatus.unknown,
        class_: fhir_r4.Coding(code: fhir_r4.FhirCode("AMB")),
        subject: fhir_r4.Reference(
            reference: fhir_r4.FhirString('Patient/$subjectId')));

    Map<String, dynamic> rawResource = encounter.toJson();

    return Encounter(
      id: id,
      resourceId: id,
      title: encounterType.value,
      date: DateTime.tryParse(periodStart.value),
      sourceId: sourceId ?? '',
      encounterId: encounterId ?? '',
      subjectId: subjectId ?? '',
      rawResource: rawResource,
      type: encounter.type,
      location: encounter.location,
      period: encounter.period,
    );
  }

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'encounterType': TextFieldDescriptor(
          label: 'Encounter Type',
          value: encounterType.value,
          confidenceLevel: encounterType.confidenceLevel,
          validators: [nonEmptyValidator],
        ),
        'location': TextFieldDescriptor(
          label: 'Location',
          value: location.value,
          confidenceLevel: location.confidenceLevel,
        ),
        'periodStart': TextFieldDescriptor(
          label: 'Start Date',
          value: periodStart.value,
          confidenceLevel: periodStart.confidenceLevel,
          validators: [nonEmptyValidator, dateValidator],
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingEncounter(
        id: id,
        encounterType: MappedProperty(
          value: newValues['encounterType'] ?? encounterType.value,
          confidenceLevel: newValues['encounterType'] != null
              ? 1
              : encounterType.confidenceLevel,
        ),
        location: MappedProperty(
          value: newValues['location'] ?? location.value,
          confidenceLevel:
              newValues['location'] != null ? 1 : location.confidenceLevel,
        ),
        periodStart: MappedProperty(
          value: newValues['periodStart'] ?? periodStart.value,
          confidenceLevel: newValues['periodStart'] != null
              ? 1
              : periodStart.confidenceLevel,
        ),
      );

  @override
  String get label => 'Encounter';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        encounterType: encounterType.calculateConfidence(inputText),
        location: location.calculateConfidence(inputText),
        periodStart: periodStart.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      encounterType.isValid || location.isValid || periodStart.isValid;
}
