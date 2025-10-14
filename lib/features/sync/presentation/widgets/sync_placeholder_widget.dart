import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/widgets/success_dialog.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/user/domain/services/default_patient_service.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';

class SyncPlaceholderWidget extends StatefulWidget {
  final PageController? pageController;
  final VoidCallback? onSyncPressed;
  final String? recordTypeName;

  const SyncPlaceholderWidget({
    super.key,
    this.pageController,
    this.onSyncPressed,
    this.recordTypeName,
  });

  @override
  State<SyncPlaceholderWidget> createState() => _SyncPlaceholderWidgetState();
}

class _SyncPlaceholderWidgetState extends State<SyncPlaceholderWidget> {
  bool _hasInitiatedDemoDataLoading = false;
  SyncBloc? _syncBloc;

  @override
  Widget build(BuildContext context) {
    _syncBloc = context.read<SyncBloc>();

    return BlocListener<SyncBloc, SyncState>(listenWhen: (previous, current) {
      return current.hasDemoData && !current.hasSyncedData;
    }, listener: (context, state) {
      if (state.hasDemoData &&
          !state.hasSyncedData &&
          _hasInitiatedDemoDataLoading) {
        _handleDemoDataCompletion(context);
        _hasInitiatedDemoDataLoading = false; // Reset the flag
      } else {}
    }, child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        final hasVitalDataLoaded = homeState.patientVitals.any(
            (vital) => vital.value != 'N/A' && vital.observationId != null);
        final hasOverviewDataLoaded =
            homeState.overviewCards.any((card) => card.count != '0');
        final hasRecent = homeState.recentRecords.isNotEmpty;
        final hasAnyMeaningfulData =
            hasVitalDataLoaded || hasOverviewDataLoaded || hasRecent;

        return Column(
          children: [
            const SizedBox(height: Insets.medium),
            SizedBox(
              width: 240,
              height: 240,
              child: context.isDarkMode
                  ? Assets.images.placeholderDark.svg(
                      fit: BoxFit.contain,
                    )
                  : Assets.images.placeholder.svg(
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: Insets.large),
            _buildMessageSection(context, hasAnyMeaningfulData),
            const SizedBox(height: Insets.large),
            _buildActionButtons(context, hasAnyMeaningfulData),
          ],
        );
      },
    ));
  }

  Widget _buildMessageSection(BuildContext context, bool hasAnyMeaningfulData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        children: [
          Text(
            _getTitle(context, hasAnyMeaningfulData),
            style: AppTextStyle.titleLarge.copyWith(
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.medium),
          Text(
            _getSubtitle(context, hasAnyMeaningfulData),
            style: AppTextStyle.bodyMedium.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool hasAnyMeaningfulData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      child: Column(
        children: [
          if (!hasAnyMeaningfulData) ...[
            // Get Started button - primary action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handleGetStarted(context),
                icon: Assets.icons.user.svg(
                  width: 16,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                label: Text(
                  context.l10n.getStarted,
                  style: AppTextStyle.buttonMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.medium,
                    vertical: Insets.smallNormal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.small),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: Insets.small),
            // Load Demo Data button - secondary action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handleLoadDemoData(context),
                icon: Assets.icons.cloudDownload.svg(
                  width: 16,
                  height: 16,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                label: Text(
                  context.l10n.loadDemoData,
                  style: AppTextStyle.buttonMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.medium,
                    vertical: Insets.smallNormal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.small),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: Insets.small),
          ],
          // Sync Data button - always visible
          SizedBox(
            width: double.infinity,
            child: hasAnyMeaningfulData
                ? ElevatedButton.icon(
                    onPressed: widget.onSyncPressed ??
                        () => _handleSyncRecords(context),
                    icon: Assets.icons.renewSync.svg(
                      width: 16,
                      height: 16,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    label: Text(
                      context.l10n.syncData,
                      style: AppTextStyle.buttonMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.medium,
                        vertical: Insets.smallNormal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Insets.small),
                      ),
                      elevation: 0,
                    ),
                  )
                : TextButton.icon(
                    onPressed: widget.onSyncPressed ??
                        () => _handleSyncRecords(context),
                    icon: Assets.icons.renewSync.svg(
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        context.isDarkMode
                            ? Colors.white
                            : context.colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      context.l10n.syncData,
                      style: AppTextStyle.buttonMedium.copyWith(
                        color: context.isDarkMode
                            ? Colors.white
                            : context.colorScheme.primary,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _getTitle(BuildContext context, bool hasAnyMeaningfulData) {
    if (hasAnyMeaningfulData && widget.recordTypeName != null) {
      return 'No ${widget.recordTypeName} yet';
    }
    return context.l10n.noMedicalRecordsYet;
  }

  String _getSubtitle(BuildContext context, bool hasAnyMeaningfulData) {
    if (hasAnyMeaningfulData && widget.recordTypeName != null) {
      return 'Sync or update your data to view ${widget.recordTypeName} records';
    }
    return context.l10n.loadDemoDataMessage;
  }

  void _handleLoadDemoData(BuildContext context) async {
    try {
      print('🔵 [DEMO] Step 1: Loading demo data...');
      // 1. Load demo data FIRST (creates demo_data source with demo patient)
      _hasInitiatedDemoDataLoading = true;
      context.read<SyncBloc>().add(const LoadDemoData());

      // 2. Wait for demo data to load
      await Future.delayed(const Duration(milliseconds: 800));
      print('🔵 [DEMO] Step 2: Demo data loaded');

      // 3. Create wallet source and default patient (for later use)
      // Note: Widget may unmount when dialog shows, so we catch errors
      print('🔵 [DEMO] Step 3: Creating wallet source...');
      try {
        await _createWalletSourceAndDefaultPatient();
        await Future.delayed(const Duration(milliseconds: 200));
        print('🔵 [DEMO] Step 4: Wallet source created');
      } catch (e) {
        // Widget unmounted - wallet will be created in _handleDemoDataCompletion
        print('🟡 [DEMO] Widget unmounted during wallet creation (OK)');
      }

      // DON'T do patient/source selection here - widget gets unmounted when dialog shows
      // It will be done in _handleDemoDataCompletion after user clicks OK
      print('🔵 [DEMO] ✅ Data loaded, waiting for user to click OK...');
    } catch (e) {
      print('🔴 [DEMO] Error: $e');
      _hasInitiatedDemoDataLoading = true;
      if (context.mounted) {
        context.read<SyncBloc>().add(const LoadDemoData());
      }
    }
  }

  void _handleDemoDataCompletion(BuildContext context) async {
    // Do ALL setup BEFORE showing the dialog
    // Ensure wallet source exists (in case widget was unmounted during creation)
    print('🔵 [DEMO] Step 4.5: Ensuring wallet source exists...');
    try {
      if (context.mounted) {
        context.read<SyncBloc>().add(const CreateWalletSource());
      }
      await Future.delayed(const Duration(milliseconds: 100));
      final defaultPatientService = getIt<DefaultPatientService>();
      await defaultPatientService.createAndSetAsMain();
      print('🔵 [DEMO] Step 4.6: Wallet source ensured');
    } catch (e) {
      print('🟡 [DEMO] Wallet source might already exist: $e');
    }

    if (!mounted || !context.mounted) return;

    // Show dialog immediately - do NOT change sources/patients yet
    print('🔵 [DEMO] Showing success dialog...');

    // Capture bloc references before showing dialog
    final patientBloc = context.read<PatientBloc>();
    final homeBloc = context.read<HomeBloc>();
    final pageControllerRef = widget.pageController;

    SuccessDialog.show(
      context: context,
      title: context.l10n.success,
      message: context.l10n.demoDataLoadedSuccessfully,
      onOkPressed: () async {
        print(
            '🔵 [DEMO] User clicked OK - setting up demo patient and source...');

        if (_syncBloc != null) {
          try {
            _syncBloc!.add(const DemoDataConfirmed());
          } catch (e) {}
        }

        // Do patient/source setup BEFORE closing dialog
        print('🔵 [DEMO] Step 5: Reloading patients...');
        patientBloc.add(const PatientInitialised());

        await Future.delayed(const Duration(milliseconds: 600));

        final patientState = patientBloc.state;
        print(
            '🔵 [DEMO] Step 6: Selected patient: ${patientState.selectedPatientId}');
        print(
            '🔵 [DEMO] Step 6: Patient groups: ${patientState.patientGroups.keys}');
        print(
            '🔵 [DEMO] Step 6: All patients: ${patientState.patients.map((p) => '${p.id} (${p.sourceId})').toList()}');

        // Check if demo patient is selected, if not, select it explicitly
        print('🔵 [DEMO] Step 6.1: Looking for demo patient...');
        final demoPatients = patientState.patients
            .where((p) => p.sourceId == 'demo_data')
            .toList();
        print(
            '🔵 [DEMO] Step 6.2: Found ${demoPatients.length} demo patients: ${demoPatients.map((p) => '${p.id} (${p.sourceId})').toList()}');

        if (demoPatients.isEmpty) {
          print(
              '🔵 [DEMO] Step 6.3: No demo patients found! Available patients: ${patientState.patients.map((p) => '${p.id} (${p.sourceId})').toList()}');
        } else {
          final demoPatient = demoPatients.first;
          print(
              '🔵 [DEMO] Step 6.4: Demo patient found: ${demoPatient.id} (${demoPatient.sourceId})');

          if (patientState.selectedPatientId != demoPatient.id) {
            print(
                '🔵 [DEMO] Step 6.5: Demo patient not selected, selecting it explicitly...');
            print(
                '🔵 [DEMO] Step 6.6: Current selected: ${patientState.selectedPatientId}, selecting: ${demoPatient.id}');
            patientBloc.add(PatientSelectionChanged(patientId: demoPatient.id));
            await Future.delayed(const Duration(milliseconds: 300));

            // Verify selection
            final newPatientState = patientBloc.state;
            print(
                '🔵 [DEMO] Step 6.7: After selection - Selected patient: ${newPatientState.selectedPatientId}');
          } else {
            print(
                '🔵 [DEMO] Step 6.5: Demo patient already selected: ${demoPatient.id}');
          }
        }

        // Switch to demo_data source - ONLY demo data
        print('🔵 [DEMO] Step 7: Switching to demo_data source...');
        homeBloc.add(
          const HomeSourceChanged('demo_data', patientSourceIds: ['demo_data']),
        );

        await Future.delayed(const Duration(milliseconds: 300));

        print('  - Patient groups: ${finalPatientState.patientGroups.keys}');

        // Close dialog AFTER all setup is complete
        if (context.mounted) {
          Navigator.of(context).pop();
        }

        // Navigate to home page
        if (pageControllerRef != null) {
          pageControllerRef.animateToPage(0,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        } else if (context.mounted) {
          context.router.pop();
        }

        print('🔵 [DEMO] ✅ Complete! Now viewing demo data.');
      },
    );
  }

  void _handleSyncRecords(BuildContext context) {
    if (context.mounted) {
      context.router.push(const SyncRoute());
    }
  }

  void _handleGetStarted(BuildContext context) async {
    try {
      await _createWalletSourceAndDefaultPatient();
      context.read<HomeBloc>().add(const HomeSourceChanged('wallet'));

      // Reload PatientBloc to pick up the new wallet holder patient
      try {
        context.read<PatientBloc>().add(const PatientInitialised());
      } catch (e) {
        // PatientBloc might not be available, continue anyway
      }

      await Future.delayed(const Duration(milliseconds: 500));

      final pageController = widget.pageController;
      if (pageController != null) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        if (context.mounted) {
          context.router.pop();
        }
      }
    } catch (e) {
      final pageController = widget.pageController;
      if (pageController != null) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      } else {
        if (context.mounted) {
          context.router.pop();
        }
      }
    }
  }

  Future<void> _createWalletSourceAndDefaultPatient() async {
    if (!mounted) {
      print('🟡 [DEMO] Skipping wallet creation - widget unmounted');
      return;
    }
    context.read<SyncBloc>().add(const CreateWalletSource());
    await Future.delayed(const Duration(milliseconds: 100));
    final defaultPatientService = getIt<DefaultPatientService>();
    await defaultPatientService.createAndSetAsMain();
  }
}
