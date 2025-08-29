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

part 'practitioner.freezed.dart';

@freezed
class Practitioner with _$Practitioner implements IFhirResource {
  const Practitioner._();

  const factory Practitioner({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    List<HumanName>? name,
    List<ContactPoint>? telecom,
    List<Address>? address,
    AdministrativeGender? gender,
    FhirDate? birthDate,
    List<PractitionerQualification>? qualification,
    List<CodeableConcept>? communication,
  }) = _Practitioner;

  @override
  FhirType get fhirType => FhirType.Practitioner;

  factory Practitioner.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPractitioner = fhir_r4.Practitioner.fromJson(resourceJson);

    return Practitioner(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      text: fhirPractitioner.text,
      identifier: fhirPractitioner.identifier,
      active: fhirPractitioner.active,
      name: fhirPractitioner.name,
      telecom: fhirPractitioner.telecom,
      address: fhirPractitioner.address,
      gender: fhirPractitioner.gender,
      birthDate: fhirPractitioner.birthDate,
      qualification: fhirPractitioner.qualification,
      communication: fhirPractitioner.communication,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    if (name?.isNotEmpty == true) {
      final practitionerName = name!.first;
      final humanName = FhirFieldExtractor.extractHumanName(practitionerName);
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
  List<String> get resourceReferences => [];

  @override
  String get statusDisplay =>
      active?.valueBoolean == true ? 'Active' : 'Inactive';
}
