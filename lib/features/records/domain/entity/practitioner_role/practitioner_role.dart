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

part 'practitioner_role.freezed.dart';

@freezed
class PractitionerRole with _$PractitionerRole implements IFhirResource {
  const PractitionerRole._();

  const factory PractitionerRole({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    @Default({}) Map<String, dynamic> rawResource,
    Narrative? text,
    List<Identifier>? identifier,
    FhirBoolean? active,
    Period? period,
    Reference? practitioner,
    Reference? organization,
    List<CodeableConcept>? code,
    List<CodeableConcept>? specialty,
    List<Reference>? location,
    List<Reference>? healthcareService,
    List<ContactPoint>? telecom,
    List<PractitionerRoleAvailableTime>? availableTime,
    List<PractitionerRoleNotAvailable>? notAvailable,
    FhirString? availabilityExceptions,
    List<Reference>? endpoint,
  }) = _PractitionerRole;

  @override
  FhirType get fhirType => FhirType.PractitionerRole;

  factory PractitionerRole.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirPractitionerRole =
        fhir_r4.PractitionerRole.fromJson(resourceJson);

    return PractitionerRole(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      rawResource: resourceJson,
      text: fhirPractitionerRole.text,
      identifier: fhirPractitionerRole.identifier,
      active: fhirPractitionerRole.active,
      period: fhirPractitionerRole.period,
      practitioner: fhirPractitionerRole.practitioner,
      organization: fhirPractitionerRole.organization,
      code: fhirPractitionerRole.code,
      specialty: fhirPractitionerRole.specialty,
      location: fhirPractitionerRole.location,
      healthcareService: fhirPractitionerRole.healthcareService,
      telecom: fhirPractitionerRole.telecom,
      availableTime: fhirPractitionerRole.availableTime,
      notAvailable: fhirPractitionerRole.notAvailable,
      availabilityExceptions: fhirPractitionerRole.availabilityExceptions,
      endpoint: fhirPractitionerRole.endpoint,
    );
  }

  @override
  String get displayTitle {
    if (title.isNotEmpty) {
      return title;
    }

    final displayText =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(code);
    if (displayText != null) return displayText;

    return fhirType.display;
  }

  @override
  List<RecordInfoLine> get additionalInfo {
    List<RecordInfoLine> infoLines = [];

    final practitionerDisplay = practitioner?.display?.valueString;
    if (practitionerDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.user,
        info: practitionerDisplay,
      ));
    }

    final specialtyDisplay =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(specialty);
    if (specialtyDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: specialtyDisplay,
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
      practitioner?.reference?.valueString,
      organization?.reference?.valueString,
      ...?location?.map((reference) => reference.reference?.valueString),
      ...?healthcareService
          ?.map((reference) => reference.reference?.valueString),
      ...?endpoint?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay =>
      active?.valueBoolean == true ? 'Active' : 'Inactive';
}
