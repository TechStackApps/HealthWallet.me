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

part 'patient.freezed.dart';

@freezed
class Patient with _$Patient implements IFhirResource {
  const Patient._();

  const factory Patient({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    List<HumanName>? name,
    List<ContactPoint>? telecom,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    DeceasedXPatient? deceasedX,
    List<Address>? address,
    CodeableConcept? maritalStatus,
    MultipleBirthXPatient? multipleBirthX,
    List<Attachment>? photo,
    List<PatientContact>? contact,
    List<PatientCommunication>? communication,
    List<Reference>? generalPractitioner,
    Reference? managingOrganization,
    List<PatientLink>? link,
  }) = _Patient;

  @override
  FhirType get fhirType => FhirType.Patient;

  factory Patient.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPatient = fhir_r4.Patient.fromJson(resourceJson);

    return Patient(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirPatient.text,
      identifier: fhirPatient.identifier,
      active: fhirPatient.active,
      name: fhirPatient.name,
      telecom: fhirPatient.telecom,
      gender: fhirPatient.gender,
      birthDate: fhirPatient.birthDate,
      deceasedX: fhirPatient.deceasedX,
      address: fhirPatient.address,
      maritalStatus: fhirPatient.maritalStatus,
      multipleBirthX: fhirPatient.multipleBirthX,
      photo: fhirPatient.photo,
      contact: fhirPatient.contact,
      communication: fhirPatient.communication,
      generalPractitioner: fhirPatient.generalPractitioner,
      managingOrganization: fhirPatient.managingOrganization,
      link: fhirPatient.link,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    if (name?.isNotEmpty == true) {
      final patientName = name!.first;
      final humanName = FhirFieldExtractor.extractHumanName(patientName);
      if (humanName != null) return humanName;
    }

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final genderDisplay = gender?.display?.valueString;
    if (genderDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: genderDisplay,
      ));
    }

    final addressDisplay =
        FhirFieldExtractor.formatAddress(address?.firstOrNull);
    if (addressDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.identification,
        info: addressDisplay,
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
      managingOrganization?.reference?.valueString,
      ...?generalPractitioner
          ?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay =>
      active?.valueBoolean == true ? 'Active' : 'Inactive';

  Map<String, dynamic> toFhirResource() {
    final fhirPatient = fhir_r4.Patient(
      id: fhir_r4.FhirString(resourceId),
      active: active ?? fhir_r4.FhirBoolean(true),
      identifier: identifier,
      name: name,
      telecom: telecom,
      gender: gender,
      birthDate: birthDate,
      deceasedX: deceasedX,
      address: address,
      maritalStatus: maritalStatus,
      multipleBirthX: multipleBirthX,
      photo: photo,
      contact: contact,
      communication: communication,
      generalPractitioner: generalPractitioner,
      managingOrganization: managingOrganization,
      link: link,
      text: text,
    );

    return fhirPatient.toJson();
  }
}
