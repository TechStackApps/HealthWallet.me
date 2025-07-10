import 'package:freezed_annotation/freezed_annotation.dart';

part 'composition.freezed.dart';
part 'composition.g.dart';

@freezed
class Composition with _$Composition {
  factory Composition({
    String? id,
    String? title,
    @JsonKey(name: 'relates_to') String? relatesTo,
  }) = _Composition;

  factory Composition.fromJson(Map<String, dynamic> json) =>
      _$CompositionFromJson(json);
}
