import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/note.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'immunization.freezed.dart';
part 'immunization.g.dart';

@freezed
class Immunization with _$Immunization {
  factory Immunization({
    String? id,
    String? title,
    String? status,
    @JsonKey(name: 'provided_date') String? providedDate,
    @JsonKey(name: 'manufacturer_text') String? manufacturerText,
    @JsonKey(name: 'has_lot_number') bool? hasLotNumber,
    @JsonKey(name: 'lot_number') String? lotNumber,
    @JsonKey(name: 'lot_number_expiration_date')
    String? lotNumberExpirationDate,
    @JsonKey(name: 'has_dose_quantity') bool? hasDoseQuantity,
    @JsonKey(name: 'dose_quantity') Coding? doseQuantity,
    String? requester,
    String? reported,
    String? performer,
    List<Coding>? route,
    @JsonKey(name: 'has_route') bool? hasRoute,
    List<Coding>? site,
    @JsonKey(name: 'has_site') bool? hasSite,
    Reference? patient,
    List<Note>? note,
    String? location,
  }) = _Immunization;

  factory Immunization.fromJson(Map<String, dynamic> json) =>
      _$ImmunizationFromJson(json);
}
