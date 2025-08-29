import 'package:health_wallet/features/user/domain/entity/user.dart';

abstract class UserRemoteDataSource {
  Future<User> fetchUser();
  Future<void> updateUser(User user);
  Future<void> deleteUser();
  Future<void> updateProfilePicture(String photoUrl);
  Future<void> verifyEmail();
}

class MockUserRemoteDataSource implements UserRemoteDataSource {
  @override
  Future<User> fetchUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return const User(
      id: '123',
      name: 'John Doe',
      email: 'john.doe@example.com',
      photoUrl: 'https://example.com/avatar.jpg',
      isEmailVerified: true,
      isDarkMode: false,
    );
  }

  @override
  Future<void> updateUser(User user) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> deleteUser() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateProfilePicture(String photoUrl) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyEmail() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
