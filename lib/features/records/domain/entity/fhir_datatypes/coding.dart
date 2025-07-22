import 'package:freezed_annotation/freezed_annotation.dart';

part 'coding.freezed.dart';
part 'coding.g.dart';

@freezed
class Coding with _$Coding {
  factory Coding({
    String? system,
    String? code,
    String? display,
  }) = _Coding;

  factory Coding.fromJson(Map<String, dynamic> json) => _$CodingFromJson(json);
}
