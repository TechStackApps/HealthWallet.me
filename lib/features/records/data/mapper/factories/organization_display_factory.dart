import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Organization resources
class OrganizationDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Organization';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final name = rawResource['name'] as String?;
    return name ?? 'Unknown Organization';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as List<dynamic>?;
    final typeText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(type);

    final alias = rawResource['alias'] as List<dynamic>?;
    final aliasText =
        alias?.isNotEmpty == true ? alias!.first as String? : null;

    return BaseDisplayFactory.joinNonNull([typeText, aliasText], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    final active = rawResource['active'] as bool?;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(type);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return null; // Organizations don't have dates typically
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Type
    final type = rawResource['type'] as List<dynamic>?;
    final typeText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(type);
    if (typeText != null) {
      additionalInfo.add('Type: $typeText');
    }

    // Alias
    final alias = rawResource['alias'] as List<dynamic>?;
    if (alias != null && alias.isNotEmpty) {
      final aliasText = alias.first as String?;
      if (aliasText != null) {
        additionalInfo.add('Alias: $aliasText');
      }
    }

    // Contact
    final telecom = rawResource['telecom'] as List<dynamic>?;
    if (telecom != null && telecom.isNotEmpty) {
      final contact = telecom.first as Map<String, dynamic>;
      final value = contact['value'] as String?;
      final system = contact['system'] as String?;
      if (value != null && system != null) {
        additionalInfo.add('$system: $value');
      }
    }

    // Address
    final address = rawResource['address'] as List<dynamic>?;
    if (address != null && address.isNotEmpty) {
      final addr = address.first as Map<String, dynamic>;
      final city = addr['city'] as String?;
      final state = addr['state'] as String?;
      final country = addr['country'] as String?;
      final location =
          BaseDisplayFactory.joinNonNull([city, state, country], ', ');
      if (location != null) {
        additionalInfo.add('Location: $location');
      }
    }

    // Part of
    final partOf = rawResource['partOf'] as Map<String, dynamic>?;
    final partOfDisplay = BaseDisplayFactory.extractReferenceDisplay(partOf);
    if (partOfDisplay != null) {
      additionalInfo.add('Part of: $partOfDisplay');
    }

    return additionalInfo;
  }
}
