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

class _PatientEditDialogState extends State<PatientEditDialog>
    with TickerProviderStateMixin {
  String _selectedName = '';
  DateTime? _selectedBirthDate;
  String _selectedGender = 'Prefer not to say';
  String _selectedBloodType = 'O+';
  late PatientEditService _patientEditService;
  bool _isLoading = false;
  Patient? _currentPatient;
  late TabController _tabController;
  List<PatientSourceTab> _sourceTabs = [];

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

    // Initialize with default tab (will be updated in post-frame callback)
    _sourceTabs.add(PatientSourceTab(
      label: 'Wallet',
      patient: widget.patient,
      isEditable: true,
      icon: Icons.edit,
    ));

    _tabController = TabController(
      length: _sourceTabs.length,
      vsync: this,
      initialIndex: 0,
    );

    _initializeControllers();
    _initializeBloodType();
    _initializeSourceTabs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update gender options with localized values once context is available
    final extractedGender =
        FhirFieldExtractor.extractPatientGender(widget.patient);
    _selectedGender = _mapGenderToDisplay(extractedGender, context.l10n);
  }

  void _initializeControllers() {
    final extractedGender =
        FhirFieldExtractor.extractPatientGender(widget.patient);
    // Initialize with default values, will be updated in didChangeDependencies
    _selectedGender = _mapGenderToDisplayFallback(extractedGender);
    _selectedName = widget.patient.displayTitle;

    _selectedBirthDate =
        FhirFieldExtractor.extractPatientBirthDate(widget.patient);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final blocState = context.read<PatientBloc>().state;
      _currentPatient = blocState.patients.firstWhere(
        (p) => p.id == widget.patient.id,
        orElse: () => widget.patient,
      );

      _selectedName = _currentPatient!.displayTitle;
      _selectedBirthDate =
          FhirFieldExtractor.extractPatientBirthDate(_currentPatient!);

      final extractedGender =
          FhirFieldExtractor.extractPatientGender(_currentPatient!);
      _selectedGender = _mapGenderToDisplay(extractedGender, context.l10n);

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

  String _mapGenderToDisplay(String? fhirGender, AppLocalizations l10n) {
    if (fhirGender == null) return l10n.preferNotToSay;

    switch (fhirGender.toLowerCase()) {
      case 'male':
        return l10n.male;
      case 'female':
        return l10n.female;
      default:
        return l10n.preferNotToSay;
    }
  }

  String _mapGenderToDisplayFallback(String? fhirGender) {
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

  void _initializeSourceTabs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final patientState = context.read<PatientBloc>().state;
      final homeState = context.read<HomeBloc>().state;

      final patientGroup = patientState.patientGroups[widget.patient.id];

      final newSourceTabs = <PatientSourceTab>[];

      // 1. Wallet tab (always first, editable)
      final walletPatient = patientGroup?.allPatientInstances
          .where((p) => p.sourceId.startsWith('wallet'))
          .firstOrNull;

      // Get read-only patient to use as template for wallet tab
      final readOnlyPatient = patientGroup?.allPatientInstances
              .where((p) => !p.sourceId.startsWith('wallet'))
              .firstOrNull ??
          widget.patient;

      if (walletPatient != null) {
        // Existing wallet patient - show wallet data
        newSourceTabs.add(PatientSourceTab(
          label: 'Wallet',
          patient: walletPatient,
          isEditable: true,
          icon: Icons.edit,
        ));
      } else {
        // No wallet patient yet - use read-only data as template
        // This pre-fills the wallet tab with Epic/Cerner values
        newSourceTabs.add(PatientSourceTab(
          label: 'Wallet (New)',
          patient: readOnlyPatient,
          isEditable: true,
          icon: Icons.add,
        ));
      }

      // 2. Read-only source tabs
      final readOnlyPatients = patientGroup?.allPatientInstances
              .where((p) => !p.sourceId.startsWith('wallet'))
              .toList() ??
          [];

      for (final patient in readOnlyPatients) {
        final source = homeState.sources.firstWhere(
          (s) => s.id == patient.sourceId,
          orElse: () => homeState.sources.first,
        );
        newSourceTabs.add(PatientSourceTab(
          label: source.labelSource ?? 'External',
          patient: patient,
          isEditable: false,
          icon: Icons.lock,
        ));
      }

      // Only update if tabs changed
      if (newSourceTabs.length != _sourceTabs.length) {
        setState(() {
          _sourceTabs = newSourceTabs;

          // Dispose old controller and create new one with correct length
          _tabController.dispose();
          _tabController = TabController(
            length: _sourceTabs.length,
            vsync: this,
            initialIndex: 0,
          );
        });
      } else {
        // Same length, just update tabs without recreating controller
        setState(() {
          _sourceTabs = newSourceTabs;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      final currentName = _currentPatient!.displayTitle;

      final nameChanged = currentName != _selectedName;
      final birthDateChanged = currentBirthDate != _selectedBirthDate;
      final genderChanged =
          _mapGenderToDisplay(currentGender, context.l10n) != _selectedGender;
      final bloodTypeChanged = currentBloodType != _selectedBloodType;

      if (bloodTypeChanged) {
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
        if (birthDateChanged || genderChanged) {
          if (_selectedBirthDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.pleaseSelectBirthDate),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
        }

        if (nameChanged ||
            birthDateChanged ||
            genderChanged ||
            bloodTypeChanged) {
          // Get available sources from HomeBloc
          final homeState = context.read<HomeBloc>().state;

          context.read<PatientBloc>().add(
                PatientEditSaved(
                  patientId: _currentPatient!.id,
                  sourceId: _currentPatient!.sourceId,
                  name: nameChanged ? _selectedName : null,
                  birthDate: _selectedBirthDate ?? DateTime.now(),
                  gender: _selectedGender,
                  bloodType: _selectedBloodType,
                  availableSources: homeState.sources,
                ),
              );
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

  bool get _isOnEditableTab {
    if (_sourceTabs.isEmpty) return true;
    if (_sourceTabs.length == 1) return _sourceTabs.first.isEditable;
    return _sourceTabs[_tabController.index].isEditable;
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

            // TabBar (only if multiple sources)
            if (_sourceTabs.length > 1)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primary,
                  labelColor: textColor,
                  unselectedLabelColor: textColor.withOpacity(0.6),
                  tabs: _sourceTabs
                      .map((tab) => Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(tab.icon, size: 14),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    tab.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),

            // TabBarView or single form
            Flexible(
              child: _sourceTabs.length > 1
                  ? TabBarView(
                      controller: _tabController,
                      children: _sourceTabs
                          .map((tab) => _buildPatientForm(tab, iconColor))
                          .toList(),
                    )
                  : _buildPatientForm(_sourceTabs.first, iconColor),
            ),

            // Action buttons (only enabled for wallet tab)
            Padding(
              padding: const EdgeInsets.all(Insets.normal),
              child: FormFields.buildActionButtons(
                onCancel: _handleCancel,
                onSave: _isOnEditableTab ? () => _handleSave() : null,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientForm(PatientSourceTab tab, Color iconColor) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!tab.isEditable)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              color: Colors.orange.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: Colors.orange, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Read-only data from ${tab.label}. Switch to Wallet tab to edit.',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          DialogContent(
            patient: tab.patient,
            showNameField: tab.isEditable,
            selectedName:
                tab.isEditable ? _selectedName : tab.patient.displayTitle,
            selectedBirthDate: tab.isEditable
                ? _selectedBirthDate
                : FhirFieldExtractor.extractPatientBirthDate(tab.patient),
            selectedGender: tab.isEditable
                ? _selectedGender
                : _mapGenderToDisplay(
                    FhirFieldExtractor.extractPatientGender(tab.patient),
                    context.l10n,
                  ),
            selectedBloodType: tab.isEditable
                ? _selectedBloodType
                : 'N/A', // Read-only tabs show N/A for blood type
            genderOptions: _getGenderOptions(context.l10n),
            bloodTypeOptions: _bloodTypeOptions,
            iconColor: iconColor,
            onNameChanged: tab.isEditable
                ? ((String value) => setState(() => _selectedName = value))
                : null,
            onBirthDateChanged: tab.isEditable
                ? ((DateTime? date) =>
                    setState(() => _selectedBirthDate = date))
                : null,
            onGenderChanged: tab.isEditable
                ? ((String value) => setState(() => _selectedGender = value))
                : null,
            onBloodTypeChanged: tab.isEditable
                ? ((String value) => setState(() => _selectedBloodType = value))
                : null,
          ),
          const SizedBox(height: Insets.medium),
        ],
      ),
    );
  }
}

/// Represents a patient instance from a specific source
class PatientSourceTab {
  final String label;
  final Patient patient;
  final bool isEditable;
  final IconData icon;

  const PatientSourceTab({
    required this.label,
    required this.patient,
    required this.isEditable,
    required this.icon,
  });
}
