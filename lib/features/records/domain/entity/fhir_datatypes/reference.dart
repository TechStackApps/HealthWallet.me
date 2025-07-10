import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
class Reference with _$Reference {
  factory Reference({
    String? reference,
    String? type,
    String? display,
  }) = _Reference;

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);
}

class ReferenceConverter
    implements JsonConverter<Reference, Map<String, dynamic>> {
  const ReferenceConverter();

  @override
  Reference fromJson(Map<String, dynamic> json) => Reference.fromJson(json);

  @override
  Map<String, dynamic> toJson(Reference object) => object.toJson();
}
