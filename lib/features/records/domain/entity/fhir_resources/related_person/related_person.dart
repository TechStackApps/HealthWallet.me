import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/address.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/telecom.dart';

part 'related_person.freezed.dart';
part 'related_person.g.dart';

@freezed
class RelatedPerson with _$RelatedPerson {
  factory RelatedPerson({
    String? id,
    String? patient,
    String? name,
    String? birthdate,
    String? gender,
    Address? address,
    @JsonKey(name: 'related_person_telecom')
    List<Telecom>? relatedPersonTelecom,
  }) = _RelatedPerson;

  factory RelatedPerson.fromJson(Map<String, dynamic> json) =>
      _$RelatedPersonFromJson(json);
}
