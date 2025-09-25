// process_to_fhir_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/document_scanner/domain/services/text_recognition_service.dart';

@RoutePage()
class ProcessToFHIRPage extends StatefulWidget {
  final List<String> imagePaths;

  const ProcessToFHIRPage({
    super.key,
    required this.imagePaths,
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
  String _extractedText = '';
  List<String> _extractedTextsPerPage = []; // Store text for each page
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _encounterNameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _processOCR() async {
    setState(() {
      _isProcessingOCR = true;
    });

    try {
      final textRecognitionService = TextRecognitionService();
      List<String> pageTexts = [];

      // Process each image for OCR
      for (int i = 0; i < widget.imagePaths.length; i++) {
        final imagePath = widget.imagePaths[i];
        print(
            'Processing OCR for image ${i + 1}/${widget.imagePaths.length}: $imagePath');

        final text =
            await textRecognitionService.recognizeTextFromImage(imagePath);

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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(Insets.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document preview card
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
                        if (widget.imagePaths.length > 1)
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
                                // Left arrow (invisible placeholder when not needed)
                                SizedBox(
                                  width: 32,
                                  child: _currentPageIndex > 0
                                      ? IconButton(
                                          icon: const Icon(Icons.chevron_left,
                                              size: 16),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 24,
                                          ),
                                          onPressed: () {
                                            _pageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
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
                                      'Page ${_currentPageIndex + 1} of ${widget.imagePaths.length}',
                                      style: AppTextStyle.bodySmall.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                // Right arrow (invisible placeholder when not needed)
                                SizedBox(
                                  width: 32,
                                  child: _currentPageIndex <
                                          widget.imagePaths.length - 1
                                      ? IconButton(
                                          icon: const Icon(Icons.chevron_right,
                                              size: 16),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 32,
                                            minHeight: 24,
                                          ),
                                          onPressed: () {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
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
                                if (_ocrCompleted &&
                                    _extractedTextsPerPage.isNotEmpty) {
                                  _extractedText =
                                      _extractedTextsPerPage[index];
                                }
                              });
                            },
                            itemCount: widget.imagePaths.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(Insets.normal),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(widget.imagePaths[index]),
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.error,
                                                  size: 40, color: Colors.red),
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

                  // Step 1: Process OCR button (shown initially)
                  if (!_ocrCompleted && !_isProcessingOCR) ...[
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
                        color: context.colorScheme.primaryContainer
                            .withOpacity(0.3),
                        border: Border.all(
                            color:
                                context.colorScheme.primary.withOpacity(0.3)),
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
                        color:
                            context.colorScheme.surfaceVariant.withOpacity(0.5),
                        border: Border.all(
                            color:
                                context.colorScheme.outline.withOpacity(0.3)),
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
                    if (_ocrCompleted) ...[
                      // OCR Information
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(Insets.normal),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceVariant
                              .withOpacity(0.5),
                          border: Border.all(
                              color:
                                  context.colorScheme.outline.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.text_fields,
                                    color: context.colorScheme.primary,
                                    size: 20),
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
                              'Here will be implemented here to automatically extract and populate text from the scanned documents.',
                              style: AppTextStyle.bodySmall.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: Insets.large),
                    ],

                    // Step 5: FHIR Processing Information (shown after OCR)
                    if (_ocrCompleted) ...[
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
                              style: TextStyle(
                                  color: context.colorScheme.onSurface),
                              decoration: InputDecoration(
                                labelText: 'Add as a new encounter *',
                                labelStyle: TextStyle(
                                    color:
                                        context.colorScheme.onSurfaceVariant),
                                hintText:
                                    'e.g., Lab Results, X-Ray Report, Medical Document',
                                hintStyle: TextStyle(
                                    color: context.colorScheme.onSurfaceVariant
                                        .withOpacity(0.6)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.colorScheme.outline),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.colorScheme.outline),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.colorScheme.primary),
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
                                label: Text(
                                  'Add to Wallet',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorScheme.primary,
                                  foregroundColor:
                                      context.colorScheme.onPrimary,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
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
      // TODO: Implement actual encounter creation logic here
      // This would involve:
      // 1. Creating a new Encounter resource with the form data
      // 2. Creating Media resources for each scanned page
      // 3. Linking the Media resources to the Encounter
      // 4. Saving everything to your data store

      final encounterName = _encounterNameController.text.trim();

      // Simulate async operation
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Encounter "$encounterName" added to wallet successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Return to previous screen with success result
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _isCreating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add encounter to wallet: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
