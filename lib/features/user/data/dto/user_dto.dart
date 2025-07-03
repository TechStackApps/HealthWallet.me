import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:hive/hive.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
@HiveType(typeId: 1)
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    @HiveField(0) int? id,
    @HiveField(1) String? name,
    @HiveField(2) String? email,
    @HiveField(3) String? photoUrl,
    @HiveField(4) bool? isEmailVerified,
    @HiveField(5) bool? isDarkMode,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromEntity(User user) => UserDto(
        id: user.id,
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        isEmailVerified: user.isEmailVerified,
        isDarkMode: user.isDarkMode,
      );

  User toEntity() => User(
        id: id ?? 0,
        name: name ?? '',
        email: email ?? '',
        photoUrl: photoUrl ?? '',
        isEmailVerified: isEmailVerified ?? false,
        isDarkMode: isDarkMode ?? false,
      );
}
