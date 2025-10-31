import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/widgets/delete_confirmation_dialog.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/scan/presentation/pages/fhir_mapper/widgets/patient_dropdown.dart';
import 'package:health_wallet/features/scan/presentation/pages/fhir_mapper/widgets/resources_form.dart';
import 'package:health_wallet/features/scan/presentation/widgets/custom_progress_indicator.dart';
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
              currentPatients: context
                  .read<PatientBloc>()
                  .state
                  .patientGroups
                  .values
                  .toList()),
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

  void _saveResources() {
    if (!_formKey.currentState!.validate()) return;

    context
        .read<FhirMapperBloc>()
        .add(const FhirMapperResourceCreationInitiated());
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
            context.router.push(const DashboardRoute());
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
          if (state.status == FhirMapperStatus.convertingPdfs) {
            return _buildLoadingIndicator('Converting PDFs for preview...');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(Insets.normal),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              _buildResourcesSection(state),
              const SizedBox(height: Insets.large),
            ]),
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
      return CustomProgressIndicator(
        progress: state.mappingProgress,
        text: "Processing pages to FHIR resources...",
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildResourcesSection(FhirMapperState state) {
    if (state.status != FhirMapperStatus.editingResources) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!state.resources.any((resource) => resource is MappingPatient)) ...[
          const Text("Select the patient", style: AppTextStyle.bodyLarge),
          const SizedBox(height: 8),
          PatientDropdown(
            options: state.currentPatients,
            selectedPatient: state.selectedPatient!,
            onChanged: (patientGroup) {
              if (patientGroup != null) {
                context
                    .read<FhirMapperBloc>()
                    .add(FhirMapperPatientSelected(patientGroup: patientGroup));
              }
            },
          ),
          const SizedBox(height: 24),
        ],
        ResourcesForm(
          formKey: _formKey,
          resources: state.resources,
          onPropertyChanged: (index, propertyKey, newValue) =>
              context.read<FhirMapperBloc>().add(
                    FhirMapperResourceChanged(
                      index: index,
                      propertyKey: propertyKey,
                      newValue: newValue,
                    ),
                  ),
          onResourceRemoved: _showDeleteConfirmationDialog,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.isDarkMode
                  ? Colors.white
                  : context.colorScheme.onPrimary,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8)),
            ),
            onPressed: state.status == FhirMapperStatus.savingResources
                ? null
                : _saveResources,
            child: const Text("Add resources"),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    DeleteConfirmationDialog.show(
      context: context,
      title: 'Are you sure you want to delete this resource?',
      onConfirm: () {
        context
            .read<FhirMapperBloc>()
            .add(FhirMapperResourceRemoved(index: index));
      },
    );
  }
}
