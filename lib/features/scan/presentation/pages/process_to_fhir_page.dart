// process_to_fhir_page.dart (REFACTORED)
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/scan/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/scan/presentation/helpers/fhir_encounter_helper.dart';
import 'package:health_wallet/features/scan/presentation/helpers/ocr_processing_helper.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_preview_card.dart';
import 'package:health_wallet/features/scan/presentation/widgets/scan_summary_card.dart';
import 'package:health_wallet/features/scan/presentation/widgets/empty_scan_warning.dart';
import 'package:health_wallet/features/scan/presentation/widgets/encounter_form_widget.dart';
import 'package:health_wallet/features/scan/presentation/widgets/ocr_widgets.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/scan/presentation/widgets/patient_source_info_widget.dart';
import 'package:health_wallet/features/sync/domain/services/wallet_patient_service.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as sync_source;
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';

@RoutePage()
class ProcessToFHIRPage extends StatefulWidget {
  final List<String> scannedImages;
  final List<String> importedImages;
  final List<String> importedPdfs;

  const ProcessToFHIRPage({
    super.key,
    this.scannedImages = const [],
    this.importedImages = const [],
    this.importedPdfs = const [],
  });

  @override
  State<ProcessToFHIRPage> createState() => _ProcessToFHIRPageState();
}

class _ProcessToFHIRPageState extends State<ProcessToFHIRPage> {
  final _formKey = GlobalKey<FormState>();
  final _encounterNameController = TextEditingController();
  final _pageController = PageController();
  final _ocrHelper = OcrProcessingHelper();

