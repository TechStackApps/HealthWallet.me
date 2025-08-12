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

part 'coverage.freezed.dart';

@freezed
class Coverage with _$Coverage implements IFhirResource {
  const Coverage._();

  const factory Coverage({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    String? status,
    CodeableConcept? type,
    Reference? policyHolder,
    Reference? subscriber,
    FhirString? subscriberId,
    Reference? beneficiary,
    FhirString? dependent,
    CodeableConcept? relationship,
    Period? period,
    List<Reference>? payor,
    List<fhir_r4.CoverageClass>? class_,
    FhirPositiveInt? order,
    FhirString? network,
    List<fhir_r4.CoverageCostToBeneficiary>? costToBeneficiary,
    FhirBoolean? subrogation,
    List<Reference>? contract,
  }) = _Coverage;

  @override
  FhirType get fhirType => FhirType.Coverage;

  factory Coverage.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirCoverage = fhir_r4.Coverage.fromJson(resourceJson);

    return Coverage(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirCoverage.text,
      identifier: fhirCoverage.identifier,
      status: fhirCoverage.status?.toString(),
      type: fhirCoverage.type,
      policyHolder: fhirCoverage.policyHolder,
      subscriber: fhirCoverage.subscriber,
      subscriberId: fhirCoverage.subscriberId,
      beneficiary: fhirCoverage.beneficiary,
      dependent: fhirCoverage.dependent,
      relationship: fhirCoverage.relationship,
      period: fhirCoverage.period,
      payor: fhirCoverage.payor,
      class_: fhirCoverage.class_,
      order: fhirCoverage.order,
      network: fhirCoverage.network,
      costToBeneficiary: fhirCoverage.costToBeneficiary,
      subrogation: fhirCoverage.subrogation,
      contract: fhirCoverage.contract,
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

    if (status != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.information,
        info: "Status: $status",
      ));
    }

    final payorDisplay = payor?.firstOrNull?.display?.valueString;
    if (payorDisplay != null) {
      infoLines.add(RecordInfoLine(
        icon: Assets.icons.hospital,
        info: "Payor: $payorDisplay",
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
      policyHolder?.reference?.valueString,
      subscriber?.reference?.valueString,
      beneficiary?.reference?.valueString,
      ...?payor?.map((reference) => reference.reference?.valueString),
      ...?contract?.map((reference) => reference.reference?.valueString),
    }.where((reference) => reference != null).toList();
  }

  @override
  String get statusDisplay => status ?? '';
}
