import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/services/local/local_database_service.dart';
import 'package:health_wallet/core/services/sync_service.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  LocalDatabaseService<UserDto> get userLocalDatabaseService =>
      LocalDatabaseService<UserDto>('user_box');

  @lazySingleton
  SyncService syncService(Dio dio, SharedPreferences prefs) =>
      SyncService(dio, prefs);
}
