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

part 'media.freezed.dart';

@freezed
class Media with _$Media implements IFhirResource {
  const Media._();

  const factory Media({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    EventStatus? status,
    CodeableConcept? type,
    CodeableConcept? modality,
    CodeableConcept? view,
    Reference? subject,
    Reference? encounter,
    CreatedXMedia? createdX,
    FhirInstant? issued,
    Reference? operator_,
    List<CodeableConcept>? reasonCode,
    CodeableConcept? bodySite,
    FhirString? deviceName,
    Reference? device,
    FhirPositiveInt? height,
    FhirPositiveInt? width,
    FhirPositiveInt? frames,
    FhirDecimal? duration,
    Attachment? content,
    List<Annotation>? note,
  }) = _Media;

  @override
  FhirType get fhirType => FhirType.Media;

  factory Media.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedia = fhir_r4.Media.fromJson(resourceJson);

    return Media(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirMedia.text,
      identifier: fhirMedia.identifier,
      basedOn: fhirMedia.basedOn,
      partOf: fhirMedia.partOf,
      status: fhirMedia.status,
      type: fhirMedia.type,
      modality: fhirMedia.modality,
      view: fhirMedia.view,
      subject: fhirMedia.subject,
      encounter: fhirMedia.encounter,
      createdX: fhirMedia.createdX,
      issued: fhirMedia.issued,
      operator_: fhirMedia.operator_,
      reasonCode: fhirMedia.reasonCode,
      bodySite: fhirMedia.bodySite,
      deviceName: fhirMedia.deviceName,
      device: fhirMedia.device,
      height: fhirMedia.height,
      width: fhirMedia.width,
      frames: fhirMedia.frames,
      duration: fhirMedia.duration,
      content: fhirMedia.content,
      note: fhirMedia.note,
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
        info: "Status: $statusDisplay",
      ));
    }

    if (deviceName?.valueString != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.hospital,
        info: deviceName!.valueString!,
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
      operator_?.reference?.valueString,
      device?.reference?.valueString,
      ...?basedOn?.map((reference) => reference.reference?.valueString),
      ...?partOf?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status?.valueString ?? '';
}
