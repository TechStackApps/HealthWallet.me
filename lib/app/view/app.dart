import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/l10n.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart';
import 'package:health_wallet/core/theme/theme.dart';

import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/sync/domain/services/token_service.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    final routeObserver = getIt<AppRouteObserver>();
    final tokenService = getIt<TokenService>();

    return Provider<TokenService>(
      create: (_) => tokenService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => getIt<UserBloc>()..add(const UserInitialised())),
          BlocProvider(create: (_) => getIt<SyncBloc>()),
          BlocProvider(create: (_) => getIt<RecordsBloc>()),
          BlocProvider(
            create: (_) => HomeBloc(
              getIt<GetSourcesUseCase>(),
              HomeLocalDataSourceImpl(),
              getIt<RecordsRepository>(),
            )..add(const HomeInitialised()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<RecordsBloc, RecordsState>(
              listenWhen: (prev, curr) =>
                  !prev.hasDemoData &&
                  curr.hasDemoData &&
                  !curr.isLoadingDemoData,
              listener: (context, state) {
                print('🏠 Demo data available, refreshing HomeBloc...');
                context.read<HomeBloc>()
                  ..add(const HomeSourceChanged('demo'))
                  ..add(const HomeDataLoaded());
                context.read<UserBloc>().add(const UserPatientsLoaded());
              },
            ),
            BlocListener<SyncBloc, SyncState>(
              listenWhen: (prev, curr) =>
                  (curr.syncStatus == SyncStatus.connected ||
                      curr.syncStatus == SyncStatus.synced) &&
                  prev.syncStatus != curr.syncStatus,
              listener: (context, state) {
                print(
                    '🔄 Sync data loaded, clearing demo + refreshing HomeBloc...');
                context.read<RecordsBloc>().add(const ClearDemoData());

                // Fix: Add longer delay and ensure proper sequencing
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    context.read<HomeBloc>()
                      ..add(const HomeSourceChanged('All'))
                      ..add(const HomeDataLoaded());
                    context
                        .read<UserBloc>()
                        .add(const UserDataUpdatedFromSync());
                    context.read<RecordsBloc>().add(const RecordsInitialised());

                    // Additional delay to ensure data is fully loaded before potential onboarding
                    Future.delayed(const Duration(milliseconds: 800), () {
                      if (context.mounted) {
                        print(
                            '🎯 Sync complete - HomeBloc should now trigger onboarding if needed');
                        // Trigger a refresh to ensure onboarding can be shown
                        context
                            .read<HomeBloc>()
                            .add(const HomeRefreshPreservingOrder());
                      }
                    });
                  }
                });
              },
            ),
          ],
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'HealthWallet.me',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode:
                    state.user.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                routerConfig:
                    router.config(navigatorObservers: () => [routeObserver]),
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
