// process_to_fhir_page.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:drift/drift.dart' hide Column;
import 'package:path/path.dart' as path;
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/document_scanner/domain/services/text_recognition_service.dart';
import 'package:health_wallet/features/document_scanner/domain/services/media_integration_service.dart';
import 'package:health_wallet/features/sync/data/data_source/local/tables/fhir_resource_table.dart';
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
  bool _isCreating = false;
  bool _isProcessingOCR = false;
  bool _ocrCompleted = false;
  bool _isConvertingPdfs = false;
  String _extractedText = '';
  List<String> _extractedTextsPerPage = []; // Store text for each page
  List<String> _allImagePathsForOCR = []; // All images including converted PDFs
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

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
    setState(() {
      _isConvertingPdfs = true;
    });
    
    try {
      final allImages = <String>[];
      
      // Add existing images
      allImages.addAll(widget.scannedImages);
      allImages.addAll(widget.importedImages);
      
      // Convert PDFs to images for OCR preview
      if (widget.importedPdfs.isNotEmpty) {
        final textRecognitionService = TextRecognitionService();
        for (final pdfPath in widget.importedPdfs) {
          print('Converting PDF for preview: $pdfPath');
          final convertedImages = await textRecognitionService.convertPdfToImages(pdfPath);
          allImages.addAll(convertedImages);
          print('Converted PDF to ${convertedImages.length} images for preview');
        }
      }
      
      setState(() {
        _allImagePathsForOCR = allImages;
        _isConvertingPdfs = false;
      });
    } catch (e) {
      setState(() {
        _isConvertingPdfs = false;
      });
      print('Error converting PDFs for preview: $e');
      
      // Fallback - just use the image files
      setState(() {
        _allImagePathsForOCR = [...widget.scannedImages, ...widget.importedImages];
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Warning: Could not convert PDFs for preview. PDFs will still be included in the encounter.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _processOCR() async {
    setState(() {
      _isProcessingOCR = true;
    });

    try {
      final textRecognitionService = TextRecognitionService();
      List<String> pageTexts = [];

      // Process each image for OCR
      for (int i = 0; i < _allImagePathsForOCR.length; i++) {
        final imagePath = _allImagePathsForOCR[i];
        print('Processing OCR for image ${i + 1}/${_allImagePathsForOCR.length}: $imagePath');

        final text = await textRecognitionService.recognizeTextFromImage(imagePath);

        if (text.isNotEmpty && !text.startsWith('Error recognizing text:')) {
          pageTexts.add(text);
        } else {
          pageTexts.add('No text could be extracted from this page.');
        }
      }

      setState(() {
        _extractedTextsPerPage = pageTexts;
        _extractedText = pageTexts.isNotEmpty
            ? pageTexts[0]
            : 'No text could be extracted from the documents.';
        _ocrCompleted = true;
        _isProcessingOCR = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OCR processing completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _extractedText = 'Error processing OCR: $e';
        _ocrCompleted = true;
        _isProcessingOCR = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OCR processing failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Process to FHIR',
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _isCreating
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Adding to Wallet...'),
                ],
              ),
            )
          : _isConvertingPdfs
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Converting PDFs for preview...'),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(Insets.normal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document summary card
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Insets.normal),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Document Summary',
                                style: AppTextStyle.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (widget.scannedImages.isNotEmpty)
                                Text('• ${widget.scannedImages.length} scanned image${widget.scannedImages.length > 1 ? 's' : ''}'),
                              if (widget.importedImages.isNotEmpty)
                                Text('• ${widget.importedImages.length} imported image${widget.importedImages.length > 1 ? 's' : ''}'),
                              if (widget.importedPdfs.isNotEmpty)
                                Text('• ${widget.importedPdfs.length} imported PDF${widget.importedPdfs.length > 1 ? 's' : ''}'),
                              const SizedBox(height: 8),
                              Text(
                                'Total: ${_allImagePathsForOCR.length} pages available for OCR preview',
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: Insets.normal),

                      // Document preview card
                      if (_allImagePathsForOCR.isNotEmpty) ...[
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: context.theme.dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Page indicator
                              if (_allImagePathsForOCR.length > 1)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.onSurface
                                        .withOpacity(0.05),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Left arrow
                                      SizedBox(
                                        width: 32,
                                        child: _currentPageIndex > 0
                                            ? IconButton(
                                                icon: const Icon(Icons.chevron_left, size: 16),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(
                                                  minWidth: 32,
                                                  minHeight: 24,
                                                ),
                                                onPressed: () {
                                                  _pageController.previousPage(
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                              )
                                            : null,
                                      ),
                                      // Centered text
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Page ${_currentPageIndex + 1} of ${_allImagePathsForOCR.length}',
                                            style: AppTextStyle.bodySmall.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Right arrow
                                      SizedBox(
                                        width: 32,
                                        child: _currentPageIndex < _allImagePathsForOCR.length - 1
                                            ? IconButton(
                                                icon: const Icon(Icons.chevron_right, size: 16),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(
                                                  minWidth: 32,
                                                  minHeight: 24,
                                                ),
                                                onPressed: () {
                                                  _pageController.nextPage(
                                                    duration: const Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                              )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),

                              // Image preview
                              Container(
                                height: 400,
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPageIndex = index;
                                      // Update extracted text to show current page's text
                                      if (_ocrCompleted && _extractedTextsPerPage.isNotEmpty && index < _extractedTextsPerPage.length) {
                                        _extractedText = _extractedTextsPerPage[index];
                                      }
                                    });
                                  },
                                  itemCount: _allImagePathsForOCR.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.all(Insets.normal),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(_allImagePathsForOCR[index]),
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.error, size: 40, color: Colors.red),
                                                    SizedBox(height: 8),
                                                    Text('Failed to load image'),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Insets.large),
                      ],

                      // Step 1: Process OCR button (shown initially)
                      if (!_ocrCompleted && !_isProcessingOCR && _allImagePathsForOCR.isNotEmpty) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _processOCR,
                            icon: const Icon(Icons.text_fields),
                            label: const Text(
                              'Process OCR',
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
                        ),
                      ],

                      // Step 2: OCR Processing indicator
                      if (_isProcessingOCR) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Insets.normal),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer.withOpacity(0.3),
                            border: Border.all(color: context.colorScheme.primary.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Processing OCR...',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: context.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Step 3: Extracted text (shown after OCR completion)
                      if (_ocrCompleted) ...[
                        Text(
                          'Extracted Text - Page ${_currentPageIndex + 1}',
                          style: AppTextStyle.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: Insets.normal),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Insets.normal),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                            border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _extractedText,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        const SizedBox(height: Insets.large),

                        // Step 4: Additional Information (shown after OCR)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Insets.normal),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                            border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.text_fields, color: context.colorScheme.primary, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'OCR to FHIR format',
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Future FHIR processing will be implemented here to automatically extract structured data from the OCR text.',
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: Insets.large),

                        // Step 5: Patient & Source Information
                        const PatientSourceInfoWidget(),
                        const SizedBox(height: Insets.normal),

                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Encounter name',
                                style: AppTextStyle.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: Insets.normal),

                              // Encounter name field
                              TextFormField(
                                controller: _encounterNameController,
                                style: TextStyle(color: context.colorScheme.onSurface),
                                decoration: InputDecoration(
                                  labelText: 'Add as a new encounter *',
                                  labelStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
                                  hintText: 'e.g., Lab Results, X-Ray Report, Medical Document',
                                  hintStyle: TextStyle(
                                      color: context.colorScheme.onSurfaceVariant.withOpacity(0.6)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: context.colorScheme.outline),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: context.colorScheme.outline),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: context.colorScheme.primary),
                                  ),
                                  prefixIcon: Icon(Icons.medical_information,
                                      color: context.colorScheme.primary),
                                  filled: true,
                                  fillColor: context.colorScheme.surface,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Encounter name is required';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: Insets.large),

                              // Add into Wallet button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _createEncounter,
                                  icon: const Icon(Icons.add_circle_outline),
                                  label: const Text(
                                    'Add to Wallet',
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
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Show message if no documents to process
                      if (_allImagePathsForOCR.isEmpty && !_isConvertingPdfs) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Insets.large),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            border: Border.all(color: Colors.orange[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.warning, color: Colors.orange[700], size: 40),
                              const SizedBox(height: 8),
                              Text(
                                'No images available for OCR processing',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Only PDFs were provided. They will be included in the encounter but OCR preview is not available.',
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: Colors.orange[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: Insets.large),
                        
                        // Still allow encounter creation even without OCR
                        const PatientSourceInfoWidget(),
                        const SizedBox(height: Insets.normal),

                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Encounter name',
                                style: AppTextStyle.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: Insets.normal),

                              TextFormField(
                                controller: _encounterNameController,
                                style: TextStyle(color: context.colorScheme.onSurface),
                                decoration: InputDecoration(
                                  labelText: 'Add as a new encounter *',
                                  labelStyle: TextStyle(color: context.colorScheme.onSurfaceVariant),
                                  hintText: 'e.g., Lab Results, X-Ray Report, Medical Document',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: context.colorScheme.outline),
                                  ),
                                  prefixIcon: Icon(Icons.medical_information,
                                      color: context.colorScheme.primary),
                                  filled: true,
                                  fillColor: context.colorScheme.surface,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Encounter name is required';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: Insets.large),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _createEncounter,
                                  icon: const Icon(Icons.add_circle_outline),
                                  label: const Text(
                                    'Add to Wallet',
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
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Add some bottom padding
                      const SizedBox(height: Insets.large),
                    ],
                  ),
                ),
    );
  }

  Future<void> _createEncounter() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      // Extract form data
      final encounterName = _encounterNameController.text.trim();
      
      // Get current source and patient info from HomeBloc
      final homeState = context.read<HomeBloc>().state;
      final sourceId = homeState.selectedSource == 'All' ? null : homeState.selectedSource;
      final patient = homeState.patient;
      final patientId = patient?.resourceId ?? 'patient-default';
      final effectiveSourceId = sourceId ?? 'document-scanner';
      
      // Generate encounter ID
      final encounterId = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Step 1: Create FHIR Encounter resource
      final fhirEncounter = _createFhirR4Encounter(
        encounterId: encounterId,
        patientId: patientId,
        title: encounterName,
        patientName: patient?.displayTitle ?? 'Unknown Patient',
      );
      
      // Step 2: Save encounter to database
      await _saveEncounterToDatabase(
        fhirEncounter: fhirEncounter,
        sourceId: effectiveSourceId,
        title: encounterName,
      );
      
      // Step 3: Group documents and create Media resources
      final mediaIntegrationService = GetIt.instance.get<MediaIntegrationService>();
      print('DEBUG - Scanned images: ${widget.scannedImages.length}');
