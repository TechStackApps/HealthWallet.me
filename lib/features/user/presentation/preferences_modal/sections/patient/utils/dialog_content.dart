import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'date_field.dart';
import 'form_fields.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class DialogContent extends StatelessWidget {
  final Patient patient;
  final String? selectedName;
  final DateTime? selectedBirthDate;
  final String selectedGender;
  final String selectedBloodType;
  final List<String> genderOptions;
  final List<String> bloodTypeOptions;
  final Color iconColor;
  final bool showNameField;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final ValueChanged<String>? onGenderChanged;
  final ValueChanged<String>? onBloodTypeChanged;

  const DialogContent({
    super.key,
    required this.patient,
    this.selectedName,
    required this.selectedBirthDate,
    required this.selectedGender,
    required this.selectedBloodType,
    required this.genderOptions,
    required this.bloodTypeOptions,
    required this.iconColor,
    this.showNameField = false,
    this.onNameChanged,
    this.onBirthDateChanged,
    this.onGenderChanged,
    this.onBloodTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!showNameField)
            Text(patient.displayTitle,
                style: AppTextStyle.bodyMedium
                    .copyWith(fontWeight: FontWeight.w500)),
          if (!showNameField) const SizedBox(height: Insets.medium),
          if (showNameField) ...[
            FormFields.buildTextField(
              context,
              'Name',
              selectedName ?? patient.displayTitle,
              onNameChanged,
            ),
            const SizedBox(height: Insets.normal),
          ],
          DateField(
            label: context.l10n.age,
            selectedDate: selectedBirthDate,
            onDateChanged: onBirthDateChanged,
            iconColor: iconColor,
          ),
          const SizedBox(height: Insets.normal),
          FormFields.buildDropdownField(
            context,
            context.l10n.sex,
            selectedGender,
            genderOptions,
            onGenderChanged,
          ),
          const SizedBox(height: Insets.normal),
          FormFields.buildDropdownField(
            context,
            context.l10n.bloodType,
            selectedBloodType,
            bloodTypeOptions,
            onBloodTypeChanged,
          ),
        ],
      ),
    );
  }
}
