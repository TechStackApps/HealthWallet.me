import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/features/fhir_mapper/presentation/bloc/fhir_mapper_bloc.dart';

@RoutePage()
class FhirMapperPage extends AutoRouter implements AutoRouteWrapper {
  const FhirMapperPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FhirMapperBloc>(),
      child: this,
    );
  }
}
 