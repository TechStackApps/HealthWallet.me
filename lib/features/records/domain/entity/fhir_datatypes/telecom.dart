import 'package:freezed_annotation/freezed_annotation.dart';

part 'telecom.freezed.dart';
part 'telecom.g.dart';

@freezed
class Telecom with _$Telecom {
  factory Telecom({
    String? system,
    String? value,
    String? use,
  }) = _Telecom;

  factory Telecom.fromJson(Map<String, dynamic> json) =>
      _$TelecomFromJson(json);
}
