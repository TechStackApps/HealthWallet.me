import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/presentation/models/record_info_line.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';

part 'allergy_intolerance.freezed.dart';

@freezed
class AllergyIntolerance with _$AllergyIntolerance implements IFhirResource {
  const AllergyIntolerance._();

  const factory AllergyIntolerance({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CodeableConcept? clinicalStatus,
    CodeableConcept? verificationStatus,
    AllergyIntoleranceType? type,
    List<AllergyIntoleranceCategory>? category,
    AllergyIntoleranceCriticality? criticality,
    CodeableConcept? code,
    Reference? patient,
    OnsetXAllergyIntolerance? onsetX,
    FhirDateTime? recordedDate,
    Reference? recorder,
    Reference? asserter,
    FhirDateTime? lastOccurrence,
    List<Annotation>? note,
    List<AllergyIntoleranceReaction>? reaction,
  }) = _AllergyIntolerance;

  @override
  FhirType get fhirType => FhirType.AllergyIntolerance;

  factory AllergyIntolerance.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirAllergyIntolerance =
        fhir_r4.AllergyIntolerance.fromJson(resourceJson);

    return AllergyIntolerance(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirAllergyIntolerance.text,
      identifier: fhirAllergyIntolerance.identifier,
      clinicalStatus: fhirAllergyIntolerance.clinicalStatus,
      verificationStatus: fhirAllergyIntolerance.verificationStatus,
      type: fhirAllergyIntolerance.type,
      category: fhirAllergyIntolerance.category,
      criticality: fhirAllergyIntolerance.criticality,
      code: fhirAllergyIntolerance.code,
      patient: fhirAllergyIntolerance.patient,
      onsetX: fhirAllergyIntolerance.onsetX,
      recordedDate: fhirAllergyIntolerance.recordedDate,
      recorder: fhirAllergyIntolerance.recorder,
      asserter: fhirAllergyIntolerance.asserter,
      lastOccurrence: fhirAllergyIntolerance.lastOccurrence,
      note: fhirAllergyIntolerance.note,
      reaction: fhirAllergyIntolerance.reaction,
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

    final categoryDisplay =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(category);
    if (categoryDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: categoryDisplay,
      ));
    }

    final criticalityDisplay = criticality?.valueString;
    if (criticalityDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.warning,
        info: "Criticality: $criticalityDisplay",
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
      patient?.reference?.valueString,
      recorder?.reference?.valueString,
      asserter?.reference?.valueString,
    }.where((reference) => reference != null).toList();
  }
}
