import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';

part 'mapping_procedure.freezed.dart';

@freezed
class MappingProcedure with _$MappingProcedure implements MappingResource {
  const MappingProcedure._();

  const factory MappingProcedure({
    @Default('') String procedureName,
    @Default('') String performedDateTime,
    @Default('') String reason,
  }) = _MappingProcedure;

  factory MappingProcedure.fromJson(Map<String, dynamic> json) {
    return MappingProcedure(
      procedureName: json['procedureName'] ?? '',
      performedDateTime: json['performedDateTime'] ?? '',
      reason: json['reason'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Procedure();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'procedureName':
            TextFieldDescriptor(label: 'Procedure Name', value: procedureName),
        'performedDateTime': TextFieldDescriptor(
            label: 'Performed Date', value: performedDateTime),
        'reason': TextFieldDescriptor(label: 'Reason', value: reason),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingProcedure(
        procedureName: newValues['procedureName'] ?? procedureName,
        performedDateTime: newValues['performedDateTime'] ?? performedDateTime,
        reason: newValues['reason'] ?? reason,
      );

  @override
  String get label => 'Procedure';
}
