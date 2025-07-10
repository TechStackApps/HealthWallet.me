import 'package:freezed_annotation/freezed_annotation.dart';

part 'coverage.freezed.dart';
part 'coverage.g.dart';

@freezed
class Coverage with _$Coverage {
  factory Coverage() = _Coverage;

  factory Coverage.fromJson(Map<String, dynamic> json) =>
      _$CoverageFromJson(json);
}
