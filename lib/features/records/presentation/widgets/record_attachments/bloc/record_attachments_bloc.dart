import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'record_attachments_event.dart';
part 'record_attachments_state.dart';
part 'record_attachments_bloc.freezed.dart';

@injectable
class RecordAttachmentsBloc
    extends Bloc<RecordAttachmentsEvent, RecordAttachmentsState> {
  RecordAttachmentsBloc(this._recordsRepository)
      : super(const RecordAttachmentsState()) {
    on<RecordAttachmentsInitialised>(_onRecordAttachmentsInitialised);
    on<RecordAttachmentsFileAttached>(_onRecordAttachmentsFileAttached);
    on<RecordAttachmentsFileDeleted>(_onRecordAttachmentsFileDeleted);
  }

  final RecordsRepository _recordsRepository;

  _onRecordAttachmentsInitialised(
    RecordAttachmentsInitialised event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      List<RecordAttachment> attachments =
          await _recordsRepository.getRecordAttachments(event.resource.id);

      emit(state.copyWith(
          attachments: attachments,
          resource: event.resource,
          status: const RecordAttachmentsStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }

  _onRecordAttachmentsFileAttached(
    RecordAttachmentsFileAttached event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      Directory appDirectory = await getApplicationDocumentsDirectory();

      String originalFileName = basename(event.file.path);
      String newFilePath = join(appDirectory.path, originalFileName);

      await event.file.copy(newFilePath);

      await _recordsRepository.addRecordAttachment(
        resourceId: state.resource.id,
        filePath: newFilePath,
      );

      emit(state.copyWith(attachments: []));
      add(RecordAttachmentsInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }

  _onRecordAttachmentsFileDeleted(
    RecordAttachmentsFileDeleted event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      await _recordsRepository.deleteRecordAttachment(event.attachment);

      event.attachment.file.delete().ignore();

      add(RecordAttachmentsInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }


}
