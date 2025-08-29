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

part 'specimen.freezed.dart';

@freezed
class Specimen with _$Specimen implements IFhirResource {
  const Specimen._();

  const factory Specimen({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    Narrative? text,
    List<Identifier>? identifier,
    Identifier? accessionIdentifier,
    SpecimenStatus? status,
    CodeableConcept? type,
    Reference? subject,
    FhirDateTime? receivedTime,
    List<Reference>? parent,
    List<Reference>? request,
    SpecimenCollection? collection,
    List<SpecimenProcessing>? processing,
    List<SpecimenContainer>? container,
    List<CodeableConcept>? condition,
    List<Annotation>? note,
  }) = _Specimen;

  @override
  FhirType get fhirType => FhirType.Specimen;

  factory Specimen.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirSpecimen = fhir_r4.Specimen.fromJson(resourceJson);

    return Specimen(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      text: fhirSpecimen.text,
      identifier: fhirSpecimen.identifier,
      accessionIdentifier: fhirSpecimen.accessionIdentifier,
      status: fhirSpecimen.status,
      type: fhirSpecimen.type,
      subject: fhirSpecimen.subject,
      receivedTime: fhirSpecimen.receivedTime,
      parent: fhirSpecimen.parent,
      request: fhirSpecimen.request,
      collection: fhirSpecimen.collection,
      processing: fhirSpecimen.processing,
      container: fhirSpecimen.container,
      condition: fhirSpecimen.condition,
      note: fhirSpecimen.note,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText = FhirFieldExtractor.extractCodeableConceptText(type);
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
        info: statusDisplay,
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
      ...?parent?.map((reference) => reference.reference?.valueString),
      ...?request?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
