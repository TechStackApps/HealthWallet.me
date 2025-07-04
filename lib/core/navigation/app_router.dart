import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/authentication/presentation/login/login_page.dart';
import 'package:health_wallet/features/authentication/presentation/signup/signup_page.dart';
import 'package:health_wallet/features/dashboard/presentation/dashboard_page.dart';
import 'package:health_wallet/features/home/presentation/home_page.dart';
import 'package:health_wallet/features/home/presentation/widgets/dummy_page.dart';
import 'package:health_wallet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:health_wallet/features/onboarding/presentation/pages/splash_page.dart';
import 'package:health_wallet/features/records/presentation/records_page.dart';
import 'package:health_wallet/features/sync/sync_page.dart';
import 'package:health_wallet/features/user/presentation/user_profile/user_profile_page.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_status_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';

part 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: RecordsRoute.page),
            AutoRoute(page: UserProfileRoute.page),
          ],
        ),
        AutoRoute(page: DummyRoute.page),
        AutoRoute(page: SyncRoute.page),
        // AutoRoute(page: ItemDetailRoute.page),
      ];
}
