import 'package:health_wallet/core/services/local/local_database_service.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';

abstract class UserLocalDataSource {
  UserDto? getCachedUser();
  Future<void> cacheUser(UserDto user);
  Future<void> clearUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._dbService);

  final LocalDatabaseService<UserDto> _dbService;

  @override
  UserDto? getCachedUser() {
    return _dbService.get('user');
  }

  @override
  Future<void> cacheUser(UserDto user) async {
    await _dbService.put('user', user);
  }

  @override
  Future<void> clearUser() async {
    await _dbService.delete('user');
  }
}