print('DEBUG - Imported images: ${widget.importedImages.length}'); 
print('DEBUG - Imported PDFs: ${widget.importedPdfs.length}');

widget.scannedImages.forEach((path) => print('  Scanned: $path'));
widget.importedImages.forEach((path) => print('  Imported: $path'));
widget.importedPdfs.forEach((path) => print('  PDF: $path'));
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
      
      // Success!
      if (mounted) {
        final totalDocuments = widget.scannedImages.length + widget.importedImages.length + widget.importedPdfs.length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Encounter "$encounterName" created successfully with $totalDocuments documents grouped into ${resourceIds.length} PDF${resourceIds.length > 1 ? 's' : ''}!',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop(true);
      }
      
    } catch (e) {
      setState(() {
        _isCreating = false;
      });
      
      print('Error creating encounter: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create encounter: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  /// Create a FHIR R4 Encounter resource
  fhir_r4.Encounter _createFhirR4Encounter({
    required String encounterId,
    required String patientId,
    required String title,
    required String patientName,
  }) {
    final timestamp = DateTime.now();
    
    return fhir_r4.Encounter(
      id: fhir_r4.FhirString(encounterId),
      status: fhir_r4.EncounterStatus.finished,
      class_: fhir_r4.Coding(
        system: fhir_r4.FhirUri('http://terminology.hl7.org/CodeSystem/v3-ActCode'),
        code: fhir_r4.FhirCode('AMB'),
        display: fhir_r4.FhirString('ambulatory'),
      ),
      type: [
        fhir_r4.CodeableConcept(
          coding: [
            fhir_r4.Coding(
              system: fhir_r4.FhirUri('http://snomed.info/sct'),
              code: fhir_r4.FhirCode('308646001'),
              display: fhir_r4.FhirString('Document processing'),
            ),
          ],
          text: fhir_r4.FhirString(title),
        ),
      ],
      subject: fhir_r4.Reference(
        reference: fhir_r4.FhirString('Patient/$patientId'),
        display: fhir_r4.FhirString(patientName),
      ),
      period: fhir_r4.Period(
        start: fhir_r4.FhirDateTime.fromString(timestamp.toIso8601String()),
      ),
      identifier: [
        fhir_r4.Identifier(
          system: fhir_r4.FhirUri('http://health-wallet.app/encounter-id'),
          value: fhir_r4.FhirString(encounterId),
          use: fhir_r4.IdentifierUse.usual,
        ),
      ],
    );
  }

  /// Save FHIR Encounter resource to the local database
  Future<void> _saveEncounterToDatabase({
    required fhir_r4.Encounter fhirEncounter,
    required String sourceId,
    required String title,
  }) async {
    final database = GetIt.instance.get<AppDatabase>();
    final resourceJson = fhirEncounter.toJson();
    final resourceId = fhirEncounter.id!.valueString!;
    
    final dto = FhirResourceCompanion.insert(
      id: '${sourceId}_$resourceId',
      sourceId: Value(sourceId),
      resourceId: Value(resourceId),
      resourceType: Value('Encounter'),
      title: Value(title),
      date: Value(_extractDateFromEncounter(fhirEncounter)),
      resourceRaw: jsonEncode(resourceJson),
    );
    
    await database.into(database.fhirResource).insertOnConflictUpdate(dto);
  }

  /// Extract date from FHIR Encounter resource
  DateTime _extractDateFromEncounter(fhir_r4.Encounter encounter) {
    if (encounter.period?.start != null) {
      try {
        return DateTime.parse(encounter.period!.start!.valueString!);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }
}