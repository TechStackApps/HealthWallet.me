import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_encounter.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:health_wallet/features/scan/domain/services/document_reference_service.dart';
import 'package:health_wallet/features/scan/presentation/helpers/ocr_processing_helper.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/services/wallet_patient_service.dart';
import 'package:health_wallet/features/user/domain/services/patient_deduplication_service.dart';
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
    on<FhirMapperResourceRemoved>(_onFhirMapperResourceRemoved);
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
        scannedImages: event.scannedImages,
        importedImages: event.importedImages,
        importedPdfs: event.importedPdfs,
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

      if (medicalText.trim().isEmpty) {
        emit(state.copyWith(
          status: FhirMapperStatus.failure,
          errorMessage:
              'No text could be extracted from the selected files. Please try different pages or higher-quality scans.',
        ));
        return;
      }

      final stream = _repository.mapResources(medicalText);

      await for (final (resources, progress) in stream) {
        if (emit.isDone) return;
        emit(state.copyWith(
          resources: [...state.resources, ...resources],
          mappingProgress: progress,
        ));
      }

      List<MappingPatient> patients =
          state.resources.whereType<MappingPatient>().toList();
      if (patients.length > 1) {
        List<MappingResource> noPatients = [...state.resources]
          ..removeWhere((resource) => resource is MappingPatient);

        emit(state.copyWith(resources: [patients.first, ...noPatients]));
      }

      if (!state.resources.any((resource) => resource is MappingEncounter)) {
        emit(state.copyWith(
          resources: [
            ...state.resources,
            MappingEncounter(id: const Uuid().v4())
          ],
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

  void _onFhirMapperResourceRemoved(
    FhirMapperResourceRemoved event,
    Emitter<FhirMapperState> emit,
  ) {
    final newResources = [...state.resources];
    newResources.removeAt(event.index);

    emit(state.copyWith(resources: newResources));
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

    String encounterId;
    String subjectId;
    String sourceId;

    try {
      MappingPatient? mappingPatient =
          state.resources.whereType<MappingPatient>().firstOrNull;

      MappingEncounter mappingEncounter =
          state.resources.whereType<MappingEncounter>().first;
      encounterId = mappingEncounter.id;

      if (mappingPatient != null) {
        subjectId = mappingPatient.id;
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

          writableSourceId = walletSource.id;
        }

        sourceId = writableSourceId;
        subjectId = selectedPatientGroup.patientId;
      }

      List<IFhirResource> fhirResources = state.resources
          .map((resource) => resource.toFhirResource(
                sourceId: sourceId,
                subjectId: (resource is MappingPatient) ? '' : subjectId,
                encounterId: (resource is MappingEncounter) ? '' : encounterId,
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
    } catch (e) {
      emit(state.copyWith(
        status: FhirMapperStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
