// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:health_wallet/core/di/register_module.dart' as _i982;
import 'package:health_wallet/core/navigation/app_router.dart' as _i410;
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart'
    as _i725;
import 'package:health_wallet/core/services/local/local_database_service.dart'
    as _i498;
import 'package:health_wallet/core/services/network/rest_api_service.dart'
    as _i346;
import 'package:health_wallet/features/authentication/data/data_source/local/authentication_local_data_source.dart'
    as _i57;
import 'package:health_wallet/features/authentication/data/data_source/network/authentication_network_data_source.dart'
    as _i34;
import 'package:health_wallet/features/authentication/data/repository/authentication_repository_impl.dart'
    as _i71;
import 'package:health_wallet/features/authentication/domain/repository/authentication_repository.dart'
    as _i59;
import 'package:health_wallet/features/authentication/presentation/login/bloc/login_bloc.dart'
    as _i484;
import 'package:health_wallet/features/authentication/presentation/signup/bloc/signup_bloc.dart'
    as _i621;
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart'
    as _i354;
import 'package:health_wallet/features/records/data/data_source/local/records_local_data_source.dart'
    as _i181;
import 'package:health_wallet/features/records/data/data_source/remote/records_remote_data_source.dart'
    as _i535;
import 'package:health_wallet/features/records/data/data_source/remote/records_remote_data_source_impl.dart'
    as _i390;
import 'package:health_wallet/features/records/data/repository/records_repository_impl.dart'
    as _i448;
import 'package:health_wallet/features/records/domain/repository/records_repository.dart'
    as _i704;
import 'package:health_wallet/features/records/domain/use_case/get_records_entries_use_case.dart'
    as _i964;
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart'
    as _i891;
import 'package:health_wallet/features/user/data/data_source/local/user_local_data_source.dart'
    as _i612;
import 'package:health_wallet/features/user/data/data_source/network/user_network_data_source.dart'
    as _i762;
import 'package:health_wallet/features/user/data/dto/user_dto.dart' as _i763;
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
    gh.lazySingleton<_i498.LocalDatabaseService<_i763.UserDto>>(
        () => registerModule.userLocalDatabaseService);
    gh.lazySingleton<_i410.AppRouter>(() => _i410.AppRouter());
    gh.lazySingleton<_i725.AppRouteObserver>(() => _i725.AppRouteObserver());
    gh.factory<_i535.RecordsRemoteDataSource>(
        () => _i390.RecordsRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i181.RecordsLocalDataSource>(
        () => _i181.RecordsLocalDataSourceImpl());
    gh.lazySingleton<_i346.RestApiService>(() => _i346.RestApiServiceImpl());
    gh.lazySingleton<_i57.AuthenticationLocalDataSource>(() =>
        _i57.AuthenticationLocalDataSourceDummy(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i34.AuthenticationNetworkDataSource>(
        () => _i34.AuthenticationNetworkDataSourceImpl());
    gh.lazySingleton<_i59.AuthenticationRepository>(
        () => _i71.AuthenticationRepositoryImpl(
              gh<_i34.AuthenticationNetworkDataSource>(),
              gh<_i57.AuthenticationLocalDataSource>(),
            ));
    gh.lazySingleton<_i612.UserLocalDataSource>(() =>
        _i612.UserLocalDataSourceImpl(
            gh<_i498.LocalDatabaseService<_i763.UserDto>>()));
    gh.factory<_i762.UserNetworkDataSource>(
        () => _i762.UserNetworkDataSourceImpl(gh<_i346.RestApiService>()));
    gh.factory<_i704.RecordsRepository>(() => _i448.RecordsRepositoryImpl(
          gh<_i535.RecordsRemoteDataSource>(),
          gh<_i181.RecordsLocalDataSource>(),
        ));
    gh.factory<_i354.HomeBloc>(
        () => _i354.HomeBloc(gh<_i704.RecordsRepository>()));
    gh.factory<_i621.SignupBloc>(
        () => _i621.SignupBloc(gh<_i59.AuthenticationRepository>()));
    gh.factory<_i484.LoginBloc>(
        () => _i484.LoginBloc(gh<_i59.AuthenticationRepository>()));
    gh.factory<_i504.UserRepository>(() => _i637.UserRepositoryImpl(
          gh<_i612.UserLocalDataSource>(),
          gh<_i762.UserNetworkDataSource>(),
        ));
    gh.factory<_i964.GetRecordsEntriesUseCase>(
        () => _i964.GetRecordsEntriesUseCase(gh<_i704.RecordsRepository>()));
    gh.factory<_i230.UserProfileBloc>(
        () => _i230.UserProfileBloc(gh<_i504.UserRepository>()));
    gh.factory<_i891.RecordsBloc>(
        () => _i891.RecordsBloc(gh<_i964.GetRecordsEntriesUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i982.RegisterModule {}
