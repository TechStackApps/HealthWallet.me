import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'date_field.dart';
import 'form_fields.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class DialogContent extends StatelessWidget {
  final Patient patient;
  final String? selectedGiven;
  final String? selectedFamily;
  final String? selectedMRN;
  final DateTime? selectedBirthDate;
  final String selectedGender;
  final String selectedBloodType;
  final List<String> genderOptions;
  final List<String> bloodTypeOptions;
  final Color iconColor;
  final bool showNameField;
  final ValueChanged<String>? onGivenChanged;
  final ValueChanged<String>? onFamilyChanged;
  final ValueChanged<String>? onMRNChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final ValueChanged<String>? onGenderChanged;
  final ValueChanged<String>? onBloodTypeChanged;
  final TextEditingController? givenController;
  final TextEditingController? familyController;
  final TextEditingController? mrnController;

  const DialogContent({
    super.key,
    required this.patient,
    this.selectedGiven,
    this.selectedFamily,
    this.selectedMRN,
    required this.selectedBirthDate,
    required this.selectedGender,
    required this.selectedBloodType,
    required this.genderOptions,
    required this.bloodTypeOptions,
    required this.iconColor,
    this.showNameField = false,
    this.onGivenChanged,
    this.onFamilyChanged,
    this.onMRNChanged,
    this.onBirthDateChanged,
    this.onGenderChanged,
    this.onBloodTypeChanged,
    this.givenController,
    this.familyController,
    this.mrnController,
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
            Row(
              children: [
                Expanded(
                  child: FormFields.buildTextField(
                    context,
                    'Given',
                    selectedGiven ?? '',
                    onGivenChanged,
                    controller: givenController,
                  ),
                ),
                const SizedBox(width: Insets.small),
                Expanded(
                  child: FormFields.buildTextField(
                    context,
                    'Family',
                    selectedFamily ?? '',
                    onFamilyChanged,
                    controller: familyController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Insets.normal),
            FormFields.buildTextField(
              context,
              'MRN',
              selectedMRN ?? '',
              onMRNChanged,
              controller: mrnController,
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
