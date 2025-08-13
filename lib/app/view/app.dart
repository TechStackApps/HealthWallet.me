import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/l10n.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart';
import 'package:health_wallet/core/theme/theme.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:provider/provider.dart';
import 'package:health_wallet/features/sync/domain/services/sync_token_service.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';
import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = getIt.get<AppRouter>();
    final _appRouteObserver = getIt.get<AppRouteObserver>();
    final _syncTokenService = getIt<SyncTokenService>();

    // final _authRepository = getIt.get<AuthenticationRepository>();

    return Provider<SyncTokenService>(
      create: (_) => _syncTokenService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  getIt<UserBloc>()..add(const UserInitialised())),
          BlocProvider(
            create: (context) => getIt<SyncBloc>(),
          ),
          BlocProvider(create: (context) => getIt<RecordsBloc>()),
          BlocProvider(
            create: (context) => HomeBloc(
              getIt<GetSourcesUseCase>(),
              HomeLocalDataSourceImpl(),
              getIt<RecordsRepository>(),
            )..add(const HomeInitialised()),
          ),
        ],
        child: BlocListener<SyncBloc, SyncState>(
          listener: (context, state) {
            // Refresh only when a sync actually finished
            if (state.syncStatus == SyncStatus.connected &&
                state.lastSyncTime != null) {
              context.read<HomeBloc>().add(const HomeInitialised());
              context.read<UserBloc>().add(const UserDataUpdatedFromSync());
              // Refresh records timeline after new data is cached
              context.read<RecordsBloc>().add(const RecordsInitialised());
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Health Wallet',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode:
                    state.user.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                routerConfig: _appRouter.config(
                  navigatorObservers: () => [_appRouteObserver],
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) => child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
