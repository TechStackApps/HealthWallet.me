import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';
import '../data_source/local/user_local_data_source.dart';
import '../data_source/network/user_network_data_source.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;
  final UserNetworkDataSource _networkDataSource;

  UserRepositoryImpl(this._localDataSource, this._networkDataSource);

  @override
  Future<User> getCurrentUser({bool fetchFromNetwork = false}) async {
    UserDto? userDto;
    if (!fetchFromNetwork) {
      userDto = _localDataSource.getCachedUser();
    }

    if (userDto != null) return userDto.toEntity();

    userDto = await _networkDataSource.fetchUser();
    await _localDataSource.cacheUser(userDto);

    return userDto.toEntity();
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      final updatedUser =
          await _networkDataSource.updateUser(UserDto.fromEntity(user));
      await _localDataSource.cacheUser(updatedUser);
      return updatedUser.toEntity();
    } catch (e) {
      await _localDataSource.cacheUser(UserDto.fromEntity(user));
      rethrow;
    }
  }

  @override
  Future<void> deleteUser() async {
    await _networkDataSource.deleteUser();
    await _localDataSource.clearUser();
  }

  @override
  Future<void> clearUser() async {
    await _localDataSource.clearUser();
  }

  @override
  Future<void> updateProfilePicture(String photoUrl) async {
    await _networkDataSource.updateProfilePicture(photoUrl);
    final user = await getCurrentUser();

    await _localDataSource.cacheUser(UserDto.fromEntity(user));
  }

  @override
  Future<void> verifyEmail() async {
    await _networkDataSource.verifyEmail();
    final user = await getCurrentUser();

    await _localDataSource.cacheUser(UserDto.fromEntity(user));
  }
}
