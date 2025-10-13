import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

part 'record_notes_event.dart';
part 'record_notes_state.dart';
part 'record_notes_bloc.freezed.dart';

@injectable
class RecordNotesBloc extends Bloc<RecordNotesEvent, RecordNotesState> {
  RecordNotesBloc(this._recordsRepository) : super(const RecordNotesState()) {
    on<RecordNotesInitialised>(_onRecordNotesInitialised);
    on<RecordNotesInputInitialised>(_onRecordNotesInputInitialised);
    on<RecordNotesInputCanceled>(_onRecordNotesInputCanceled);
    on<RecordNotesInputDone>(_onRecordNotesInputDone);
    on<RecordNotesNoteDeleted>(_onRecordNotesNoteDeleted);
  }

  final RecordsRepository _recordsRepository;

  _onRecordNotesInitialised(
    RecordNotesInitialised event,
    Emitter<RecordNotesState> emit,
  ) async {
    emit(state.copyWith(status: const RecordNotesStatus.loading()));

    try {
      // Extract subjectId from the raw FHIR resource
      final subjectId = _extractSubjectId(event.resource);

      // Get or create patient record for this resource
      final patientRecord = await _recordsRepository.getOrCreatePatientRecord(
        patientId: subjectId ?? '',
        sourceId: event.resource.sourceId,
      );

      // Get notes for this patient record
      List<RecordNote> notes =
          await _recordsRepository.getRecordNotes(patientRecord.id);

      emit(state.copyWith(
          notes: notes,
          resource: event.resource,
          status: const RecordNotesStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: RecordNotesStatus.error(e)));
    }
  }

  _onRecordNotesInputInitialised(
    RecordNotesInputInitialised event,
    Emitter<RecordNotesState> emit,
  ) {
    emit(state.copyWith(
      status: const RecordNotesStatus.input(),
      editNote: event.editNote,
    ));
  }

  _onRecordNotesInputCanceled(
    RecordNotesInputCanceled event,
    Emitter<RecordNotesState> emit,
  ) {
    emit(state.copyWith(
      status: const RecordNotesStatus.success(),
      editNote: null,
    ));
  }

  _onRecordNotesInputDone(
    RecordNotesInputDone event,
    Emitter<RecordNotesState> emit,
  ) async {
    emit(state.copyWith(status: const RecordNotesStatus.loading()));

    try {
      if (state.editNote != null) {
        await _recordsRepository
            .editRecordNote(state.editNote!.copyWith(content: event.content));
      } else {
        // Extract subjectId from the raw FHIR resource
        final subjectId = _extractSubjectId(state.resource);

        // Get or create patient record for this resource
        final patientRecord = await _recordsRepository.getOrCreatePatientRecord(
          patientId: subjectId ?? '',
          sourceId: state.resource.sourceId,
        );

        // Add note to patient record
        await _recordsRepository.addRecordNote(
          patientRecordId: patientRecord.id,
          content: event.content,
        );
      }

      emit(state.copyWith(
        status: const RecordNotesStatus.success(),
        editNote: null,
        selectedNoteId: null,
        notes: [],
      ));

      add(RecordNotesInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordNotesStatus.error(e)));
    }
  }

  _onRecordNotesNoteDeleted(
    RecordNotesNoteDeleted event,
    Emitter<RecordNotesState> emit,
  ) async {
    emit(state.copyWith(status: const RecordNotesStatus.loading()));

    try {
      await _recordsRepository.deleteRecordNote(event.note);

      emit(state.copyWith(
        status: const RecordNotesStatus.success(),
        notes: [],
      ));

      add(RecordNotesInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordNotesStatus.error(e)));
    }
  }

  /// Extract subjectId from FHIR resource
  String? _extractSubjectId(IFhirResource resource) {
    final rawResource = resource.rawResource;

    // For Patient resources, subjectId is their own resourceId
    if (resource.fhirType == FhirType.Patient) {
      return resource.resourceId;
    }

    // For other resources, extract from subject reference
    if (rawResource['subject']?['reference'] != null) {
      final reference = rawResource['subject']['reference'] as String;
      // Extract ID from reference like "Patient/123" or "urn:uuid:abc123"
      if (reference.startsWith('Patient/')) {
        return reference.substring(8);
      } else if (reference.startsWith('urn:uuid:')) {
        return reference.substring(9);
      }
    }

    return null;
  }
}
