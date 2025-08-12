part of 'record_attachments_bloc.dart';

@freezed
class RecordAttachmentsState with _$RecordAttachmentsState {
  const factory RecordAttachmentsState({
    @Default(RecordAttachmentsStatus.loading()) RecordAttachmentsStatus status,
    @Default(GeneralResource()) IFhirResource resource,
    @Default([]) List<RecordAttachment> attachments,
  }) = _RecordAttachmentsState;
}

@freezed
class RecordAttachmentsStatus with _$RecordAttachmentsStatus {
  const factory RecordAttachmentsStatus.loading() = _Loading;
  const factory RecordAttachmentsStatus.success() = _Success;
  const factory RecordAttachmentsStatus.error(Object? e) = _Error;
}
