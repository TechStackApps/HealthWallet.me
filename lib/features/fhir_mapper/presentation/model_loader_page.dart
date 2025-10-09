import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/fhir_mapper/presentation/bloc/fhir_mapper_bloc.dart';

@RoutePage()
class ModelLoaderPage extends StatefulWidget {
  const ModelLoaderPage({super.key});

  @override
  State<ModelLoaderPage> createState() => _ModelLoaderPageState();
}

class _ModelLoaderPageState extends State<ModelLoaderPage> {
  @override
  void initState() {
    context.read<FhirMapperBloc>().add(const FhirMapperInitialised());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FhirMapperState state = context.watch<FhirMapperBloc>().state;
    log("state: ${state.downloadProgress}");
    log("state: ${state.status}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Model loader"),
      ),
      body: Center(
          child: switch (state.status) {
        FhirMapperStatus.modelLoading ||
        FhirMapperStatus.modelAbsent =>
          state.status == FhirMapperStatus.modelLoading &&
                  state.downloadProgress == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Model absent"),
                    ElevatedButton(
                        onPressed: () => context
                            .read<FhirMapperBloc>()
                            .add(const FhirMapperModelDownloadInitiated()),
                        child: const Text("Download model")),
                    if (state.downloadProgress != null)
                      LinearProgressIndicator(
                        value: state.downloadProgress! / 100,
                      )
                  ],
                ),
        FhirMapperStatus.modelLoaded => Column(
            children: [
              const Text("Model loaded"),
              ElevatedButton(
                onPressed: () => context.router.push(const TextInputRoute()),
                child: const Text("Use model"),
              )
            ],
          ),
        _ => const SizedBox(),
      }),
    );
  }
}
