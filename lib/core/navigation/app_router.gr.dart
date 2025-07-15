// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    EncounterDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EncounterDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EncounterDetailPage(
          key: args.key,
          encounter: args.encounter,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          pageController: args.pageController,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingPage(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyPolicyPage(),
      );
    },
    RecordsRoute.name: (routeData) {
      final args = routeData.argsAs<RecordsRouteArgs>(
          orElse: () => const RecordsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecordsPage(
          key: args.key,
          filter: args.filter,
        ),
      );
    },
    ResourceDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ResourceDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResourceDetailPage(
          key: args.key,
          resource: args.resource,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    SyncRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SyncPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EncounterDetailPage]
class EncounterDetailRoute extends PageRouteInfo<EncounterDetailRouteArgs> {
  EncounterDetailRoute({
    Key? key,
    required EncounterDisplayModel encounter,
    List<PageRouteInfo>? children,
  }) : super(
          EncounterDetailRoute.name,
          args: EncounterDetailRouteArgs(
            key: key,
            encounter: encounter,
          ),
          initialChildren: children,
        );

  static const String name = 'EncounterDetailRoute';

  static const PageInfo<EncounterDetailRouteArgs> page =
      PageInfo<EncounterDetailRouteArgs>(name);
}

class EncounterDetailRouteArgs {
  const EncounterDetailRouteArgs({
    this.key,
    required this.encounter,
  });

  final Key? key;

  final EncounterDisplayModel encounter;

  @override
  String toString() {
    return 'EncounterDetailRouteArgs{key: $key, encounter: $encounter}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    required PageController pageController,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            pageController: pageController,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.pageController,
  });

  final Key? key;

  final PageController pageController;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, pageController: $pageController}';
  }
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyPolicyPage]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecordsPage]
class RecordsRoute extends PageRouteInfo<RecordsRouteArgs> {
  RecordsRoute({
    Key? key,
    String? filter,
    List<PageRouteInfo>? children,
  }) : super(
          RecordsRoute.name,
          args: RecordsRouteArgs(
            key: key,
            filter: filter,
          ),
          initialChildren: children,
        );

  static const String name = 'RecordsRoute';

  static const PageInfo<RecordsRouteArgs> page =
      PageInfo<RecordsRouteArgs>(name);
}

class RecordsRouteArgs {
  const RecordsRouteArgs({
    this.key,
    this.filter,
  });

  final Key? key;

  final String? filter;

  @override
  String toString() {
    return 'RecordsRouteArgs{key: $key, filter: $filter}';
  }
}

/// generated route for
/// [ResourceDetailPage]
class ResourceDetailRoute extends PageRouteInfo<ResourceDetailRouteArgs> {
  ResourceDetailRoute({
    Key? key,
    required FhirResourceDisplayModel resource,
    List<PageRouteInfo>? children,
  }) : super(
          ResourceDetailRoute.name,
          args: ResourceDetailRouteArgs(
            key: key,
            resource: resource,
          ),
          initialChildren: children,
        );

  static const String name = 'ResourceDetailRoute';

  static const PageInfo<ResourceDetailRouteArgs> page =
      PageInfo<ResourceDetailRouteArgs>(name);
}

class ResourceDetailRouteArgs {
  const ResourceDetailRouteArgs({
    this.key,
    required this.resource,
  });

  final Key? key;

  final FhirResourceDisplayModel resource;

  @override
  String toString() {
    return 'ResourceDetailRouteArgs{key: $key, resource: $resource}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
