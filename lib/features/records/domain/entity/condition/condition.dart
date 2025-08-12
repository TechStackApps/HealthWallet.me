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

part 'condition.freezed.dart';

@freezed
class Condition with _$Condition implements IFhirResource {
  const Condition._();

  const factory Condition({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CodeableConcept? clinicalStatus,
    CodeableConcept? verificationStatus,
    List<CodeableConcept>? category,
    CodeableConcept? severity,
    CodeableConcept? code,
    List<CodeableConcept>? bodySite,
    Reference? subject,
    Reference? encounter,
    OnsetXCondition? onsetX,
    AbatementXCondition? abatementX,
    FhirDateTime? recordedDate,
    Reference? recorder,
    Reference? asserter,
    List<ConditionStage>? stage,
    List<ConditionEvidence>? evidence,
    List<Annotation>? note,
  }) = _Condition;

  @override
  FhirType get fhirType => FhirType.Condition;

  factory Condition.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirCondition = fhir_r4.Condition.fromJson(resourceJson);

    return Condition(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirCondition.text,
      identifier: fhirCondition.identifier,
      clinicalStatus: fhirCondition.clinicalStatus,
      verificationStatus: fhirCondition.verificationStatus,
      category: fhirCondition.category,
      severity: fhirCondition.severity,
      code: fhirCondition.code,
      bodySite: fhirCondition.bodySite,
      subject: fhirCondition.subject,
      encounter: fhirCondition.encounter,
      onsetX: fhirCondition.onsetX,
      abatementX: fhirCondition.abatementX,
      recordedDate: fhirCondition.recordedDate,
      recorder: fhirCondition.recorder,
      asserter: fhirCondition.asserter,
      stage: fhirCondition.stage,
      evidence: fhirCondition.evidence,
      note: fhirCondition.note,
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

    final statusDisplay =
        FhirFieldExtractor.extractCodeableConceptText(clinicalStatus);
    if (statusDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: "Status: $statusDisplay",
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
      recorder?.reference?.valueString,
      asserter?.reference?.valueString,
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay =>
      FhirFieldExtractor.extractCodeableConceptText(clinicalStatus) ?? '';
}
