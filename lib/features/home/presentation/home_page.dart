import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/home/presentation/widgets/home_dialog_controller.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/sections/patient/bloc/patient_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/home_onboarding_steps.dart';
import 'package:health_wallet/features/home/presentation/widgets/home_section_header.dart';
import 'package:health_wallet/features/home/presentation/widgets/source_selector_widget.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/preference_modal.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/core/constants/home_constants.dart';
import 'package:health_wallet/core/widgets/placeholder_widget.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/navigation/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientBloc, PatientState>(
      listenWhen: (previous, current) =>
          previous.selectedPatientSourceId != current.selectedPatientSourceId ||
          (current.status.toString().contains('Success') &&
              !current.isEditingPatient),
      listener: (context, patientState) {
        // Handle patient source changes
        if (patientState.selectedPatientSourceId != null &&
            patientState.selectedPatientSourceId != 'All') {
          context.read<HomeBloc>().add(
                HomeSourceChanged(patientState.selectedPatientSourceId!),
              );
        }

        // Handle patient data updates
        if (patientState.status.toString().contains('Success') &&
            !patientState.isEditingPatient) {
          context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
        }
      },
      child: HomeView(pageController: pageController),
    );
  }
}

class HomeView extends StatefulWidget {
  final PageController pageController;
  const HomeView({super.key, required this.pageController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeFocusController _focusController;
  final GlobalKey<OnboardingState> _onboardingKey =
      GlobalKey<OnboardingState>();

  final GlobalKey _firstVitalCardKey = GlobalKey();
  final GlobalKey _firstOverviewCardKey = GlobalKey();

  bool _hasShownOnboarding = false;

  @override
  void initState() {
    super.initState();
    _focusController = HomeFocusController();
  }

  @override
  void dispose() {
    _focusController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
    await Future.delayed(HomeConstants.refreshDelay);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncBloc, SyncState>(
      listenWhen: (previous, current) {
        return (previous.isLoadingDemoData != current.isLoadingDemoData &&
                !current.isLoadingDemoData &&
                current.hasDemoData &&
                current.demoDataError == null) ||
            (previous.shouldShowOnboarding != current.shouldShowOnboarding &&
                current.shouldShowOnboarding);
      },
      listener: (context, syncState) {
        if (syncState.shouldShowOnboarding && !_hasShownOnboarding) {
          _hasShownOnboarding = true;

          context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              if (_onboardingKey.currentState != null) {
                try {
                  _onboardingKey.currentState!.show();
                } catch (e) {
                  // Silently handle onboarding overlay error
                }
              } else {}
            }
          });
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status.runtimeType ==
              const HomeStatus.initial().runtimeType) {
            return Scaffold(
              backgroundColor: context.colorScheme.surface,
              body: Center(
                child: CircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
              ),
            );
          }

          return Onboarding(
            key: _onboardingKey,
            steps: HomeOnboardingSteps.createSteps(
              firstVitalCardFocusNode: _focusController.firstVitalCardFocusNode,
              firstOverviewCardFocusNode:
                  _focusController.firstOverviewCardFocusNode,
              context: context,
            ),
            onChanged: (index) {
              // Onboarding step changed
            },
            onEnd: (index) async {
              context.read<SyncBloc>().resetOnboardingState();

              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_shown', true);

              _hasShownOnboarding = false;
            },
            child: Scaffold(
              backgroundColor: context.colorScheme.surface,
              extendBody: true,
              appBar: AppBar(
                backgroundColor: context.colorScheme.surface,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, userState) {
                              return BlocBuilder<SyncBloc, SyncState>(
                                builder: (context, syncState) {
                                  final displayName =
                                      userState.user.name.isNotEmpty
                                          ? userState.user.name
                                          : (syncState.syncQrData?.tokenMeta
                                                      .fullName.isNotEmpty ==
                                                  true
                                              ? syncState.syncQrData!.tokenMeta
                                                  .fullName
                                              : 'User');
                                  return RichText(
                                    text: TextSpan(
                                      style: AppTextStyle.titleMedium.copyWith(
                                        color: context.colorScheme.onSurface,
                                      ),
                                      children: [
                                        TextSpan(text: context.l10n.homeHi),
                                        TextSpan(
                                            text: displayName,
                                            style: TextStyle(
                                                color: context
                                                    .colorScheme.primary)),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    state.editMode
                        ? TextButton(
                            onPressed: () => context
                                .read<HomeBloc>()
                                .add(const HomeEditModeChanged(false)),
                            style: TextButton.styleFrom(
                              foregroundColor: context.colorScheme.primary,
                            ),
                            child: const Text('Done'),
                          )
                        : Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: IconButton(
                              icon: Assets.icons.settings.svg(
                                colorFilter: ColorFilter.mode(
                                  context.colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {
                                PreferenceModal.show(context);
                              },
                              padding: EdgeInsets.zero,
                            ),
                          ),
                  ],
                ),
                actions: const [],
              ),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                color: context.colorScheme.primary,
                child: _buildHomeContent(context, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeState state) {
    final hasVitalDataLoaded = state.patientVitals
        .any((vital) => vital.value != 'N/A' && vital.observationId != null);

    final hasOverviewDataLoaded =
        state.overviewCards.any((card) => card.count != '0');

    final hasRecent = state.recentRecords.isNotEmpty;

    if (!hasVitalDataLoaded && !hasOverviewDataLoaded && !hasRecent) {
      return PlaceholderWidget(
        hasDataLoaded: false,
        colorScheme: context.colorScheme,
        pageController: widget.pageController, // Pass the PageController
        onSyncPressed: () {
          context.router.push(const SyncRoute());
        },
      );
    }

    return _buildDashboardContent(
      context,
      context.textTheme,
      context.colorScheme,
      state,
      state.editMode,
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    HomeState state,
    bool editMode,
  ) {
    final filteredCards = state.overviewCards
        .where((card) => state.selectedRecordTypes[card.category] ?? false)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.hasDataLoaded)
          Container(
            color: context.colorScheme.surface,
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.normal,
              vertical: Insets.small,
            ),
            child: Text(
              'Patient: ${state.patient?.displayTitle ?? 'Loading...'}',
              style: AppTextStyle.bodyMedium.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: Insets.medium),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: context.l10n.homeVitalSigns,
                            filterLabel: editMode ? 'Filter Vitals' : null,
                            onFilterTap: editMode
                                ? () =>
                                    HomeDialogController.showEditVitalsDialog(
                                      context,
                                      state,
                                      (updated) {
                                        context.read<HomeBloc>().add(
                                            HomeVitalsFiltersChanged(updated));
                                      },
                                    )
                                : null,
                            colorScheme: colorScheme,
                            isEditMode: editMode,
                          ),
                          const SizedBox(height: Insets.smallNormal),
                          VitalsSection(
                            vitals: state.vitalsExpanded
                                ? state.allAvailableVitals
                                : state.patientVitals,
                            allAvailableVitals: state.allAvailableVitals,
                            editMode: editMode,
                            vitalsExpanded: state.vitalsExpanded,
                            firstCardKey: _firstVitalCardKey,
                            firstCardFocusNode:
                                _focusController.firstVitalCardFocusNode,
                            selectedVitals: Map.fromEntries(
                              state.selectedVitals.entries.map(
                                (e) => MapEntry(e.key.title, e.value),
                              ),
                            ),
                            onReorder: (oldIndex, newIndex) {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeVitalsReordered(oldIndex, newIndex));
                            },
                            onLongPressCard: () => context
                                .read<HomeBloc>()
                                .add(const HomeEditModeChanged(true)),
                            onExpandToggle: () {
                              context
                                  .read<HomeBloc>()
                                  .add(const HomeVitalsExpansionToggled());
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: Insets.large),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: 'Overview',
                            subtitle: state.sources.isNotEmpty
                                ? SourceSelectorWidget(
                                    sources: state.sources,
                                    selectedSource: state.selectedSource,
                                    onSourceChanged: (sourceId) {
                                      context
                                          .read<HomeBloc>()
                                          .add(HomeSourceChanged(sourceId));
                                    },
                                    currentPatient: state.patient,
                                  )
                                : null,
                            filterLabel: 'Filter Records',
                            onFilterTap: () =>
                                HomeDialogController.showEditRecordsDialog(
                              context,
                              state,
                              (newSelection) {
                                context.read<HomeBloc>().add(
                                    HomeRecordsFiltersChanged(newSelection));
                              },
                            ),
                            colorScheme: colorScheme,
                            isEditMode: editMode,
                          ),
                          const SizedBox(height: Insets.smallNormal),
                          MedicalRecordsSection(
                            overviewCards: filteredCards,
                            editMode: editMode,
                            firstCardKey: _firstOverviewCardKey,
                            firstCardFocusNode:
                                _focusController.firstOverviewCardFocusNode,
                            onLongPressCard: () => context
                                .read<HomeBloc>()
                                .add(const HomeEditModeChanged(true)),
                            onReorder: (oldIndex, newIndex) {
                              context.read<HomeBloc>().add(
                                  HomeRecordsReordered(oldIndex, newIndex));
                            },
                            onTapCard: (card) {
                              context.read<RecordsBloc>().add(
                                  RecordsFiltersApplied(
                                      card.category.resourceTypes));
                              widget.pageController.animateToPage(
                                1,
                                duration: HomeConstants.pageTransitionDuration,
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: Insets.large),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: 'Recent records',
                            trailing: TextButton(
                              onPressed: () {
                                widget.pageController.animateToPage(
                                  1,
                                  duration:
                                      HomeConstants.pageTransitionDuration,
                                  curve: Curves.ease,
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: context.colorScheme.primary,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'View all',
                                style: AppTextStyle.labelLarge.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: Insets.smallNormal),
                          RecentRecordsSection(
                            recentRecords: state.recentRecords,
                            onViewAll: () {
                              widget.pageController.animateToPage(
                                1,
                                duration: HomeConstants.pageTransitionDuration,
                                curve: Curves.ease,
                              );
                            },
                            onTapRecord: (record) {
                              context.router
                                  .push(RecordDetailsRoute(resource: record));
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: HomeConstants.bottomPadding),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
