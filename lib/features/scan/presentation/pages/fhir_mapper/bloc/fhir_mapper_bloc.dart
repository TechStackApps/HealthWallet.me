import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_encounter.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/processing_session.dart';
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

@LazySingleton()
class FhirMapperBloc extends Bloc<FhirMapperEvent, FhirMapperState> {
  FhirMapperBloc(
    this._repository,
    this._ocrProcessingHelper,
    this._walletPatientService,
    this._syncRepository,
    this._documentReferenceService,
  ) : super(const FhirMapperState()) {
    on<FhirMapperInitialized>(_onFhirMapperInitialized);
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

  Future<void> _onFhirMapperInitialized(
    FhirMapperInitialized event,
    Emitter<FhirMapperState> emit,
  ) async {
    try {
      if (event.session.status == ProcessingStatus.pending) {
        emit(state.copyWith(status: FhirMapperStatus.convertingPdfs));

        final allImages = await _ocrProcessingHelper.prepareAllImages(
          filePaths: event.session.filePaths,
        );

        emit(state.copyWith(
          allImagePathsForOCR: allImages,
          status: FhirMapperStatus.mappingReady,
        ));
      } else if (event.session.status == ProcessingStatus.processing) {
        emit(state.copyWith(status: FhirMapperStatus.mapping));
      } else if (event.session.status == ProcessingStatus.draft) {
        emit(state.copyWith(status: FhirMapperStatus.editingResources));
      }

      emit(state.copyWith(
        session: event.session,
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

  void _updateSession(
    Emitter<FhirMapperState> emit, {
    double? progress,
    ProcessingStatus? status,
    List<MappingResource>? resources,
    bool updateDb = false,
  }) {
    final activeSession = state.session;

    final updatedSession = activeSession.copyWith(
      progress: progress ?? activeSession.progress,
      status: status ?? activeSession.status,
      resources: resources ?? activeSession.resources,
    );

    if (updateDb) {
      _repository.editProcessingSession(updatedSession);
    }

    emit(state.copyWith(
      session: updatedSession,
    ));
  }

  void _onFhirMappingInitiated(
    FhirMappingInitiated event,
    Emitter<FhirMapperState> emit,
  ) async {
    try {
      _updateSession(emit, status: ProcessingStatus.processing);
      emit(state.copyWith(status: FhirMapperStatus.mapping));

      final medicalText = await _ocrProcessingHelper
          .processOcrForImages(state.allImagePathsForOCR);

      final stream = _repository.mapResources(medicalText);

      await for (final (resources, progress) in stream) {
        if (emit.isDone) return;
        _updateSession(
          emit,
          resources: [...state.session.resources, ...resources],
          progress: progress,
        );
      }

      List<MappingPatient> patients =
          state.session.resources.whereType<MappingPatient>().toList();
      if (patients.length > 1) {
        List<MappingResource> noPatients = [...state.session.resources]
          ..removeWhere((resource) => resource is MappingPatient);

        _updateSession(emit, resources: [patients.first, ...noPatients]);
      }

      if (!state.session.resources
          .any((resource) => resource is MappingEncounter)) {
        _updateSession(emit, resources: [
          ...state.session.resources,
          MappingEncounter(id: const Uuid().v4())
        ]);
      }

      _updateSession(emit, status: ProcessingStatus.draft);
      emit(state.copyWith(status: FhirMapperStatus.editingResources));
    } on Exception catch (e) {
      _updateSession(emit, status: ProcessingStatus.pending);
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
    final newResources = [...state.session.resources];
    newResources.removeAt(event.index);

    _updateSession(emit, resources: newResources, updateDb: true);
  }

  void _onFhirMapperResourceChanged(
    FhirMapperResourceChanged event,
    Emitter<FhirMapperState> emit,
  ) {
    MappingResource updatedResource =
        state.session.resources[event.index].copyWithMap({
      event.propertyKey: event.newValue,
    });

    final newResources = [...state.session.resources];
    newResources[event.index] = updatedResource;

    _updateSession(emit, resources: newResources, updateDb: true);
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
          state.session.resources.whereType<MappingPatient>().firstOrNull;

      MappingEncounter mappingEncounter =
          state.session.resources.whereType<MappingEncounter>().first;
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

      List<IFhirResource> fhirResources = state.session.resources
          .map((resource) => resource.toFhirResource(
                sourceId: sourceId,
                subjectId: (resource is MappingPatient) ? '' : subjectId,
                encounterId: (resource is MappingEncounter) ? '' : encounterId,
              ))
          .toList();

      await _syncRepository.saveResources(fhirResources);

      await _documentReferenceService.saveGroupedDocumentsAsFhirRecords(
        filePaths: state.session.filePaths,
        patientId: subjectId,
        encounterId: encounterId,
        sourceId: sourceId,
        title: state.session.resources
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
