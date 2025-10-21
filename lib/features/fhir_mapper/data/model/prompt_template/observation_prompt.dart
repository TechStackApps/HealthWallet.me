import 'package:health_wallet/features/fhir_mapper/data/model/prompt_template/prompt_template.dart';

class ObservationPrompt extends PromptTemplate {
  @override
  String get promptResourceType => "clinical observations like vital signs or lab results";

  @override
  String get promptJsonStructure => '''
    {
      "resourceType": "Observation",
      "observationName": "string",
      "value": "string",
      "unit": "string"
    }
  ''';

  @override
  String get promptExample => '''
    Medical Text: "Vitals taken at 10:30. Heart rate is 78 bpm. Body temperature is 98.6 F. Patient reports mild headache."

    [ { "observationName": "Heart rate", "value": 78, "unit": "bpm" }, { "observationName": "Body temperature", "value": 98.6, "unit": "F" } ]
  ''';
}
