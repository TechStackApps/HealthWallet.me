import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';

part 'mapping_procedure.freezed.dart';

@freezed
class MappingProcedure with _$MappingProcedure implements MappingResource {
  const MappingProcedure._();

  const factory MappingProcedure({
    @Default(MappedProperty()) MappedProperty procedureName,
    @Default(MappedProperty()) MappedProperty performedDateTime,
    @Default(MappedProperty()) MappedProperty reason,
  }) = _MappingProcedure;

  factory MappingProcedure.fromJson(Map<String, dynamic> json) {
    return MappingProcedure(
      procedureName: MappedProperty(value: json['procedureName'] ?? ''),
      performedDateTime: MappedProperty(value: json['performedDateTime'] ?? ''),
      reason: MappedProperty(value: json['reason'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const Procedure();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'procedureName': TextFieldDescriptor(
          label: 'Procedure Name',
          value: procedureName.value,
          confidenceLevel: procedureName.confidenceLevel,
        ),
        'performedDateTime': TextFieldDescriptor(
          label: 'Performed Date',
          value: performedDateTime.value,
          confidenceLevel: performedDateTime.confidenceLevel,
        ),
        'reason': TextFieldDescriptor(
          label: 'Reason',
          value: reason.value,
          confidenceLevel: reason.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingProcedure(
        procedureName: MappedProperty(
            value: newValues['procedureName'] ?? procedureName.value),
        performedDateTime: MappedProperty(
            value: newValues['performedDateTime'] ?? performedDateTime.value),
        reason: MappedProperty(value: newValues['reason'] ?? reason.value),
      );

  @override
  String get label => 'Procedure';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        procedureName: procedureName.calculateConfidence(inputText),
        performedDateTime: performedDateTime.calculateConfidence(inputText),
        reason: reason.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      performedDateTime.isValid || performedDateTime.isValid || reason.isValid;
}
