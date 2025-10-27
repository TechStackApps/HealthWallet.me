import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/scan/presentation/pages/fhir_mapper/widgets/resources_form.dart';
import 'package:health_wallet/features/scan/presentation/widgets/encounter_form_widget.dart';
import 'package:health_wallet/features/scan/presentation/widgets/patient_source_info_widget.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_preview_card.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_summary_card.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

import 'bloc/fhir_mapper_bloc.dart';

@RoutePage()
class FhirMapperPage extends StatelessWidget {
  const FhirMapperPage({
    this.scannedImages = const [],
    this.importedImages = const [],
    this.importedPdfs = const [],
    super.key,
  });

  final List<String> scannedImages;
  final List<String> importedImages;
  final List<String> importedPdfs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<FhirMapperBloc>()
        ..add(
          FhirMapperImagesPrepared(
            scannedImages: scannedImages,
            importedImages: importedImages,
            importedPdfs: importedPdfs,
          ),
        ),
      child: const _FhirMapperView(),
    );
  }
}

class _FhirMapperView extends StatefulWidget {
  const _FhirMapperView();

  @override
  State<_FhirMapperView> createState() => _FhirMapperViewState();
}

class _FhirMapperViewState extends State<_FhirMapperView> {
  final _formKey = GlobalKey<FormState>();
  final _encounterNameController = TextEditingController();
  final _pageController = PageController();

  @override
  void dispose() {
    _encounterNameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _createEncounter() {
    if (!_formKey.currentState!.validate()) return;

    context.read<FhirMapperBloc>().add(
          FhirMapperEncounterCreationInitiated(
            encounterName: _encounterNameController.text.trim(),
            homeState: context.read<HomeBloc>().state,
            patientState: context.read<PatientBloc>().state,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Process to FHIR', style: AppTextStyle.titleMedium),
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<FhirMapperBloc, FhirMapperState>(
        listener: (context, state) {
          if (state.status == FhirMapperStatus.success) {
            Navigator.of(context).pop(true);
          }
          if (state.status == FhirMapperStatus.failure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(
                  'An error occurred: ${state.errorMessage}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FhirMapperStatus.savingResources) {
            return _buildLoadingIndicator('Adding to Wallet...');
          }
          if (state.status == FhirMapperStatus.convertingPdfs) {
            return _buildLoadingIndicator('Converting PDFs for preview...');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(Insets.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScanSummaryCard(
                  scannedCount: state.scannedImages.length,
                  importedImagesCount: state.importedImages.length,
                  importedPdfsCount: state.importedPdfs.length,
                  totalPagesForOcr: state.allImagePathsForOCR.length,
                ),
                const SizedBox(height: Insets.normal),
                if (state.allImagePathsForOCR.isNotEmpty)
                  ScanPreviewCard(
                    imagePaths: state.allImagePathsForOCR,
                    pageController: _pageController,
                  ),
                const SizedBox(height: Insets.large),
                _buildMappingSection(state),
                if (state.status == FhirMapperStatus.editingResources)
                  ResourcesForm(
                    resources: state.resources,
                    onPropertyChanged: (index, propertyKey, newValue) => context
                        .read<FhirMapperBloc>()
                        .add(FhirMapperResourceChanged(
                          index: index,
                          propertyKey: propertyKey,
                          newValue: newValue,
                        )),
                  ),
                const SizedBox(height: Insets.large),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }

  Widget _buildMappingSection(FhirMapperState state) {
    if (state.status == FhirMapperStatus.mappingReady) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () =>
              context.read<FhirMapperBloc>().add(const FhirMappingInitiated()),
          icon: const Icon(Icons.text_fields),
          label: const Text(
            'Process pages',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    }

    if (state.status == FhirMapperStatus.mapping) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Insets.normal),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withValues(alpha: 0.3),
          border: Border.all(
            color: context.colorScheme.primary.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Processing to FHIR...',
              style: AppTextStyle.bodyMedium.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // Widget _buildEncounterFormSection(FhirMapperState state) {
  //   if (!state.ocrCompleted) {
  //     return const SizedBox.shrink();
  //   }

  //   return Column(
  //     children: [
  //       const PatientSourceInfoWidget(),
  //       const SizedBox(height: Insets.normal),
  //       EncounterFormWidget(
  //         formKey: _formKey,
  //         encounterNameController: _encounterNameController,
  //         onSubmit: _createEncounter,
  //       ),
  //     ],
  //   );
  // }
}