  bool _isCreating = false;
  bool _isProcessingOCR = false;
  bool _ocrCompleted = false;
  bool _isConvertingPdfs = false;
  String _extractedText = '';
  List<String> _extractedTextsPerPage = [];
  List<String> _allImagePathsForOCR = [];
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _prepareImagesForOCR();
  }

  @override
  void dispose() {
    _encounterNameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _prepareImagesForOCR() async {
    setState(() => _isConvertingPdfs = true);

    try {
      final allImages = await _ocrHelper.prepareAllImages(
        scannedImages: widget.scannedImages,
        importedImages: widget.importedImages,
        importedPdfs: widget.importedPdfs,
      );

      setState(() {
        _allImagePathsForOCR = allImages;
        _isConvertingPdfs = false;
      });
    } catch (e) {
      setState(() {
        _isConvertingPdfs = false;
        _allImagePathsForOCR = [
          ...widget.scannedImages,
          ...widget.importedImages,
        ];
      });

      if (mounted) {
        _showSnackBar(
          'Warning: Could not convert PDFs for preview. PDFs will still be included in the encounter.',
          Colors.orange,
        );
      }
    }
  }

  Future<void> _processOCR() async {
    setState(() => _isProcessingOCR = true);

    try {
      final pageTexts =
          await _ocrHelper.processOcrForImages(_allImagePathsForOCR);

      setState(() {
        _extractedTextsPerPage = pageTexts;
        _extractedText = pageTexts.isNotEmpty
            ? pageTexts[0]
            : 'No text could be extracted from the documents.';
        _ocrCompleted = true;
        _isProcessingOCR = false;
      });

      if (mounted) {
        _showSnackBar(
          'OCR processing completed successfully!',
          Colors.green,
        );
      }
    } catch (e) {
      setState(() {
        _extractedText = 'Error processing OCR: $e';
        _ocrCompleted = true;
        _isProcessingOCR = false;
      });

      if (mounted) {
        _showSnackBar('OCR processing failed: $e', Colors.red);
      }
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
      if (_ocrCompleted &&
          _extractedTextsPerPage.isNotEmpty &&
          index < _extractedTextsPerPage.length) {
        _extractedText = _extractedTextsPerPage[index];
      }
    });
  }

  Future<void> _createEncounter() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCreating = true);

    try {
      final encounterName = _encounterNameController.text.trim();
      final homeState = context.read<HomeBloc>().state;
      final patientState = context.read<PatientBloc>().state;

      // Get the selected patient
      final selectedPatientId = patientState.selectedPatientId;
      final selectedPatient = patientState.patients.isNotEmpty
          ? patientState.patients.firstWhere(
              (p) => p.id == selectedPatientId,
              orElse: () => patientState.patients.first,
            )
          : null;

      final patient = selectedPatient ?? homeState.patient;
      final patientId = patient?.resourceId ?? 'patient-default';
      final patientName = patient?.displayTitle ?? 'Unknown Patient';

      // Determine the effective source ID - create wallet source if needed
      String effectiveSourceId;

      if (selectedPatientId != null) {
        // Check if patient has a writable wallet source
        final patientGroup = patientState.patientGroups[selectedPatientId];
        final hasWritableWalletSource = patientGroup?.sourceIds.any((sourceId) {
              // Check if any source is a wallet source (writable)
              final source = homeState.sources.firstWhere(
                (s) => s.id == sourceId,
                orElse: () => const sync_source.Source(
                    id: '', platformName: null, logo: null, labelSource: null),
              );
              return source.platformType == 'wallet';
            }) ??
            false;

        if (!hasWritableWalletSource) {
          // Create a new wallet source for this patient
          final walletPatientService =
              GetIt.instance.get<WalletPatientService>();
          final walletSource =
              await walletPatientService.createWalletSourceForPatient(
            selectedPatientId,
            patientName,
          );

          // Save the wallet source to the database
          final syncRepository = GetIt.instance.get<SyncRepository>();
          await syncRepository.cacheSources([walletSource]);

          // Duplicate the Patient resource to the new wallet source
          await _duplicatePatientToWalletSource(
              selectedPatient, walletSource.id);

          // Trigger a reload of patient data to include the new wallet source
          context.read<PatientBloc>().add(
                PatientPatientsLoaded(),
              );

          effectiveSourceId =
              walletSource.id; // This will be 'wallet-{patientId}'
        } else {
          // Use existing wallet source
          final walletSourceId = patientGroup!.sourceIds.firstWhere(
            (sourceId) {
              final source = homeState.sources.firstWhere(
                (s) => s.id == sourceId,
                orElse: () => const sync_source.Source(
                    id: '', platformName: null, logo: null, labelSource: null),
              );
              return source.platformType == 'wallet';
            },
          );
          effectiveSourceId = walletSourceId;
        }
      } else {
        // No patient selected, create wallet source for default patient
        final walletPatientService = GetIt.instance.get<WalletPatientService>();
        final walletSource =
            await walletPatientService.createWalletSourceForPatient(
          patientId,
          patientName,
        );

        // Save the wallet source to the database
        final syncRepository = GetIt.instance.get<SyncRepository>();
        await syncRepository.cacheSources([walletSource]);

        effectiveSourceId = walletSource.id;
      }

      final encounterId = FhirEncounterHelper.generateEncounterId();

      // Create FHIR Encounter
      final fhirEncounter = FhirEncounterHelper.createEncounter(
        encounterId: encounterId,
        patientId: patientId,
        title: encounterName,
        patientName: patient?.displayTitle ?? 'Unknown Patient',
      );

      // Save to database
      await FhirEncounterHelper.saveToDatabase(
        fhirEncounter: fhirEncounter,
        sourceId: effectiveSourceId,
        title: encounterName,
      );

      // Save documents as FHIR Media resources
      final mediaIntegrationService =
          GetIt.instance.get<MediaIntegrationService>();

      final resourceIds =
          await mediaIntegrationService.saveGroupedDocumentsAsFhirRecords(
        scannedImages: widget.scannedImages,
        importedImages: widget.importedImages,
        importedPdfs: widget.importedPdfs,
        patientId: patientId,
        encounterId: encounterId,
        sourceId: effectiveSourceId,
        title: encounterName,
      );

      if (mounted) {
        _showSuccessAndNavigateBack(encounterName, resourceIds.length);
      }
    } catch (e) {
      setState(() => _isCreating = false);
      logger.e('Error creating encounter: $e');

      if (mounted) {
        _showSnackBar('Failed to create encounter: $e', Colors.red,
            duration: 4);
      }
    }
  }

  void _showSuccessAndNavigateBack(String encounterName, int groupCount) {
    final totalDocuments = widget.scannedImages.length +
        widget.importedImages.length +
        widget.importedPdfs.length;

    _showSnackBar(
      'Encounter "$encounterName" created successfully with $totalDocuments documents grouped into $groupCount PDF${groupCount > 1 ? 's' : ''}!',
      Colors.green,
      duration: 3,
    );

    Navigator.of(context).pop(true);
  }

  void _showSnackBar(String message, Color backgroundColor,
      {int duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text('Process to FHIR', style: AppTextStyle.titleMedium),
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isCreating) {
      return _buildLoadingIndicator('Adding to Wallet...');
    }

    if (_isConvertingPdfs) {
      return _buildLoadingIndicator('Converting PDFs for preview...');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Insets.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDocumentSummary(),
          const SizedBox(height: Insets.normal),
          _buildDocumentPreview(),
          const SizedBox(height: Insets.large),
          _buildOcrSection(),
          _buildEncounterFormSection(),
          const SizedBox(height: Insets.large),
        ],
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

  Widget _buildDocumentSummary() {
    return ScanSummaryCard(
      scannedCount: widget.scannedImages.length,
      importedImagesCount: widget.importedImages.length,
      importedPdfsCount: widget.importedPdfs.length,
      totalPagesForOcr: _allImagePathsForOCR.length,
    );
  }

  Widget _buildDocumentPreview() {
    if (_allImagePathsForOCR.isEmpty) return const SizedBox.shrink();

    return ScanPreviewCard(
      imagePaths: _allImagePathsForOCR,
      currentPageIndex: _currentPageIndex,
      pageController: _pageController,
      onPageChanged: _onPageChanged,
    );
  }

  Widget _buildOcrSection() {
    if (_allImagePathsForOCR.isEmpty && !_isConvertingPdfs) {
      return const EmptyScanWarning();
    }

    if (!_ocrCompleted &&
        !_isProcessingOCR &&
        _allImagePathsForOCR.isNotEmpty) {
      return ProcessOcrButton(onPressed: _processOCR);
    }

    if (_isProcessingOCR) {
      return const OcrProcessingIndicator();
    }

    if (_ocrCompleted) {
      return Column(
        children: [
          ExtractedTextDisplay(
            extractedText: _extractedText,
            currentPageIndex: _currentPageIndex,
          ),
          const SizedBox(height: Insets.large),
          const FhirProcessingInfoCard(),
          const SizedBox(height: Insets.large),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEncounterFormSection() {
    // Show form after OCR completion OR if no images available
    if (!_ocrCompleted && _allImagePathsForOCR.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const PatientSourceInfoWidget(),
        const SizedBox(height: Insets.normal),
        EncounterFormWidget(
          formKey: _formKey,
          encounterNameController: _encounterNameController,
          onSubmit: _createEncounter,
        ),
      ],
    );
  }

  /// Duplicates a Patient resource to a new wallet source
  Future<void> _duplicatePatientToWalletSource(
      Patient? patient, String walletSourceId) async {
    if (patient == null) return;

    try {
      final database = GetIt.instance.get<AppDatabase>();

      // Create a new Patient resource for the wallet source
      final walletPatient = patient.copyWith(
        id: patient.id, // Keep the same patient ID
        sourceId: walletSourceId, // Set the new wallet source ID
      );

      // Convert to FHIR JSON
      final patientJson = patient.rawResource;
      final resourceId = patient.id;

      // Create FHIR resource entry
      final dto = FhirResourceCompanion.insert(
        id: '${walletSourceId}_$resourceId',
        sourceId: drift.Value(walletSourceId),
        resourceId: drift.Value(resourceId),
        resourceType: drift.Value('Patient'),
        title: drift.Value(walletPatient.displayTitle),
        date: drift.Value(walletPatient.birthDate?.valueString != null
            ? DateTime.tryParse(walletPatient.birthDate!.valueString!) ??
                DateTime.now()
            : DateTime.now()),
        resourceRaw: jsonEncode(patientJson),
        encounterId:
            const drift.Value.absent(), // Patients don't have encounterId
        subjectId: drift.Value(
            resourceId), // Patient's subjectId is their own resourceId
      );

      // Save to database
      await database.into(database.fhirResource).insertOnConflictUpdate(dto);
    } catch (e) {
      logger.e('❌ Failed to duplicate Patient to wallet source: $e');
    }
  }
}
