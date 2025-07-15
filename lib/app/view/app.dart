import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/l10n.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart';
import 'package:health_wallet/core/theme/theme.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_filter_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = getIt.get<AppRouter>();
    final _appRouteObserver = getIt.get<AppRouteObserver>();

    // final _authRepository = getIt.get<AuthenticationRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<HomeBloc>()..add(const HomeEvent.initialised())),
        BlocProvider(
            create: (context) => getIt<UserProfileBloc>()
              ..add(const UserProfileEvent.initialised())),
        BlocProvider(create: (context) => getIt<SyncBloc>()),
        BlocProvider(
            create: (context) => getIt<RecordsFilterBloc>()
              ..add(const RecordsFilterEvent.load())),
      ],
      child: BlocListener<SyncBloc, SyncState>(
        listener: (context, state) {
          state.status.whenOrNull(
            success: () {
              context.read<HomeBloc>().add(const HomeEvent.initialised());
            },
          );
        },
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }
}
