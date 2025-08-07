import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';

class UserMapper {
  static User fromDto(UserDto dto) {
    return User(
      id: dto.id,
      name: dto.fullName ?? dto.username,
      email: dto.email ?? '',
      photoUrl: dto.picture ?? '',
      isEmailVerified: true, // Default to true for now
      isDarkMode: false, // This will be handled locally
    );
  }

  static UserDto toDto(User user) {
    return UserDto(
      id: user.id,
      username: user.name.split(' ').first, // Use first name as username
      fullName: user.name,
      email: user.email,
      picture: user.photoUrl,
      role: 'user', // Default role
    );
  }
}
