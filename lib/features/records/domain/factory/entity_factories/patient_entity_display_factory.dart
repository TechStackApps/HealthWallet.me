import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';

/// Display factory for Patient entities
/// Handles display model creation for Patient resources
class PatientEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Patient';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final patient = entity as Patient;

    // ✅ KEEP: Resource-specific logic for human name extraction
    if (patient.name?.isNotEmpty == true) {
      final name = patient.name!.first;
      final humanName = FhirFieldExtractor.extractHumanName(name);
      if (humanName != null) return humanName;
    }

    return 'Unknown Patient';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final patient = entity as Patient;

    // ✅ USE: Common pattern for date extraction
    final birthDate = FhirFieldExtractor.extractDate(patient.birthDate);
    final gender = FhirFieldExtractor.extractStatus(patient.gender);

    return FhirFieldExtractor.joinNonNull([birthDate, gender], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final patient = entity as Patient;
    // ✅ KEEP: Resource-specific logic for active status
    final active = patient.active;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Patients don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final patient = entity as Patient;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(patient.birthDate);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final patient = entity as Patient;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(patient.active);
    if (status != null) {
      additionalInfo.add('Status: ${status == 'true' ? 'Active' : 'Inactive'}');
    }

    // ✅ KEEP: Resource-specific logic for birth date
    if (patient.birthDate != null) {
      additionalInfo.add('Birth: ${patient.birthDate}');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final maritalText =
        FhirFieldExtractor.extractCodeableConceptText(patient.maritalStatus);
    if (maritalText != null) {
      additionalInfo.add('Marital: $maritalText');
    }

    // ✅ KEEP: Resource-specific logic for multiple addresses
    if (patient.address?.isNotEmpty == true) {
      for (int i = 0; i < patient.address!.length; i++) {
        final addr = patient.address![i];
        final addressText = FhirFieldExtractor.formatAddress(addr);
        if (addressText != null) {
          additionalInfo.add('Address ${i + 1}: $addressText');
        }
      }
    }

    // ✅ KEEP: Resource-specific logic for telecom
    if (patient.telecom?.isNotEmpty == true) {
      for (final contact in patient.telecom!) {
        final value = contact.value?.toString();
        final system = contact.system?.toString();
        if (value != null && system != null) {
          additionalInfo.add('$system: $value');
        }
      }
    }

    return additionalInfo;
  }

  /// Extract patient ID from identifiers or fallback to resource ID
  String extractPatientId(Patient patient) {
    if (patient.identifier?.isNotEmpty == true) {
      for (final identifier in patient.identifier!) {
        if (identifier.value != null) {
          return identifier.value!.toString();
        }
      }
    }
    return patient.id;
  }

  /// Calculate patient age from birth date
  String extractPatientAge(Patient patient) {
    if (patient.birthDate == null) return 'N/A';

    try {
      final birthDateStr = patient.birthDate!.toString();
      if (birthDateStr.isEmpty) return 'N/A';

      final birthDate = DateTime.parse(birthDateStr);
      final now = DateTime.now();
      final age = now.year - birthDate.year;

      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        return '${age - 1} years';
      }

      return '$age years';
    } catch (e) {
      return 'N/A';
    }
  }

  /// Extract patient gender
  String extractPatientGender(Patient patient) {
    final gender = FhirFieldExtractor.extractStatus(patient.gender);
    return gender ?? 'N/A';
  }

  /// Extract blood type (placeholder - would need observation query)
  String extractBloodType(Patient patient) {
    // Blood type is typically stored in Observation resources with specific LOINC codes
    // Common blood type LOINC codes:
    // - 883-9: ABO group [Type] in Blood
    // - 884-7: Rh [Type] in Blood
    // - 34532-2: ABO and Rh group [Type] in Blood

    // This would require querying observations through the repository layer
    // For now, return placeholder
    return 'N/A';
  }
}
