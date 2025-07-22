import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';

part 'procedure.freezed.dart';
part 'procedure.g.dart';

@freezed
class Procedure with _$Procedure {
  factory Procedure({
    required String id,
    required String status,
    required CodeableConcept code,
    DateTime? performedDateTime,
  }) = _Procedure;

  factory Procedure.fromJson(Map<String, dynamic> json) =>
      _$ProcedureFromJson(json);
}
