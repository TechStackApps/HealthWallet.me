import 'package:health_wallet/features/user/domain/entity/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUser({bool fetchFromNetwork = false});
  Future<void> updateUser(User user);
  Future<void> deleteUser();
  Future<void> clearUser();
  Future<void> updateProfilePicture(String photoUrl);
  Future<void> verifyEmail();
  Future<void> saveBiometricAuth(bool isEnabled);
  Future<bool> isBiometricAuthEnabled();
}
