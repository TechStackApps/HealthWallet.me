import 'package:health_wallet/features/records/data/mapper/factories/base_display_factory.dart';

/// Display factory for Practitioner resources
class PractitionerDisplayFactory extends BaseDisplayFactory {
  @override
  String get resourceType => 'Practitioner';

  @override
  String extractPrimaryDisplay(Map<String, dynamic> rawResource) {
    final name = rawResource['name'] as List<dynamic>?;
    if (name != null && name.isNotEmpty) {
      final firstName = name.first as Map<String, dynamic>;
      final given = firstName['given'] as List<dynamic>?;
      final family = firstName['family'] as String?;
      final prefix = firstName['prefix'] as List<dynamic>?;

      final prefixStr = prefix?.isNotEmpty == true ? '${prefix!.first} ' : '';
      final givenNames = given?.cast<String>().join(' ') ?? '';
      final fullName = '$prefixStr$givenNames $family'.trim();
      return fullName.isNotEmpty ? fullName : 'Unknown Practitioner';
    }

    return 'Unknown Practitioner';
  }

  @override
  String? extractSecondaryDisplay(Map<String, dynamic> rawResource) {
    final qualification = rawResource['qualification'] as List<dynamic>?;
    if (qualification != null && qualification.isNotEmpty) {
      final qual = qualification.first as Map<String, dynamic>;
      final code = qual['code'] as Map<String, dynamic>?;
      return BaseDisplayFactory.extractCodeableConceptTextNullable(code);
    }

    return null;
  }

  @override
  String? extractStatus(Map<String, dynamic> rawResource) {
    final active = rawResource['active'] as bool?;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(Map<String, dynamic> rawResource) {
    return null; // Practitioners don't have categories
  }

  @override
  String? extractDate(Map<String, dynamic> rawResource) {
    return null; // Practitioners don't have dates typically
  }

  @override
  List<String> buildAdditionalInfo(Map<String, dynamic> rawResource) {
    final additionalInfo = <String>[];

    // Gender
    final gender = rawResource['gender'] as String?;
    if (gender != null) {
      additionalInfo.add('Gender: $gender');
    }

    // Birth date
    final birthDate = rawResource['birthDate'] as String?;
    if (birthDate != null) {
      additionalInfo.add('Birth: $birthDate');
    }

    // Qualifications
    final qualification = rawResource['qualification'] as List<dynamic>?;
    if (qualification != null && qualification.isNotEmpty) {
      final qual = qualification.first as Map<String, dynamic>;
      final code = qual['code'] as Map<String, dynamic>?;
      final qualText =
          BaseDisplayFactory.extractCodeableConceptTextNullable(code);
      if (qualText != null) {
        additionalInfo.add('Qualification: $qualText');
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

    return additionalInfo;
  }
}
