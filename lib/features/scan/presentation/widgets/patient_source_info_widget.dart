import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

class PatientSourceInfoWidget extends StatelessWidget {
  final String? title;

  const PatientSourceInfoWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<PatientBloc, PatientState>(
          builder: (context, patientState) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Insets.normal),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                border: Border.all(
                  color: context.colorScheme.outline.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: context.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title ?? 'Patient & Source Information',
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildPatientSelector(context, patientState, homeState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPatientSelector(
      BuildContext context, PatientState patientState, HomeState homeState) {
    final selectedPatient = patientState.patients.isNotEmpty
        ? patientState.patients.firstWhere(
            (p) => p.id == patientState.selectedPatientId,
            orElse: () => patientState.patients.first,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient',
          style: AppTextStyle.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () => _showPatientSelectionDialog(context, patientState),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: context.colorScheme.outline.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedPatient?.displayTitle ?? 'No patient selected',
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: context.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPatientSelectionDialog(
      BuildContext context, PatientState patientState) {
    if (patientState.patients.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Patient'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: patientState.patients.length,
              itemBuilder: (context, index) {
                final patient = patientState.patients[index];
                final isSelected = patient.id == patientState.selectedPatientId;

                return ListTile(
                  title: Text(patient.displayTitle),
                  leading: Radio<String>(
                    value: patient.id,
                    groupValue: patientState.selectedPatientId,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<PatientBloc>().add(
                              PatientSelectionChanged(patientId: value),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  selected: isSelected,
                  onTap: () {
                    context.read<PatientBloc>().add(
                          PatientSelectionChanged(patientId: patient.id),
                        );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
