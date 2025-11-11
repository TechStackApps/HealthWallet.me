import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';

part 'processing_session.freezed.dart';

@freezed
class ProcessingSession with _$ProcessingSession {
  const factory ProcessingSession({
    @Default('') String id,
    @Default([]) List<String> scannedImages,
    @Default([]) List<String> importedFiles,
    @Default([]) List<String> importedImages,
    @Default(0) double progress,
    @Default([]) List<MappingResource> resources,
    @Default(ProcessingStatus.notStarted) ProcessingStatus status,
  }) = _ProcessingSession;
}

enum ProcessingStatus { notStarted, processing, draft }
