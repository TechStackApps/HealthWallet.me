import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/fhir_mapper/presentation/bloc/fhir_mapper_bloc.dart';

@RoutePage()
class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  State<TextInputPage> createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FhirMapperState state = context.watch<FhirMapperBloc>().state;
    return BlocListener<FhirMapperBloc, FhirMapperState>(
      listener: (context, state) {
        if (state.status == FhirMapperStatus.success) {
          context.router.push(const MappingResultRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Text input", style: AppTextStyle.titleMedium),
        ),
        body: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 30,
                  style: AppTextStyle.labelLarge,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: context.colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.isDarkMode
                          ? Colors.white
                          : context.colorScheme.onPrimary,
                      disabledBackgroundColor:
                          context.colorScheme.primary.withValues(alpha: 0.3),
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8)),
                    ),
                    onPressed: state.status != FhirMapperStatus.mappingLoading
                        ? () => context
                            .read<FhirMapperBloc>()
                            .add(FhirMappingInitiated(_controller.text))
                        : null,
                    child: state.status != FhirMapperStatus.mappingLoading
                        ? const Text("Map text to FHIR")
                        : const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
