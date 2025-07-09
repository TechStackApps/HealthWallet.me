// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:health_wallet/core/data/local/app_database.dart' as _i474;
import 'package:health_wallet/core/di/register_module.dart' as _i982;
import 'package:health_wallet/core/navigation/app_router.dart' as _i410;
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart'
    as _i725;
import 'package:health_wallet/core/services/local_auth_service.dart' as _i421;
import 'package:health_wallet/core/services/network/rest_api_service.dart'
    as _i346;
import 'package:health_wallet/core/services/sync_service.dart' as _i401;
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart'
    as _i354;
import 'package:health_wallet/features/records/domain/use_case/get_resources_use_case.dart'
    as _i44;
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart'
    as _i891;
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart'
    as _i526;
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart'
    as _i683;
import 'package:health_wallet/features/sync/data/repository/fhir_repository_impl.dart'
    as _i406;
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart'
    as _i925;
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart'
    as _i416;
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart'
    as _i267;
import 'package:health_wallet/features/user/data/data_source/local/user_local_data_source.dart'
    as _i612;
import 'package:health_wallet/features/user/data/data_source/remote/user_remote_data_source.dart'
    as _i547;
import 'package:health_wallet/features/user/data/repository/user_repository_impl.dart'
    as _i637;
import 'package:health_wallet/features/user/domain/repository/user_repository.dart'
    as _i504;
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart'
    as _i230;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i474.AppDatabase>(() => registerModule.appDatabase);
    gh.lazySingleton<_i547.UserRemoteDataSource>(
        () => registerModule.userRemoteDataSource);
    gh.lazySingleton<_i612.UserLocalDataSource>(
        () => registerModule.userLocalDataSource);
    gh.lazySingleton<_i421.LocalAuthService>(
        () => registerModule.localAuthService);
    gh.lazySingleton<_i410.AppRouter>(() => _i410.AppRouter());
    gh.lazySingleton<_i725.AppRouteObserver>(() => _i725.AppRouteObserver());
    gh.lazySingleton<_i346.RestApiService>(() => _i346.RestApiServiceImpl());
    gh.factory<_i683.FhirApiService>(
        () => _i683.FhirApiService(gh<_i361.Dio>()));
    gh.factory<_i526.FhirLocalDataSource>(() => _i526.FhirLocalDataSourceImpl(
          gh<_i474.AppDatabase>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i504.UserRepository>(() => _i637.UserRepositoryImpl(
          gh<_i547.UserRemoteDataSource>(),
          gh<_i612.UserLocalDataSource>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i925.FhirRepository>(() => _i406.FhirRepositoryImpl(
          gh<_i683.FhirApiService>(),
          gh<_i526.FhirLocalDataSource>(),
        ));
    gh.factory<_i230.UserProfileBloc>(
        () => _i230.UserProfileBloc(gh<_i504.UserRepository>()));
    gh.factory<_i267.SyncBloc>(() => _i267.SyncBloc(
          gh<_i925.FhirRepository>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i44.GetResourcesUseCase>(
        () => _i44.GetResourcesUseCase(gh<_i925.FhirRepository>()));
    gh.factory<_i416.GetSourcesUseCase>(
        () => _i416.GetSourcesUseCase(gh<_i925.FhirRepository>()));
    gh.lazySingleton<_i401.SyncService>(() => _i401.SyncService(
          gh<_i925.FhirRepository>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i891.RecordsBloc>(
        () => _i891.RecordsBloc(gh<_i44.GetResourcesUseCase>()));
    gh.factory<_i354.HomeBloc>(() => _i354.HomeBloc(
          gh<_i925.FhirRepository>(),
          gh<_i416.GetSourcesUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i982.RegisterModule {}
