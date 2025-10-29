import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/organization/organization.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:uuid/uuid.dart';

part 'mapping_organization.freezed.dart';

@freezed
class MappingOrganization
    with _$MappingOrganization
    implements MappingResource {
  const MappingOrganization._();

  const factory MappingOrganization({
    @Default('') String id,
    @Default(MappedProperty()) MappedProperty organizationName,
    @Default(MappedProperty()) MappedProperty address,
    @Default(MappedProperty()) MappedProperty phone,
  }) = _MappingOrganization;

  factory MappingOrganization.fromJson(Map<String, dynamic> json) {
    return MappingOrganization(
      id: const Uuid().v4(),
      organizationName: MappedProperty(value: json['organizationName'] ?? ''),
      address: MappedProperty(value: json['address'] ?? ''),
      phone: MappedProperty(value: json['phone'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource({
    String? sourceId,
    String? encounterId,
    String? subjectId,
  }) {
    const uuid = Uuid();

    fhir_r4.Organization organization = fhir_r4.Organization(
      name: fhir_r4.FhirString(organizationName.value),
      address: [fhir_r4.Address(text: fhir_r4.FhirString(address.value))],
      telecom: [fhir_r4.ContactPoint(value: fhir_r4.FhirString(phone.value))],
    );

    final rawResource = organization.toJson();

    return Organization(
      id: id,
      resourceId: uuid.v4(),
      title: organizationName.value,
      sourceId: sourceId ?? '',
      encounterId: encounterId ?? '',
      subjectId: subjectId ?? '',
      rawResource: rawResource,
      name: organization.name,
      address: organization.address,
      telecom: organization.telecom,
    );
  }

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'organizationName': TextFieldDescriptor(
          label: 'Organization Name',
          value: organizationName.value,
          confidenceLevel: organizationName.confidenceLevel,
        ),
        'address': TextFieldDescriptor(
          label: 'Address',
          value: address.value,
          confidenceLevel: address.confidenceLevel,
        ),
        'phone': TextFieldDescriptor(
          label: 'Phone',
          value: phone.value,
          confidenceLevel: phone.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingOrganization(
        organizationName: MappedProperty(
            value: newValues['organizationName'] ?? organizationName.value),
        address: MappedProperty(value: newValues['address'] ?? address.value),
        phone: MappedProperty(value: newValues['phone'] ?? phone.value),
      );

  @override
  String get label => 'Organization';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        organizationName: organizationName.calculateConfidence(inputText),
        address: address.calculateConfidence(inputText),
        phone: phone.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      organizationName.isValid || address.isValid || phone.isValid;
}
