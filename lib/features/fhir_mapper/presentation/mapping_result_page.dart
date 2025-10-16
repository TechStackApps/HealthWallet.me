import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/fhir_mapper/presentation/bloc/fhir_mapper_bloc.dart';

@RoutePage()
class MappingResultPage extends StatelessWidget {
  const MappingResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    FhirMapperState state = context.watch<FhirMapperBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review resources", style: AppTextStyle.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: state.resources.length,
          itemBuilder: (context, index) {
            MappingResource resource = state.resources[index];
            Map<String, TextFieldDescriptor> textFields =
                resource.getFieldDescriptors();

            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.6))),
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(descriptor.label, style: AppTextStyle.bodySmall),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 36,
                            child: TextFormField(
                              initialValue: descriptor.value,
                              validator: descriptor.validator,
                              inputFormatters: descriptor.inputFormatters,
                              keyboardType: descriptor.keyboardType,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: AppTextStyle.labelLarge,
                              onChanged: (value) => context
                                  .read<FhirMapperBloc>()
                                  .add(FhirMapperResourceChanged(
                                    index: index,
                                    propertyKey: propertyKey,
                                    newValue: value,
                                  )),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
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
      ),
    );
  }
}
