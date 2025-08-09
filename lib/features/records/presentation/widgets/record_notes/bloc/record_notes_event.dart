part of 'record_notes_bloc.dart';

abstract class RecordNotesEvent {
  const RecordNotesEvent();
}

@freezed
class RecordNotesInitialised extends RecordNotesEvent
    with _$RecordNotesInitialised {
  const factory RecordNotesInitialised({
    required IFhirResource resource,
  }) = _RecordNotesInitialised;
}

@freezed
class RecordNotesInputInitialised extends RecordNotesEvent
    with _$RecordNotesInputInitialised {
  const factory RecordNotesInputInitialised({
    RecordNote? editNote,
  }) = _RecordNotesInputInitialised;
}

@freezed
class RecordNotesInputCanceled extends RecordNotesEvent
    with _$RecordNotesInputCanceled {
  const factory RecordNotesInputCanceled() = _RecordNotesInputCanceled;
}

@freezed
class RecordNotesInputDone extends RecordNotesEvent
    with _$RecordNotesInputDone {
  const factory RecordNotesInputDone({required String content}) =
      _RecordNotesInputDone;
}

@freezed
class RecordNotesSelectedNoteToggled extends RecordNotesEvent
    with _$RecordNotesSelectedNoteToggled {
  const factory RecordNotesSelectedNoteToggled({required RecordNote note}) =
      _RecordNotesSelectedNoteToggled;
}

@freezed
class RecordNotesNoteDeleted extends RecordNotesEvent
    with _$RecordNotesNoteDeleted {
  const factory RecordNotesNoteDeleted({required RecordNote note}) =
      _RecordNotesNoteDeleted;
}
