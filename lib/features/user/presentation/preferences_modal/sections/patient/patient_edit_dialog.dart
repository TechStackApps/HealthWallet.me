import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';
import 'package:health_wallet/core/constants/blood_types.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'utils/dialog_header.dart';
import 'utils/dialog_content.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'utils/form_fields.dart';
import 'services/patient_edit_service.dart';
import 'utils/gender_mapper.dart';

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
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: BlocProvider.of<UserBloc>(context)),
            BlocProvider.value(value: patientBloc),
            BlocProvider.value(value: homeBloc),
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
  String _selectedGiven = '';
  String _selectedFamily = '';
  DateTime? _selectedBirthDate;
  String _selectedGender = 'Prefer not to say';
  String _selectedBloodType = 'O+';
  String _selectedMRN = '';
  late PatientEditService _patientEditService;
  bool _isLoading = false;
  Patient? _currentPatient;
  
  late TextEditingController _givenController;
  late TextEditingController _familyController;
  late TextEditingController _mrnController;

  List<String> _getGenderOptions(AppLocalizations l10n) =>
      [l10n.male, l10n.female, l10n.preferNotToSay];
  final List<String> _bloodTypeOptions = [
    'N/A',
    ...BloodTypes.getAllBloodTypes()
  ];

  @override
  void initState() {
    super.initState();
    _patientEditService = getIt<PatientEditService>();
    _givenController = TextEditingController(text: _extractGiven(widget.patient));
    _familyController = TextEditingController(text: _extractFamily(widget.patient));
    _mrnController = TextEditingController(text: FhirFieldExtractor.extractPatientMRN(widget.patient));
    _initializeControllers();
    _initializeCurrentPatient();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extractedGender =
        FhirFieldExtractor.extractPatientGender(widget.patient);
    _selectedGender = GenderMapper.mapFhirGenderToDisplay(extractedGender, context.l10n);
  }

  void _initializeControllers() {
    final extractedGender =
        FhirFieldExtractor.extractPatientGender(widget.patient);
    _selectedGender = GenderMapper.mapFhirGenderToDisplayFallback(extractedGender);
    _selectedGiven = _extractGiven(widget.patient);
    _selectedFamily = _extractFamily(widget.patient);

    _selectedBirthDate =
        FhirFieldExtractor.extractPatientBirthDate(widget.patient);
  }

  void _initializeCurrentPatient() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final blocState = context.read<PatientBloc>().state;
      final patientGroup = blocState.patientGroups[widget.patient.id];

      final walletPatient = patientGroup?.allPatientInstances
          .where((p) => p.sourceId.startsWith('wallet'))
          .firstOrNull;

      if (walletPatient != null) {
        _currentPatient = walletPatient;
      } else {
        _currentPatient = patientGroup?.representativePatient ?? widget.patient;
      }

      _selectedGiven = _extractGiven(_currentPatient!);
      _selectedFamily = _extractFamily(_currentPatient!);
      _selectedBirthDate =
          FhirFieldExtractor.extractPatientBirthDate(_currentPatient!);

      final extractedGender =
          FhirFieldExtractor.extractPatientGender(_currentPatient!);
      _selectedGender = GenderMapper.mapFhirGenderToDisplay(extractedGender, context.l10n);

      _selectedMRN = FhirFieldExtractor.extractPatientMRN(_currentPatient!);
      
      _givenController.text = _selectedGiven;
      _familyController.text = _selectedFamily;
      _mrnController.text = _selectedMRN;

      _initializeBloodType();
    });
  }

  String _extractGiven(Patient patient) {
    if (patient.name?.isNotEmpty == true) {
      final given = patient.name!.first.given;
      if (given != null && given.isNotEmpty) {
        return given.map((g) => g.toString()).join(' ');
      }
    }
    return '';
  }

  String _extractFamily(Patient patient) {
    if (patient.name?.isNotEmpty == true) {
      final family = patient.name!.first.family;
      if (family != null) {
        return family.toString();
      }
    }
    return '';
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


  @override
  void dispose() {
    _givenController.dispose();
    _familyController.dispose();
    _mrnController.dispose();
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
        newMRN: _selectedMRN,
        l10n: context.l10n,
      );

      if (!hasChanges) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.noChangesDetected),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
          context.popDialog();
        }
        return;
      }

      final currentBloodType =
          await _patientEditService.getCurrentBloodType(_currentPatient!);
      final currentBirthDate =
          FhirFieldExtractor.extractPatientBirthDate(_currentPatient!);
      final currentGender =
          FhirFieldExtractor.extractPatientGender(_currentPatient!);
      final currentGivenValue = _givenController.text;
      final currentFamilyValue = _familyController.text;
      final currentMRNValue = _mrnController.text;
      
      final currentGiven = _extractGiven(_currentPatient!);
      final currentFamily = _extractFamily(_currentPatient!);
      final currentMRN = FhirFieldExtractor.extractPatientMRN(_currentPatient!);

      final givenChanged = currentGiven != currentGivenValue;
      final familyChanged = currentFamily != currentFamilyValue;
      final nameChanged = givenChanged || familyChanged;
      final birthDateChanged = currentBirthDate != _selectedBirthDate;
      final genderChanged =
          GenderMapper.mapFhirGenderToDisplay(currentGender, context.l10n) != _selectedGender;
      final bloodTypeChanged = currentBloodType != _selectedBloodType;
      final mrnChanged = currentMRN != currentMRNValue;

      final onlyBloodTypeChanged = bloodTypeChanged &&
          !nameChanged &&
          !birthDateChanged &&
          !genderChanged &&
          !mrnChanged;

      if (onlyBloodTypeChanged) {
        await _patientEditService.updateBloodTypeObservation(
          _currentPatient!,
          _selectedBloodType,
        );

        await _initializeBloodType();

        if (widget.onBloodTypeUpdated != null) {
          widget.onBloodTypeUpdated!();
        }

        if (mounted) {
          context.popDialog();
        }
        return;
      }

      if (mounted) {
        final patientFieldsChanged =
            nameChanged || birthDateChanged || genderChanged || mrnChanged;

        if (patientFieldsChanged) {
          if (birthDateChanged && _selectedBirthDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.pleaseSelectBirthDate),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }

          final homeState = context.read<HomeBloc>().state;

          final givenList = currentGivenValue.isNotEmpty
              ? currentGivenValue.split(' ').where((s) => s.isNotEmpty).toList()
              : null;

          context.read<PatientBloc>().add(
                PatientEditSaved(
                  patientId: _currentPatient!.id,
                  sourceId: _currentPatient!.sourceId,
                  given: givenChanged ? givenList : null,
                  family: familyChanged
                      ? (currentFamilyValue.isNotEmpty ? currentFamilyValue : null)
                      : null,
                  birthDate: birthDateChanged ? _selectedBirthDate : null,
                  gender: genderChanged ? _selectedGender : null,
                  bloodType: bloodTypeChanged
                      ? _selectedBloodType
                      : currentBloodType ?? 'N/A',
                  mrn: mrnChanged ? currentMRNValue : null,
                  availableSources: homeState.sources,
                ),
              );
        }

        if (bloodTypeChanged && widget.onBloodTypeUpdated != null && mounted) {
          widget.onBloodTypeUpdated!();
        }

        context.popDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${context.l10n.errorSavingPatientData}: $e'),
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

            Flexible(
              child: _buildPatientForm(iconColor),
            ),

            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: FormFields.buildActionButtons(
                onCancel: _handleCancel,
                onSave: () => _handleSave(),
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientForm(Color iconColor) {
    if (_currentPatient == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DialogContent(
            patient: _currentPatient!,
            showNameField: true,
            selectedGiven: _selectedGiven,
            selectedFamily: _selectedFamily,
            selectedMRN: _selectedMRN,
            selectedBirthDate: _selectedBirthDate,
            selectedGender: _selectedGender,
            selectedBloodType: _selectedBloodType,
            genderOptions: _getGenderOptions(context.l10n),
            bloodTypeOptions: _bloodTypeOptions,
            iconColor: iconColor,
            onGivenChanged: (String value) {
              _selectedGiven = value;
            },
            onFamilyChanged: (String value) {
              _selectedFamily = value;
            },
            onMRNChanged: (String value) {
              _selectedMRN = value;
            },
            givenController: _givenController,
            familyController: _familyController,
            mrnController: _mrnController,
            onBirthDateChanged: (DateTime? date) =>
                setState(() => _selectedBirthDate = date),
            onGenderChanged: (String value) =>
                setState(() => _selectedGender = value),
            onBloodTypeChanged: (String value) =>
                setState(() => _selectedBloodType = value),
          ),
          const SizedBox(height: Insets.medium),
        ],
      ),
    );
  }
}
