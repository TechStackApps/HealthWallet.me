import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    on<RecordNotesSelectedNoteToggled>(_onRecordNotesSelectedNoteToggled);
    on<RecordNotesNoteDeleted>(_onRecordNotesNoteDeleted);
  }

  final RecordsRepository _recordsRepository;

  _onRecordNotesInitialised(
    RecordNotesInitialised event,
    Emitter<RecordNotesState> emit,
  ) async {
    emit(state.copyWith(status: const RecordNotesStatus.loading()));

    try {
      List<RecordNote> notes =
          await _recordsRepository.getRecordNotes(event.resource.id);

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
        await _recordsRepository.addRecordNote(
            resourceId: state.resource.id, content: event.content);
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

  _onRecordNotesSelectedNoteToggled(
    RecordNotesSelectedNoteToggled event,
    Emitter<RecordNotesState> emit,
  ) {
    int? selectedId;
    if (state.selectedNoteId != event.note.id) {
      selectedId = event.note.id;
    }
    log(selectedId.toString());
    emit(state.copyWith(selectedNoteId: selectedId));
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
}
