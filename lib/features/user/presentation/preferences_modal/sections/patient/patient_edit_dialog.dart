import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/core/constants/blood_types.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'utils/dialog_header.dart';
import 'utils/dialog_content.dart';
import 'utils/form_fields.dart';
import 'services/patient_edit_service.dart';

class PatientEditDialog extends StatefulWidget {
  final Patient patient;
  final VoidCallback? onBloodTypeUpdated;

  const PatientEditDialog({
    super.key,
    required this.patient,
    this.onBloodTypeUpdated,
  });

  static void show(BuildContext context, Patient patient,
      {VoidCallback? onBloodTypeUpdated}) {
    final patientBloc = BlocProvider.of<PatientBloc>(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: BlocProvider.of<UserBloc>(context)),
            BlocProvider.value(value: patientBloc),
          ],
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: PatientEditDialog(
              patient: patient,
              onBloodTypeUpdated: onBloodTypeUpdated,
            ),
          ),
        );
      },
    );
  }

  @override
  State<PatientEditDialog> createState() => _PatientEditDialogState();
}

class _PatientEditDialogState extends State<PatientEditDialog> {
  DateTime? _selectedBirthDate;
  String _selectedGender = 'Prefer not to say';
  String _selectedBloodType = 'O+';
  late PatientEditService _patientEditService;
  bool _isLoading = false;
  Patient? _currentPatient;

  final List<String> _genderOptions = ['Male', 'Female', 'Prefer not to say'];
  final List<String> _bloodTypeOptions = [
    'N/A',
    ...BloodTypes.getAllBloodTypes()
  ];

  @override
  void initState() {
    super.initState();
    final recordsRepository = getIt<RecordsRepository>();
    _patientEditService = PatientEditService(recordsRepository);
    _initializeControllers();
    _initializeBloodType();
  }

  void _initializeControllers() {
    final extractedGender =
        FhirFieldExtractor.extractPatientGender(widget.patient);
    _selectedGender = _mapGenderToDisplay(extractedGender);

    _selectedBirthDate =
        FhirFieldExtractor.extractPatientBirthDate(widget.patient);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final blocState = context.read<PatientBloc>().state;
      _currentPatient = blocState.patients.firstWhere(
        (p) => p.id == widget.patient.id,
        orElse: () => widget.patient,
      );

      _selectedBirthDate =
          FhirFieldExtractor.extractPatientBirthDate(_currentPatient!);

      final extractedGender =
          FhirFieldExtractor.extractPatientGender(_currentPatient!);
      _selectedGender = _mapGenderToDisplay(extractedGender);

      _initializeBloodType();
    });
  }

  Future<void> _initializeBloodType() async {
    if (_currentPatient == null) return;

    try {
      final extractedBloodType =
          await _patientEditService.getCurrentBloodType(_currentPatient!);

      if (mounted) {
        setState(() {
          if (extractedBloodType != null && extractedBloodType.isNotEmpty) {
            _selectedBloodType = _bloodTypeOptions.contains(extractedBloodType)
                ? extractedBloodType
                : 'O+';
          } else {
            _selectedBloodType = 'N/A';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _selectedBloodType = 'N/A');
      }
    }
  }

  String _mapGenderToDisplay(String? fhirGender) {
    if (fhirGender == null) return 'Prefer not to say';

    switch (fhirGender.toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      default:
        return 'Prefer not to say';
    }
  }

  @override
  void dispose() {
    if (widget.onBloodTypeUpdated != null) {
      widget.onBloodTypeUpdated!();
    }
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_isLoading || _currentPatient == null) return;

    setState(() => _isLoading = true);

    try {
      final hasChanges = await _patientEditService.hasPatientChanges(
        currentPatient: _currentPatient!,
        newBirthDate: _selectedBirthDate,
        newGender: _selectedGender,
        newBloodType: _selectedBloodType,
      );

      if (!hasChanges) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No changes detected'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
          context.popDialog();
        }
        return;
      }

      if (_selectedBloodType != 'N/A') {
        await _patientEditService.updateBloodTypeObservation(
          _currentPatient!,
          _selectedBloodType,
        );
      }

      await _initializeBloodType();

      if (widget.onBloodTypeUpdated != null) {
        widget.onBloodTypeUpdated!();
      }

      if (mounted) {
        if (_selectedBirthDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a birth date'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        context.read<PatientBloc>().add(
              PatientEditSaved(
                patientId: _currentPatient!.id,
                sourceId: _currentPatient!.sourceId,
                birthDate: _selectedBirthDate!,
                gender: _selectedGender,
                bloodType: _selectedBloodType,
              ),
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Patient details updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        context.popDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving patient data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleCancel() {
    context.read<PatientBloc>().add(const PatientEditCancelled());
    context.popDialog();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final iconColor = context.isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(Insets.medium),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeader(
              textColor: textColor,
              onCancel: _handleCancel,
            ),
            Container(height: 1, color: borderColor),
            DialogContent(
              patient: widget.patient,
              selectedBirthDate: _selectedBirthDate,
              selectedGender: _selectedGender,
              selectedBloodType: _selectedBloodType,
              genderOptions: _genderOptions,
              bloodTypeOptions: _bloodTypeOptions,
              iconColor: iconColor,
              onBirthDateChanged: (date) =>
                  setState(() => _selectedBirthDate = date),
              onGenderChanged: (value) =>
                  setState(() => _selectedGender = value),
              onBloodTypeChanged: (value) =>
                  setState(() => _selectedBloodType = value),
            ),
            const SizedBox(height: Insets.medium),
            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: FormFields.buildActionButtons(
                onCancel: _handleCancel,
                onSave: _handleSave,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
