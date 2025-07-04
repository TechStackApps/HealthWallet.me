import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';
import 'package:health_wallet/features/records/domain/entity/condition/condition.dart';
import 'package:health_wallet/features/records/domain/entity/immunization/immunization.dart';
import 'package:health_wallet/features/records/domain/entity/lab_result/lab_result.dart';
import 'package:health_wallet/features/records/domain/entity/medication/medication.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';
import 'package:health_wallet/features/records/domain/entity/records_entry.dart';

abstract class RecordsRepository {
  Future<List<RecordsEntry>> getTimelineEntries({String? filter});
  Future<List<RecordsEntry>> getTimelineEntriesForAllergy(Allergy allergy);
  Future<List<Allergy>> getAllergies();
  Future<List<Medication>> getMedications();
  Future<List<Condition>> getConditions();
  Future<List<Immunization>> getImmunizations();
  Future<List<LabResult>> getLabResults();
  Future<List<Procedure>> getProcedures();
}
