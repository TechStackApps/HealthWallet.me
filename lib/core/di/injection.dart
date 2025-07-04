import 'package:get_it/get_it.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';
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
  Hive.registerAdapter(FhirResourceAdapter());

  // Initialize injectable
  await getIt.init();
}
