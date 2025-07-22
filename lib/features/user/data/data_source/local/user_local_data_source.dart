import 'package:health_wallet/features/user/domain/entity/user.dart';

abstract class UserLocalDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> clearUser();
}

class MockUserLocalDataSource implements UserLocalDataSource {
  User? _user;

  @override
  Future<User?> getUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _user;
  }

  @override
  Future<void> saveUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _user = user;
  }

  @override
  Future<void> clearUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _user = null;
  }
}
