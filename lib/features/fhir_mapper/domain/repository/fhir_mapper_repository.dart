abstract class FhirMapperRepository {
  Stream<double> downloadModel();

  Future<bool> checkModelExistence();
}
