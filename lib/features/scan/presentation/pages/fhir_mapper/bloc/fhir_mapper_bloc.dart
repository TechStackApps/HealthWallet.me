import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:health_wallet/features/scan/presentation/helpers/fhir_encounter_helper.dart';
import 'package:health_wallet/features/scan/presentation/helpers/ocr_processing_helper.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/services/wallet_patient_service.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as sync_source;
import 'package:injectable/injectable.dart';

part 'fhir_mapper_event.dart';
part 'fhir_mapper_state.dart';
part 'fhir_mapper_bloc.freezed.dart';

@Injectable()
class FhirMapperBloc extends Bloc<FhirMapperEvent, FhirMapperState> {
  FhirMapperBloc(
    this._repository,
    this._ocrProcessingHelper,
    this._walletPatientService,
    this._syncRepository,
    this._documentReferenceService,
  ) : super(const FhirMapperState()) {
    on<FhirMapperImagesPrepared>(_onFhirMapperImagesPrepared);
    on<FhirMappingInitiated>(_onFhirMappingInitiated);
    on<FhirMapperResourceChanged>(_onFhirMapperResourceChanged);
    // on<FhirMapperEncounterCreationInitiated>(
    //     _onFhirMapperEncounterCreationInitiated);
  }

  final ScanRepository _repository;
  final OcrProcessingHelper _ocrProcessingHelper;
  final WalletPatientService _walletPatientService;
  final SyncRepository _syncRepository;
  final DocumentReferenceService _documentReferenceService;

