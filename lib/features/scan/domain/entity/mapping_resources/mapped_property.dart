import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_similarity/string_similarity.dart';

part 'mapped_property.freezed.dart';

@freezed
class MappedProperty with _$MappedProperty {
  const MappedProperty._();

  const factory MappedProperty({
    @Default('') String value,
    @Default(0.0) double confidenceLevel,
  }) = _MappedProperty;

  List<String> _createOverlappingChunks(String text, int chunkLength) {
    if (text.length <= chunkLength) {
      return [text];
    }

    final chunks = <String>[];
    for (int i = 0; i <= text.length - chunkLength; i++) {
      chunks.add(text.substring(i, i + chunkLength));
    }
    return chunks;
  }

  /// Does fuzzy matching between the [value] and overlapping chunks of [inputText]
  /// to see if the [inputText] contains a substring similar to [value]
  MappedProperty calculateConfidence(String inputText) {
    if (value.isEmpty) {
      return copyWith(confidenceLevel: 0.0);
    }

    final chunkLength = (value.length * 1.2).ceil();
    if (inputText.length < chunkLength) {
      final bestMatch = StringSimilarity.findBestMatch(value, [inputText]);
      return copyWith(confidenceLevel: bestMatch.bestMatch.rating ?? 0.0);
    }

    final List<String> textChunks =
        _createOverlappingChunks(inputText, chunkLength);

    final bestMatch = StringSimilarity.findBestMatch(value, textChunks);
    final rating = bestMatch.bestMatch.rating ?? 0.0;

    return copyWith(confidenceLevel: rating);
  }

  bool get isValid => confidenceLevel > 0.6;
}
