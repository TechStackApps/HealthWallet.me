// process_to_fhir_page.dart (REFACTORED)
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/document_scanner/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/document_scanner/presentation/helpers/fhir_encounter_helper.dart';
import 'package:health_wallet/features/document_scanner/presentation/helpers/ocr_processing_helper.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_preview_card.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/document_summary_card.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/empty_document_warning.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/encounter_form_widget.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/ocr_widgets.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/document_scanner/presentation/widgets/patient_source_info_widget.dart';

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
      final pageTexts = await _ocrHelper.processOcrForImages(_allImagePathsForOCR);

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
      
      final sourceId = homeState.selectedSource == 'All' 
          ? null 
          : homeState.selectedSource;
      final patient = homeState.patient;
      final patientId = patient?.resourceId ?? 'patient-default';
      final effectiveSourceId = sourceId ?? 'document-scanner';
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
      final mediaIntegrationService = GetIt.instance.get<MediaIntegrationService>();
      
      _logDocumentPaths();
      
      final resourceIds = await mediaIntegrationService.saveGroupedDocumentsAsFhirRecords(
        scannedImages: widget.scannedImages,
        importedImages: widget.importedImages,
        importedPdfs: widget.importedPdfs,
        patientId: patientId,
        encounterId: encounterId,
        sourceId: effectiveSourceId,
        title: encounterName,
      );

      print('Created encounter: $encounterName with ${resourceIds.length} document groups');

      if (mounted) {
        _showSuccessAndNavigateBack(encounterName, resourceIds.length);
      }
    } catch (e) {
      setState(() => _isCreating = false);
      print('Error creating encounter: $e');

      if (mounted) {
        _showSnackBar('Failed to create encounter: $e', Colors.red, duration: 4);
      }
    }
  }

  void _logDocumentPaths() {
    print('DEBUG - Scanned images: ${widget.scannedImages.length}');
    print('DEBUG - Imported images: ${widget.importedImages.length}');
    print('DEBUG - Imported PDFs: ${widget.importedPdfs.length}');
    widget.scannedImages.forEach((path) => print('  Scanned: $path'));
    widget.importedImages.forEach((path) => print('  Imported: $path'));
    widget.importedPdfs.forEach((path) => print('  PDF: $path'));
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

  void _showSnackBar(String message, Color backgroundColor, {int duration = 2}) {
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
    return DocumentSummaryCard(
      scannedCount: widget.scannedImages.length,
      importedImagesCount: widget.importedImages.length,
      importedPdfsCount: widget.importedPdfs.length,
      totalPagesForOcr: _allImagePathsForOCR.length,
    );
  }

  Widget _buildDocumentPreview() {
    if (_allImagePathsForOCR.isEmpty) return const SizedBox.shrink();

    return DocumentPreviewCard(
      imagePaths: _allImagePathsForOCR,
      currentPageIndex: _currentPageIndex,
      pageController: _pageController,
      onPageChanged: _onPageChanged,
    );
  }

  Widget _buildOcrSection() {
    if (_allImagePathsForOCR.isEmpty && !_isConvertingPdfs) {
      return const EmptyDocumentWarning();
    }

    if (!_ocrCompleted && !_isProcessingOCR && _allImagePathsForOCR.isNotEmpty) {
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
}