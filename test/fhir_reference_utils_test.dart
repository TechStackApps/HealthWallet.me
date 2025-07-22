import 'package:flutter_test/flutter_test.dart';
import 'package:health_wallet/core/utils/fhir_reference_utils.dart';

void main() {
  group('FhirReferenceUtils.extractReferenceId', () {
    test('returns null for null input', () {
      expect(FhirReferenceUtils.extractReferenceId(null), isNull);
    });

    test('extracts id from urn:uuid: format', () {
      expect(
        FhirReferenceUtils.extractReferenceId('urn:uuid:1234-5678'),
        '1234-5678',
      );
    });

    test('extracts id from ResourceType/id format', () {
      expect(
        FhirReferenceUtils.extractReferenceId('Patient/abc-123'),
        'abc-123',
      );
      expect(
        FhirReferenceUtils.extractReferenceId('Observation/xyz-789'),
        'xyz-789',
      );
    });

    test('returns id for plain id', () {
      expect(FhirReferenceUtils.extractReferenceId('plain-id'), 'plain-id');
    });
  });
}
