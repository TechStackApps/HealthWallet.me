import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_encounter.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:health_wallet/features/scan/presentation/helpers/fhir_encounter_helper.dart';
import 'package:health_wallet/features/scan/presentation/helpers/ocr_processing_helper.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/services/wallet_patient_service.dart';
import 'package:health_wallet/features/user/domain/services/patient_deduplication_service.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

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
    on<FhirMappingInitiated>(_onFhirMappingInitiated,
        transformer: restartable());
    on<FhirMapperResourceChanged>(_onFhirMapperResourceChanged);
    on<FhirMapperPatientSelected>(_onFhirMapperPatientSelected);
    on<FhirMapperResourceCreationInitiated>(
        _onFhirMapperResourceCreationInitiated);
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
        currentPatients: event.currentPatients,
        selectedPatient: event.currentPatients.first,
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

      final stream = _repository.mapResources(medicalText);

      await for (final (resources, progress) in stream) {
        if (emit.isDone) return;
        emit(state.copyWith(
          resources: [...state.resources, ...resources],
          mappingProgress: progress,
        ));
      }

      if (!state.resources.any((resource) => resource is MappingEncounter)) {
        emit(state.copyWith(
          resources: [...state.resources, const MappingEncounter()],
        ));
      }

      emit(state.copyWith(status: FhirMapperStatus.editingResources));
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
          status: FhirMapperStatus.failure,
          errorMessage: e.toString(),
        ));
      }
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

  void _onFhirMapperPatientSelected(
    FhirMapperPatientSelected event,
    Emitter<FhirMapperState> emit,
  ) {
    emit(state.copyWith(selectedPatient: event.patientGroup));
  }

  void _onFhirMapperResourceCreationInitiated(
    FhirMapperResourceCreationInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    emit(state.copyWith(status: FhirMapperStatus.savingResources));
    const uuid = Uuid();

    MappingPatient? mappingPatient =
        state.resources.whereType<MappingPatient>().firstOrNull;

    String encounterId = uuid.v4();
    String subjectId;
    String sourceId;

    if (mappingPatient != null) {
      subjectId = uuid.v4();
      final walletSource =
          await _walletPatientService.createWalletSourceForPatient(
        subjectId,
        "${mappingPatient.givenName.value} ${mappingPatient.familyName.value}",
      );

      await _syncRepository.cacheSources([walletSource]);

      sourceId = walletSource.id;
    } else {
      PatientGroup selectedPatientGroup = state.selectedPatient!;

      List<Source> sources = await _syncRepository.getSources();

      String? writableSourceId =
          selectedPatientGroup.sourceIds.firstWhereOrNull((sourceId) {
        final source = sources.firstWhere(
          (s) => s.id == sourceId,
          orElse: () => const Source(
              id: '', platformName: null, logo: null, labelSource: null),
        );
        return source.platformType == 'wallet';
      });

      if (writableSourceId == null) {
        final walletSource =
            await _walletPatientService.createWalletSourceForPatient(
          selectedPatientGroup.patientId,
          selectedPatientGroup.representativePatient.title,
        );

        await _syncRepository.cacheSources([walletSource]);

        await _syncRepository.saveResources([
          selectedPatientGroup.representativePatient
              .copyWith(sourceId: walletSource.id)
        ]);

        writableSourceId = walletSource.id;
      }

      sourceId = writableSourceId;
      subjectId = selectedPatientGroup.patientId;
    }

    List<IFhirResource> fhirResources = state.resources
        .map((resource) => resource.toFhirResource(
              sourceId: sourceId,
              subjectId: subjectId,
              encounterId: encounterId,
            ))
        .toList();

    await _syncRepository.saveResources(fhirResources);

    await _documentReferenceService.saveGroupedDocumentsAsFhirRecords(
      scannedImages: state.scannedImages,
      importedImages: state.importedImages,
      importedPdfs: state.importedPdfs,
      patientId: subjectId,
      encounterId: encounterId,
      sourceId: sourceId,
      title: state.resources
          .whereType<MappingEncounter>()
          .first
          .encounterType
          .value,
    );

    emit(state.copyWith(status: FhirMapperStatus.success));
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
