import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/features/dashboard/presentation/dashboard_page.dart';
import 'package:health_wallet/features/scan/presentation/pages/scan_page.dart';
import 'package:health_wallet/features/scan/presentation/pages/process_to_fhir_page.dart';
import 'package:health_wallet/features/fhir_mapper/fhir_mapper.dart';
import 'package:health_wallet/features/home/presentation/home_page.dart';

import 'package:health_wallet/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:health_wallet/features/onboarding/presentation/pages/splash_page.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/pages/record_detail_page.dart';
import 'package:health_wallet/features/user/presentation/pages/privacy_policy_page.dart';
import 'package:health_wallet/features/records/presentation/pages/records_page.dart';
import 'package:health_wallet/features/sync/presentation/sync_page.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: RecordsRoute.page),
            AutoRoute(page: ScanRoute.page),
          ],
        ),
        AutoRoute(page: RecordDetailsRoute.page),
        AutoRoute(page: SyncRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(
          page: FhirMapperRoute.page,
          children: [
            AutoRoute(page: ModelLoaderRoute.page, path: ''),
            AutoRoute(page: TextInputRoute.page),
            AutoRoute(page: MappingResultRoute.page),
          ],
        )
      ];
}
