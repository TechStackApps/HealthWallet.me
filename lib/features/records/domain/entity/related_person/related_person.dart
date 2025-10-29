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

part 'related_person.freezed.dart';

@freezed
class RelatedPerson with _$RelatedPerson implements IFhirResource {
  const RelatedPerson._();

  const factory RelatedPerson({
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
    FhirBoolean? active,
    Reference? patient,
    List<CodeableConcept>? relationship,
    List<HumanName>? name,
    List<ContactPoint>? telecom,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    List<Address>? address,
    List<Attachment>? photo,
    Period? period,
    List<RelatedPersonCommunication>? communication,
  }) = _RelatedPerson;

  @override
  FhirType get fhirType => FhirType.RelatedPerson;

  factory RelatedPerson.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirRelatedPerson = fhir_r4.RelatedPerson.fromJson(resourceJson);

    return RelatedPerson(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      encounterId: data.encounterId ?? '',
      subjectId: data.subjectId ?? '',
      text: fhirRelatedPerson.text,
      identifier: fhirRelatedPerson.identifier,
      active: fhirRelatedPerson.active,
      patient: fhirRelatedPerson.patient,
      relationship: fhirRelatedPerson.relationship,
      name: fhirRelatedPerson.name,
      telecom: fhirRelatedPerson.telecom,
      gender: fhirRelatedPerson.gender,
      birthDate: fhirRelatedPerson.birthDate,
      address: fhirRelatedPerson.address,
      photo: fhirRelatedPerson.photo,
      period: fhirRelatedPerson.period,
      communication: fhirRelatedPerson.communication,
    );
  }

  @override
  FhirResourceDto toLocalDto() => FhirResourceDto(
        id: id,
        sourceId: sourceId,
        resourceType: 'RelatedPerson',
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

    if (name?.isNotEmpty == true) {
      final personName = name!.first;
      final humanName = FhirFieldExtractor.extractHumanName(personName);
      if (humanName != null) return humanName;
    }

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final relationDisplay =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(relationship);
    if (relationDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: relationDisplay,
      ));
    }

    if (birthDate != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.calendar,
        info: DateFormat.yMMMMd().format(DateTime.parse(birthDate!.valueString!)),
      ));
    }

    return infoLines;
  }

  @override
  List<String?> get resourceReferences {
    return {
      patient?.reference?.valueString,
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay =>
      active?.valueBoolean == true ? 'Active' : 'Inactive';
}
