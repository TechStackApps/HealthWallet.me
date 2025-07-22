import 'package:health_wallet/features/user/data/data_source/local/user_local_data_source.dart';
import 'package:health_wallet/features/user/data/data_source/remote/user_remote_data_source.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;
  final SharedPreferences _sharedPreferences;

  UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._sharedPreferences,
  );

  static const _biometricAuthKey = 'isBiometricAuthEnabled';

  @override
  Future<User> getCurrentUser({bool fetchFromNetwork = false}) async {
    if (fetchFromNetwork) {
      final remoteUser = await _remoteDataSource.fetchUser();
      await _localDataSource.saveUser(remoteUser);
      return remoteUser;
    }
    final localUser = await _localDataSource.getUser();
    if (localUser == null) {
      throw Exception('User not found in local storage');
    }
    return localUser;
  }

  @override
  Future<void> updateUser(User user) async {
    await _remoteDataSource.updateUser(user);
    await _localDataSource.saveUser(user);
  }

  @override
  Future<void> deleteUser() async {
    await _remoteDataSource.deleteUser();
    await _localDataSource.clearUser();
  }

  @override
  Future<void> clearUser() async {
    await _localDataSource.clearUser();
  }

  @override
  Future<void> updateProfilePicture(String photoUrl) async {
    await _remoteDataSource.updateProfilePicture(photoUrl);
    final user = await getCurrentUser();
    final updatedUser = user.copyWith(photoUrl: photoUrl);
    await _localDataSource.saveUser(updatedUser);
  }

  @override
  Future<void> verifyEmail() async {
    await _remoteDataSource.verifyEmail();
  }

  @override
  Future<bool> isBiometricAuthEnabled() async {
    return _sharedPreferences.getBool(_biometricAuthKey) ?? false;
  }

  @override
  Future<void> saveBiometricAuth(bool isEnabled) async {
    await _sharedPreferences.setBool(_biometricAuthKey, isEnabled);
  }
}
