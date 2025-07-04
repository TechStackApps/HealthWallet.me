import 'package:health_wallet/core/data/mock_data.dart';
import 'package:health_wallet/features/records/data/data_source/local/records_local_data_source.dart';
import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';
import 'package:health_wallet/features/records/domain/entity/condition/condition.dart';
import 'package:health_wallet/features/records/domain/entity/immunization/immunization.dart';
import 'package:health_wallet/features/records/domain/entity/lab_result/lab_result.dart';
import 'package:health_wallet/features/records/domain/entity/medication/medication.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';
import 'package:health_wallet/features/records/domain/entity/records_entry.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final RecordsLocalDataSource _localDataSource;

  RecordsRepositoryImpl(this._localDataSource);

  @override
  Future<List<RecordsEntry>> getTimelineEntries({String? filter}) async {
    final dtos = await _localDataSource.getTimelineEntries(filter: filter);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<RecordsEntry>> getTimelineEntriesForAllergy(
    Allergy allergy,
  ) async {
    final dtos = await _localDataSource.getTimelineEntriesForAllergy(allergy);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<Allergy>> getAllergies() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return MockData.allergies;
  }

  @override
  Future<List<Medication>> getMedications() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return MockData.medications;
  }

  @override
  Future<List<Condition>> getConditions() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Immunization>> getImmunizations() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<LabResult>> getLabResults() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Procedure>> getProcedures() async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}
