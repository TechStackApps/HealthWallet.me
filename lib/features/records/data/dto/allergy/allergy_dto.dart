import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';

part 'allergy_dto.freezed.dart';
part 'allergy_dto.g.dart';

@freezed
class AllergyDto with _$AllergyDto {
  const factory AllergyDto({
    required String dateRecorded,
    required String allergyType,
    required String allergicTo,
    String? reaction,
    required String onset,
    String? resolutionAge,
  }) = _AllergyDto;

  factory AllergyDto.fromDomain(Allergy allergy) {
    return AllergyDto(
      dateRecorded: allergy.dateRecorded,
      allergyType: allergy.allergyType,
      allergicTo: allergy.allergicTo,
      reaction: allergy.reaction,
      onset: allergy.onset,
      resolutionAge: allergy.resolutionAge,
    );
  }

  factory AllergyDto.fromJson(Map<String, dynamic> json) =>
      _$AllergyDtoFromJson(json);
}

extension AllergyDtoX on AllergyDto {
  Allergy toDomain() {
    return Allergy(
      dateRecorded: dateRecorded,
      allergyType: allergyType,
      allergicTo: allergicTo,
      reaction: reaction,
      onset: onset,
      resolutionAge: resolutionAge,
    );
  }
}
