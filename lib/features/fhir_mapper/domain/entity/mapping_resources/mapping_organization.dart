import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/entity/organization/organization.dart';

part 'mapping_organization.freezed.dart';

@freezed
class MappingOrganization
    with _$MappingOrganization
    implements MappingResource {
  const MappingOrganization._();

  const factory MappingOrganization({
    @Default('') String organizationName,
    @Default('') String address,
    @Default('') String phone,
  }) = _MappingOrganization;

  factory MappingOrganization.fromJson(Map<String, dynamic> json) {
    return MappingOrganization(
      organizationName: json['organizationName'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const Organization();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'organizationName': TextFieldDescriptor(
            label: 'Organization Name', value: organizationName),
        'address': TextFieldDescriptor(label: 'Address', value: address),
        'phone': TextFieldDescriptor(label: 'Phone', value: phone),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingOrganization(
        organizationName: newValues['organizationName'] ?? organizationName,
        address: newValues['address'] ?? address,
        phone: newValues['phone'] ?? phone,
      );

  @override
  String get label => 'Organization';
}
