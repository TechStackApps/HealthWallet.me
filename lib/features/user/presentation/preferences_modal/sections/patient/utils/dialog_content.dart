import 'package:flutter/material.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'date_field.dart';
import 'form_fields.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

class DialogContent extends StatelessWidget {
  final Patient patient;
  final DateTime? selectedBirthDate;
  final String selectedGender;
  final String selectedBloodType;
  final List<String> genderOptions;
  final List<String> bloodTypeOptions;
  final Color iconColor;
  final ValueChanged<DateTime?> onBirthDateChanged;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String> onBloodTypeChanged;

  const DialogContent({
    super.key,
    required this.patient,
    required this.selectedBirthDate,
    required this.selectedGender,
    required this.selectedBloodType,
    required this.genderOptions,
    required this.bloodTypeOptions,
    required this.iconColor,
    required this.onBirthDateChanged,
    required this.onGenderChanged,
    required this.onBloodTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(patient.displayTitle,
              style: AppTextStyle.bodyMedium
                  .copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: Insets.medium),
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
