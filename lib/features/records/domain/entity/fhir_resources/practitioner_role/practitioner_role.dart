import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'practitioner_role.freezed.dart';
part 'practitioner_role.g.dart';

@freezed
class PractitionerRole with _$PractitionerRole {
  factory PractitionerRole({
    String? id,
    String? status,
    List<CodeableConcept>? codes,
    List<CodeableConcept>? specialties,
    Reference? organization,
    Reference? practitioner,
  }) = _PractitionerRole;

  factory PractitionerRole.fromJson(Map<String, dynamic> json) =>
      _$PractitionerRoleFromJson(json);
}
