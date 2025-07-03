import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart';
import 'package:health_wallet/core/theme/theme.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = getIt.get<AppRouter>();
    final _appRouteObserver = getIt.get<AppRouteObserver>();
    final _userProfileBloc = getIt.get<UserProfileBloc>()
      ..add(UserProfileInitialised());

    // final _authRepository = getIt.get<AuthenticationRepository>();

    return MultiBlocProvider(
      providers: [BlocProvider.value(value: _userProfileBloc)],
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        bloc: _userProfileBloc,
        builder: (context, userProfileState) {
          final isDarkMode = userProfileState.user.isDarkMode;
          return MaterialApp.router(
            title: 'Health Wallet',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _appRouter.config(
              navigatorObservers: () => [_appRouteObserver],
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => child!,
          );
        },
      ),
    );
  }
}
