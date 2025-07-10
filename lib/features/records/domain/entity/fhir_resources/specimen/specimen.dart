import 'package:freezed_annotation/freezed_annotation.dart';

part 'specimen.freezed.dart';
part 'specimen.g.dart';

@freezed
class Specimen with _$Specimen {
  factory Specimen() = _Specimen;

  factory Specimen.fromJson(Map<String, dynamic> json) =>
      _$SpecimenFromJson(json);
}
