// create_encounter_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

@RoutePage()
class CreateEncounterPage extends StatefulWidget {
  final List<String> imagePaths;

  const CreateEncounterPage({
    super.key,
    required this.imagePaths,
  });

  @override
  State<CreateEncounterPage> createState() => _CreateEncounterPageState();
}

class _CreateEncounterPageState extends State<CreateEncounterPage> {
  final _formKey = GlobalKey<FormState>();
  final _encounterNameController = TextEditingController();
  final _patientNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isCreating = false;
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _encounterNameController.dispose();
    _patientNameController.dispose();
    _doctorNameController.dispose();
    _notesController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Create New Encounter',
          style: AppTextStyle.titleMedium,
        ),
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          if (!_isCreating)
            TextButton(
              onPressed: _createEncounter,
              child: const Text('Create'),
            ),
        ],
      ),
      body: _isCreating
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Creating encounter...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(Insets.normal),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page indicator
                    if (widget.imagePaths.length > 1) ...[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.onSurface.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_currentPageIndex > 0)
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                              Text(
                                'Page ${_currentPageIndex + 1} of ${widget.imagePaths.length}',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (_currentPageIndex < widget.imagePaths.length - 1)
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Insets.normal),
                    ],

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
                          // Card header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(Insets.normal),
                            decoration: BoxDecoration(
                              color: context.colorScheme.onSurface.withOpacity(0.05),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 20,
                                  color: context.colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.imagePaths.length > 1 
                                      ? 'Scanned Document - Page ${_currentPageIndex + 1}'
                                      : 'Scanned Document',
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${widget.imagePaths.length} page${widget.imagePaths.length > 1 ? 's' : ''}',
                                    style: AppTextStyle.labelSmall.copyWith(
                                      color: context.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                    
                    // Form inputs
                    Text(
                      'Encounter Information',
                      style: AppTextStyle.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Insets.normal),
                    
                    // Encounter name field
                    TextFormField(
                      controller: _encounterNameController,
                      decoration: InputDecoration(
                        labelText: 'Encounter Name *',
                        hintText: 'e.g., Lab Results, X-Ray Report, Medical Document',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.medical_information),
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
                    
                    const SizedBox(height: Insets.normal),
                    
                    // Patient name field
                    TextFormField(
                      controller: _patientNameController,
                      decoration: InputDecoration(
                        labelText: 'Patient Name',
                        hintText: 'e.g., John Doe',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: context.colorScheme.surface,
                      ),
                    ),
                    
                    const SizedBox(height: Insets.normal),
                    
                    // Doctor name field
                    TextFormField(
                      controller: _doctorNameController,
                      decoration: InputDecoration(
                        labelText: 'Doctor/Provider Name',
                        hintText: 'e.g., Dr. Sarah Chen',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.local_hospital),
                        filled: true,
                        fillColor: context.colorScheme.surface,
                      ),
                    ),
                    
                    const SizedBox(height: Insets.normal),
                    
                    // Notes field
                    TextFormField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Notes (Optional)',
                        hintText: 'Additional information about this encounter...',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.notes),
                        filled: true,
                        fillColor: context.colorScheme.surface,
                        alignLabelWithHint: true,
                      ),
                    ),
                    
                    const SizedBox(height: Insets.normal),
                    
                    // OCR placeholder section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(Insets.normal),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blue[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.text_fields, color: Colors.blue[700], size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'OCR Text Extraction',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'OCR functionality will be implemented here to automatically extract and populate text from the scanned documents.',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: Colors.blue[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: Insets.large),
                    
                    // Create button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _createEncounter,
                        icon: const Icon(Icons.add_circle_outline),
                        label: Text(
                          'Create Encounter with ${widget.imagePaths.length} Page${widget.imagePaths.length > 1 ? 's' : ''}',
                          style: const TextStyle(fontSize: 16),
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
                    
                    // Add some bottom padding
                    const SizedBox(height: Insets.large),
                  ],
                ),
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
      final patientName = _patientNameController.text.trim();
      final doctorName = _doctorNameController.text.trim();
      final notes = _notesController.text.trim();
      
      // Simulate async operation
      await Future.delayed(const Duration(seconds: 2));
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Encounter "$encounterName" created successfully!'),
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
            content: Text('Failed to create encounter: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}