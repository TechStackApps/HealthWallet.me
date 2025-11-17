import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/l10n/l10n.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/navigation/observers/order_route_observer.dart';
import 'package:health_wallet/core/theme/theme.dart';
import 'package:health_wallet/core/utils/patient_source_utils.dart';
import 'package:health_wallet/core/widgets/share_intent_handler.dart';
import 'package:health_wallet/core/widgets/deep_link_handler.dart';

import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/home/data/data_source/local/home_local_data_source.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/features/sync/domain/use_case/get_sources_use_case.dart';

class App extends StatelessWidget {
  App({super.key});

  static final GlobalKey<NavigatorState> dialogNavigatorKey = GlobalKey<NavigatorState>();  // ADD THIS

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();
    final routeObserver = getIt<AppRouteObserver>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UserBloc>()..add(const UserInitialised())),
        BlocProvider(create: (_) => getIt<SyncBloc>()..add(const SyncInitialised())),
        BlocProvider(create: (_) => getIt<RecordsBloc>()),
        BlocProvider(create: (_) => getIt<ScanBloc>()..add(const ScanInitialised())),
        BlocProvider(
          create: (_) => HomeBloc(
            getIt<GetSourcesUseCase>(),
            HomeLocalDataSourceImpl(),
            getIt<RecordsRepository>(),
            getIt<SyncRepository>(),
          )..add(const HomeInitialised()),
        ),
        BlocProvider(create: (_) => getIt<PatientBloc>()..add(const PatientInitialised())),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SyncBloc, SyncState>(
            listener: (context, state) {
              _handleSyncBlocStateChange(context, state);
            },
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'HealthWallet.me',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.user.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routerConfig: router.config(
                navigatorObservers: () => [routeObserver],
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                return Navigator( 
                  key: App.dialogNavigatorKey,
                  onGenerateRoute: (_) => MaterialPageRoute(
                    builder: (_) => DeepLinkHandler(
                      navigatorKey: App.dialogNavigatorKey,
                      child: ShareIntentHandler(child: child!),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void _handleSyncBlocStateChange(BuildContext context, SyncState state) {
  if (state.hasDemoData) {
    context.read<HomeBloc>().add(const HomeSourceChanged('demo_data'));
  }

  if (state.hasSyncedData) {
    PatientSourceUtils.reloadHomeWithPatientFilter(context, 'All');
  }

  if (state.shouldShowTutorial) {
    context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
  }

  if (state.syncStatus == SyncStatus.synced) {
    context.read<RecordsBloc>().add(const RecordsInitialised());
    context.read<UserBloc>().add(const UserDataUpdatedFromSync());
    context.read<PatientBloc>().add(const PatientPatientsLoaded());

    Future.delayed(const Duration(milliseconds: 300), () {
      if (context.mounted) {
        final homeState = context.read<HomeBloc>().state;
        final currentSource = homeState.selectedSource.isEmpty ? 'All' : homeState.selectedSource;
        PatientSourceUtils.reloadHomeWithPatientFilter(context, currentSource);
      }
    });
  }
}
