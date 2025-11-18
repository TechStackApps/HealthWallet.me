import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/widgets/delete_confirmation_dialog.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_patient.dart';
import 'package:health_wallet/features/scan/domain/entity/processing_session.dart';
import 'package:health_wallet/features/scan/presentation/bloc/scan_bloc.dart';
import 'package:health_wallet/features/scan/presentation/pages/fhir_mapper/widgets/patient_dropdown.dart';
import 'package:health_wallet/features/scan/presentation/pages/fhir_mapper/widgets/resources_form.dart';
import 'package:health_wallet/features/scan/presentation/widgets/custom_progress_indicator.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_preview_card.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_summary_card.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

@RoutePage()
class FhirMapperPage extends StatefulWidget {
  const FhirMapperPage({
    required this.sessionId,
    super.key,
  });

  final String sessionId;

  @override
  State<FhirMapperPage> createState() => _FhirMapperPageState();
}

class _FhirMapperPageState extends State<FhirMapperPage> {
  final _formKey = GlobalKey<FormState>();
  final _encounterNameController = TextEditingController();
  final _pageController = PageController();

  @override
  void initState() {
    context.read<ScanBloc>().add(
          ScanSessionActivated(
              sessionId: widget.sessionId,
              currentPatients: context
                  .read<PatientBloc>()
                  .state
                  .patientGroups
                  .values
                  .toList()),
        );
    super.initState();
  }

  @override
  void dispose() {
    _encounterNameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _saveResources() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ScanBloc>().add(
        ScanResourceCreationInitiated(sessionId: widget.sessionId));
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
      body: BlocConsumer<ScanBloc, ScanState>(
        listener: (context, state) {
          final activeSession = state.sessions
              .firstWhereOrNull((s) => s.id == widget.sessionId);
          if (activeSession == null) return;

          if (state.status == const ScanStatus.success()) {
            context
                .read<ScanBloc>()
                .add(ScanSessionCleared(session: activeSession));
            context.router.replaceAll([const DashboardRoute()]);
          }
          if (state.status is Failure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(
                  'An error occurred: ${(state.status as Failure).error}',
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
          final activeSession = state.sessions
              .firstWhereOrNull((s) => s.id == widget.sessionId);
          if (activeSession == null) {
            return const Center(child: Text("Session not found!"));
          }

          if (state.status == const ScanStatus.convertingPdfs()) {
            return _buildLoadingIndicator('Converting PDFs for preview...');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(Insets.normal),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ScanSummaryCard(
                totalPagesForOcr: state.allImagePathsForOCR.length,
              ),
              const SizedBox(height: Insets.normal),
              if (state.allImagePathsForOCR.isNotEmpty)
                ScanPreviewCard(
                  imagePaths: state.allImagePathsForOCR,
                  pageController: _pageController,
                ),
              const SizedBox(height: Insets.large),
              _buildMappingSection(state, activeSession),
              _buildResourcesSection(state, activeSession),
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

  Widget _buildMappingSection(ScanState state, ProcessingSession activeSession) {
    if (state.status == const ScanStatus.mappingReady()) {
      final canProcess = !state.sessions
          .any((session) => session.status == ProcessingStatus.processing);

      if (!canProcess) {
        return const Text("Only one processing session can run at a time!");
      }

      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => context
              .read<ScanBloc>()
              .add(ScanMappingInitiated(sessionId: widget.sessionId)),
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

    if (state.status == const ScanStatus.mapping()) {
      return CustomProgressIndicator(
        progress: activeSession.progress,
        text: "Processing pages to FHIR resources...",
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildResourcesSection(
      ScanState state, ProcessingSession activeSession) {
    if (state.status != const ScanStatus.editingResources()) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!activeSession.resources
            .any((resource) => resource is MappingPatient)) ...[
          const Text("Select the patient", style: AppTextStyle.bodyLarge),
          const SizedBox(height: 8),
          PatientDropdown(
            options: state.currentPatients,
            selectedPatient: state.selectedPatient!,
            onChanged: (patientGroup) {
              if (patientGroup != null) {
                context.read<ScanBloc>().add(ScanPatientSelected(
                    sessionId: widget.sessionId, patientGroup: patientGroup));
              }
            },
          ),
          const SizedBox(height: 24),
        ],
        ResourcesForm(
          formKey: _formKey,
          resources: activeSession.resources,
          onPropertyChanged: (index, propertyKey, newValue) =>
              context.read<ScanBloc>().add(
                    ScanResourceChanged(
                      sessionId: widget.sessionId,
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
            onPressed: state.status == const ScanStatus.savingResources()
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
        context.read<ScanBloc>().add(
            ScanResourceRemoved(sessionId: widget.sessionId, index: index));
      },
    );
  }
}
