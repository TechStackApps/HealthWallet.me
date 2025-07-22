import 'package:freezed_annotation/freezed_annotation.dart';

part 'binary.freezed.dart';
part 'binary.g.dart';

@freezed
class Binary with _$Binary {
  factory Binary({
    required String id,
    String? contentType,
    String? content,
    String? data,
  }) = _Binary;

  factory Binary.fromJson(Map<String, dynamic> json) => _$BinaryFromJson(json);
}
