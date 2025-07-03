import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/services/local/local_database_service.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  // Hive.registerAdapter(ItemDtoAdapter());
  Hive.registerAdapter(UserDtoAdapter());

  // Initialize injectable
  await getIt.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<LocalDatabaseService<UserDto>> userDatabaseService() async {
    final service = LocalDatabaseService<UserDto>('userBox');
    await service.openBox();
    return service;
  }

  // @preResolve
  // Future<LocalDatabaseService<ItemDto>> itemDatabaseService() async {
  //   final service = LocalDatabaseService<ItemDto>('itemBox');
  //   await service.openBox();
  //   return service;
  // }
}