  Future<void> _onFhirMapperImagesPrepared(
    FhirMapperImagesPrepared event,
    Emitter<FhirMapperState> emit,
  ) async {
    emit(state.copyWith(status: FhirMapperStatus.convertingPdfs));

    try {
      final allImages = await _ocrProcessingHelper.prepareAllImages(
        scannedImages: event.scannedImages,
        importedImages: event.importedImages,
        importedPdfs: event.importedPdfs,
      );

      emit(state.copyWith(
        allImagePathsForOCR: allImages,
        status: FhirMapperStatus.mappingReady,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FhirMapperStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onFhirMappingInitiated(
    FhirMappingInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FhirMapperStatus.mapping));

      final medicalText = await _ocrProcessingHelper
          .processOcrForImages(state.allImagePathsForOCR);

      List<MappingResource> resources =
          await _repository.mapResources(medicalText);

      emit(state.copyWith(
        status: FhirMapperStatus.editingResources,
        resources: resources,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: FhirMapperStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onFhirMapperResourceChanged(
    FhirMapperResourceChanged event,
    Emitter<FhirMapperState> emit,
  ) {
    MappingResource updatedResource = state.resources[event.index].copyWithMap({
      event.propertyKey: event.newValue,
    });

    final newResources = [...state.resources];
    newResources[event.index] = updatedResource;

    emit(state.copyWith(resources: newResources));
  }

  // Future<void> _onFhirMapperEncounterCreationInitiated(
  //   FhirMapperEncounterCreationInitiated event,
  //   Emitter<FhirMapperState> emit,
  // ) async {
  //   emit(state.copyWith(status: FhirMapperStatus.savingResources));

  //   try {
  //     final encounterName = event.encounterName;
  //     final homeState = event.homeState;
  //     final patientState = event.patientState;

  //     // Placeholder for patient logic
  //     final selectedPatientId = patientState.selectedPatientId;
  //     final selectedPatient = patientState.patients.isNotEmpty
  //         ? patientState.patients.firstWhere(
  //             (p) => p.id == selectedPatientId,
  //             orElse: () => patientState.patients.first,
  //           )
  //         : null;

  //     final patient = selectedPatient ?? homeState.patient;
  //     final patientId = patient?.resourceId ?? 'patient-default';
  //     final patientName = patient?.displayTitle ?? 'Unknown Patient';

  //     String effectiveSourceId;

  //     if (selectedPatientId != null) {
  //       final patientGroup = patientState.patientGroups[selectedPatientId];
  //       final hasWritableWalletSource = patientGroup?.sourceIds.any((sourceId) {
  //             final source = homeState.sources.firstWhere(
  //               (s) => s.id == sourceId,
  //               orElse: () => const sync_source.Source(
  //                   id: '', platformName: null, logo: null, labelSource: null),
  //             );
  //             return source.platformType == 'wallet';
  //           }) ??
  //           false;

  //       if (!hasWritableWalletSource) {
  //         final walletSource =
  //             await _walletPatientService.createWalletSourceForPatient(
  //           selectedPatientId,
  //           patientName,
  //         );

  //         await _syncRepository.cacheSources([walletSource]);

  //         await _duplicatePatientToWalletSource(
  //             selectedPatient, walletSource.id);

  //         effectiveSourceId = walletSource.id;
  //       } else {
  //         final walletSourceId = patientGroup!.sourceIds.firstWhere(
  //           (sourceId) {
  //             final source = homeState.sources.firstWhere(
  //               (s) => s.id == sourceId,
  //               orElse: () => const sync_source.Source(
  //                   id: '', platformName: null, logo: null, labelSource: null),
  //             );
  //             return source.platformType == 'wallet';
  //           },
  //         );
  //         effectiveSourceId = walletSourceId;
  //       }
  //     } else {
  //       final walletSource =
  //           await _walletPatientService.createWalletSourceForPatient(
  //         patientId,
  //         patientName,
  //       );

  //       await _syncRepository.cacheSources([walletSource]);

  //       effectiveSourceId = walletSource.id;
  //     }

  //     final encounterId = FhirEncounterHelper.generateEncounterId();

  //     final fhirEncounter = FhirEncounterHelper.createEncounter(
  //       encounterId: encounterId,
  //       patientId: patientId,
  //       title: encounterName,
  //       patientName: patient?.displayTitle ?? 'Unknown Patient',
  //     );

  //     await FhirEncounterHelper.saveToDatabase(
  //       fhirEncounter: fhirEncounter,
  //       sourceId: effectiveSourceId,
  //       title: encounterName,
  //     );

  //     await _documentReferenceService.saveGroupedDocumentsAsFhirRecords(
  //       scannedImages: state.scannedImages,
  //       importedImages: state.importedImages,
  //       importedPdfs: state.importedPdfs,
  //       patientId: patientId,
  //       encounterId: encounterId,
  //       sourceId: effectiveSourceId,
  //       title: encounterName,
  //     );

  //     emit(state.copyWith(status: FhirMapperStatus.success));
  //   } catch (e) {
  //     logger.e('Error creating encounter: $e');
  //     emit(state.copyWith(
  //       status: FhirMapperStatus.failure,
  //       errorMessage: e.toString(),
  //     ));
  //   }
  // }

  // Future<void> _duplicatePatientToWalletSource(
  //     Patient? patient, String walletSourceId) async {
  //   if (patient == null) return;

  //   try {
  //     final database = GetIt.instance.get<AppDatabase>();

  //     final walletPatient = patient.copyWith(
  //       id: patient.id,
  //       sourceId: walletSourceId,
  //     );

  //     final patientJson = patient.rawResource;
  //     final resourceId = patient.id;

  //     final dto = FhirResourceCompanion.insert(
  //       id: '${walletSourceId}_$resourceId',
  //       sourceId: drift.Value(walletSourceId),
  //       resourceId: drift.Value(resourceId),
  //       resourceType: const drift.Value('Patient'),
  //       title: drift.Value(walletPatient.displayTitle),
  //       date: drift.Value(walletPatient.birthDate?.valueString != null
  //           ? DateTime.tryParse(walletPatient.birthDate!.valueString!) ??
  //               DateTime.now()
  //           : DateTime.now()),
  //       resourceRaw: jsonEncode(patientJson),
  //       encounterId: const drift.Value.absent(),
  //       subjectId: drift.Value(resourceId),
  //     );

  //     await database.into(database.fhirResource).insertOnConflictUpdate(dto);
  //   } catch (e) {
  //     logger.e('❌ Failed to duplicate Patient to wallet source: $e');
  //   }
  // }
}
