import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';

part 'processing_session.freezed.dart';

@freezed
class ProcessingSession
    with _$ProcessingSession
    implements Comparable<ProcessingSession> {
  const ProcessingSession._();

  const factory ProcessingSession({
    @Default('') String id,
    @Default([]) List<String> filePaths,
    @Default(0) double progress,
    @Default([]) List<MappingResource> resources,
    @Default(ProcessingStatus.notStarted) ProcessingStatus status,
    @Default(ProcessingOrigin.scan) ProcessingOrigin origin,
    DateTime? createdAt,
  }) = _ProcessingSession;

  @override
  int compareTo(ProcessingSession other) {
    if (status == ProcessingStatus.processing &&
        other.status != ProcessingStatus.processing) {
      return -1;
    }

    if (status != ProcessingStatus.processing &&
        other.status == ProcessingStatus.processing) {
      return 1;
    }

    return other.createdAt!.compareTo(createdAt!);
  }
}

enum ProcessingStatus {
  notStarted,
  processing,
  draft;

  @override
  String toString() {
    switch (this) {
      case ProcessingStatus.notStarted:
        return "Not started";
      case ProcessingStatus.processing:
        return "Processing";
      case ProcessingStatus.draft:
        return "Draft";
    }
  }
}

enum ProcessingOrigin {
  scan,
  import;

  @override
  String toString() {
    switch (this) {
      case ProcessingOrigin.scan:
        return "Scan";
      case ProcessingOrigin.import:
        return "Import";
    }
  }
}
