import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/scan/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/scan/domain/entity/text_field_descriptor.dart';

class ResourcesForm extends StatelessWidget {
  const ResourcesForm({
    required this.resources,
    required this.onPropertyChanged,
    required this.formKey,
    super.key,
  });

  final List<MappingResource> resources;
  final Function(int, String, String) onPropertyChanged;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView.builder(
        itemCount: resources.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          MappingResource resource = resources[index];
          Map<String, TextFieldDescriptor> textFields =
              resource.getFieldDescriptors();
      
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AppColors.primary.withValues(alpha: 0.6))),
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resource.label, style: AppTextStyle.bodyLarge),
                  const SizedBox(height: 24),
                  ...textFields.entries.map((entry) {
                    final propertyKey = entry.key;
                    final descriptor = entry.value;
                    final borderColor = switch (descriptor.confidenceLevel) {
                      < 0.6 => Colors.red,
                      >= 0.6 && < 0.8 => Colors.yellow,
                      _ => AppColors.border,
                    };
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: ValueKey('${index}_$propertyKey'),
                      children: [
                        Text(descriptor.label, style: AppTextStyle.bodySmall),
                        const SizedBox(height: 4),
                        TextFormField(
                          initialValue: descriptor.value,
                          validator: descriptor.validate,
                          inputFormatters: descriptor.inputFormatters,
                          keyboardType: descriptor.keyboardType,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: AppTextStyle.labelLarge,
                          onChanged: (value) => onPropertyChanged
                              .call(index, propertyKey, value),
                          decoration: InputDecoration(
                            isDense: true,
                            helperText: ' ',
                            helperStyle: const TextStyle(height: 0, fontSize: 0),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                        if (entry.key != textFields.entries.last.key)
                          const SizedBox(height: 16),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
