import 'package:freezed_annotation/freezed_annotation.dart';

part 'source.freezed.dart';
part 'source.g.dart';

/// Domain Source entity for sync operations
@freezed
class Source with _$Source {
  const factory Source({
    required String id,
    String? name,
    String? logo,
    String? labelSource,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}

/// Type alias to distinguish domain Source from database Source
typedef DomainSource = Source;
