// widgets/encounter_form_widget.dart
import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class EncounterFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController encounterNameController;
  final VoidCallback onSubmit;

  const EncounterFormWidget({
    super.key,
    required this.formKey,
    required this.encounterNameController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            controller: encounterNameController,
            style: TextStyle(color: context.colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: 'Add as a new encounter *',
              labelStyle: TextStyle(
                color: context.colorScheme.onSurfaceVariant,
              ),
              hintText: 'e.g., Lab Results, X-Ray Report, Medical Document',
              hintStyle: TextStyle(
                color: context.colorScheme.onSurfaceVariant.withOpacity(0.6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colorScheme.primary),
              ),
              prefixIcon: Icon(
                Icons.medical_information,
                color: context.colorScheme.primary,
              ),
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
              onPressed: onSubmit,
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
    );
  }
}
