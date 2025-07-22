import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Location resources
class LocationDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Location';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final name = rawResource['name'] as String?;
    return name ?? 'Unknown Location';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as List<dynamic>?;
    final typeText =
        BaseDisplayFactory.extractFirstCodeableConceptFromArray(type);

    final status = rawResource['status'] as String?;

    return BaseDisplayFactory.joinNonNull([status, typeText], ' • ');
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    return rawResource['status'] as String?;
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    final type = rawResource['type'] as List<dynamic>?;
    return BaseDisplayFactory.extractFirstCodeableConceptFromArray(type);
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return null; // Locations don't have dates typically
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

    // Description
    final description = rawResource['description'] as String?;
    if (description != null) {
      additionalInfo.add('Description: $description');
    }

    // Mode
    final mode = rawResource['mode'] as String?;
    if (mode != null) {
      additionalInfo.add('Mode: $mode');
    }

    // Address
    final address = rawResource['address'] as Map<String, dynamic>?;
    if (address != null) {
      final line = address['line'] as List<dynamic>?;
      final city = address['city'] as String?;
      final state = address['state'] as String?;
      final postalCode = address['postalCode'] as String?;
      final country = address['country'] as String?;

      final addressParts = <String>[];
      if (line != null && line.isNotEmpty) {
        addressParts.add(line.join(' '));
      }
      if (city != null) addressParts.add(city);
      if (state != null) addressParts.add(state);
      if (postalCode != null) addressParts.add(postalCode);
      if (country != null) addressParts.add(country);

      if (addressParts.isNotEmpty) {
        additionalInfo.add('Address: ${addressParts.join(', ')}');
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

    // Managing organization
    final managingOrganization =
        rawResource['managingOrganization'] as Map<String, dynamic>?;
    final orgDisplay =
        BaseDisplayFactory.extractReferenceDisplay(managingOrganization);
    if (orgDisplay != null) {
      additionalInfo.add('Organization: $orgDisplay');
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
