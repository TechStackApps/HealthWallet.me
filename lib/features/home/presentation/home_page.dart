import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/filter_home_dialog.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/home/presentation/widgets/source_selector_widget.dart';
import 'package:health_wallet/core/widgets/placeholder_widget.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          previous.selectedPatientSourceId != current.selectedPatientSourceId ||
          previous.selectedPatientId != current.selectedPatientId,
      listener: (context, userState) {
        if (userState.selectedPatientSourceId != null) {
          context.read<HomeBloc>().add(HomePatientSelected(
                userState.selectedPatientSourceId,
                null,
              ));
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
  final GlobalKey _vitalsSectionKey = GlobalKey();
  final GlobalKey _overviewSectionKey = GlobalKey();
  final GlobalKey _firstVitalCardKey = GlobalKey();
  final GlobalKey _firstOverviewCardKey = GlobalKey();
  final GlobalKey<OnboardingState> onboardingKey = GlobalKey<OnboardingState>();
  bool _shouldShowOnboarding = false;
  bool _hasTriggeredOnboarding = false; // Add this flag
  late FocusNode _firstVitalCardFocusNode;
  late FocusNode _firstOverviewCardFocusNode;

  @override
  void initState() {
    super.initState();
    _firstVitalCardFocusNode = FocusNode(debugLabel: 'First Vital Card');
    _firstOverviewCardFocusNode = FocusNode(debugLabel: 'First Overview Card');
    _checkIfShouldShowOnboarding();
  }

  @override
  void dispose() {
    _firstVitalCardFocusNode.dispose();
    _firstOverviewCardFocusNode.dispose();
    super.dispose();
  }

  Future<void> _checkIfShouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding =
        prefs.getBool('has_seen_reorder_onboarding') ?? false;
    if (mounted) {
      setState(() {
        _shouldShowOnboarding = !hasSeenOnboarding;
        _hasTriggeredOnboarding = false; // Reset when checking
      });
    }
  }

  void _triggerOnboarding(HomeState state) {
    // Fix 1: Add more comprehensive conditions and prevent multiple triggers
    if (_shouldShowOnboarding &&
        state.hasDataLoaded &&
        !_hasTriggeredOnboarding &&
        state.patientVitals.isNotEmpty && // Ensure we have vitals to show
        state.overviewCards.isNotEmpty) {
      // Ensure we have overview cards

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_hasTriggeredOnboarding) {
          _hasTriggeredOnboarding =
              true; // Set flag to prevent multiple triggers
          Future.delayed(const Duration(milliseconds: 1200), () {
            // Increased delay
            if (mounted && _shouldShowOnboarding) {
              print(
                  '🎯 Triggering onboarding with vitals: ${state.patientVitals.length}, cards: ${state.overviewCards.length}');
              onboardingKey.currentState?.show();
            }
          });
        }
      });
    }
  }

  Future<void> _markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      await prefs.setBool('has_seen_reorder_onboarding', true);
      setState(() {
        _shouldShowOnboarding = false;
        _hasTriggeredOnboarding = true;
      });
    }
  }

  List<OnboardingStep> _createOnboardingSteps() {
    return [
      OnboardingStep(
        focusNode: _firstVitalCardFocusNode,
        titleText: 'Reorder Vital Signs',
        bodyText:
            'Long press on vital cards to reorder them according to your preference.',
        fullscreen: false,
        overlayColor: Colors.black.withOpacity(0.7),
        overlayShape: const CircleBorder(),
        hasLabelBox: true,
        labelBoxDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        labelBoxPadding: const EdgeInsets.all(16),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        arrowPosition: ArrowPosition.bottomCenter,
      ),
      OnboardingStep(
        focusNode: _firstOverviewCardFocusNode,
        titleText: 'Reorder Overview Cards',
        bodyText:
            'Long press on overview cards to reorder them as well. Customize your dashboard!',
        fullscreen: false,
        overlayColor: Colors.black.withOpacity(0.7),
        overlayShape: const CircleBorder(),
        hasLabelBox: true,
        labelBoxDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        labelBoxPadding: const EdgeInsets.all(16),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        arrowPosition: ArrowPosition.topCenter,
      ),
    ];
  }

  void _showEditRecordsDialog(HomeState state) {
    showDialog(
      context: context,
      builder: (context) {
        return FilterHomeDialog(
          type: FilterHomeType.records,
          selectedRecords: state.selectedRecordTypes,
          orderedRecords: state.overviewCards
              .map((c) => c.category)
              .toList(growable: false),
          onRecordsSaved: (newSelection) {
            context
                .read<HomeBloc>()
                .add(HomeRecordsFiltersChanged(newSelection));
          },
        );
      },
    );
  }

  void _showEditVitalsDialog(HomeState state) {
    showDialog(
      context: context,
      builder: (context) {
        final displayedOrder = state.patientVitals
            .map((v) => PatientVitalTypeX.fromTitle(v.title))
            .whereType<PatientVitalType>()
            .toList(growable: false);
        final remaining = state.selectedVitals.keys
            .where((k) => !displayedOrder.contains(k))
            .toList(growable: false);
        final orderedVitals = [...displayedOrder, ...remaining];
        return FilterHomeDialog(
          type: FilterHomeType.vitals,
          selectedVitals: state.selectedVitals,
          orderedVitals: orderedVitals,
          onVitalsSaved: (updated) {
            context.read<HomeBloc>().add(HomeVitalsFiltersChanged(updated));
          },
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.hasDataLoaded != current.hasDataLoaded, // Add this condition
      listener: (context, state) {
        if (state.status == const HomeStatus.success() && state.hasDataLoaded) {
          // Reset onboarding trigger when data changes
          if (!_hasTriggeredOnboarding) {
            _triggerOnboarding(state);
          }
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
            key: onboardingKey,
            steps: _createOnboardingSteps(),
            onChanged: (int index) {
              print('Onboarding step changed to: $index');
            },
            onEnd: (int index) {
              _markOnboardingAsSeen();
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
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        return BlocBuilder<SyncBloc, SyncState>(
                          builder: (context, syncState) {
                            final displayName = userState.user.name.isNotEmpty
                                ? userState.user.name
                                : (syncState.serverUsername?.isNotEmpty == true
                                    ? syncState.serverUsername!
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
                                        color: context.colorScheme.primary),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
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
                child: Stack(
                  children: [
                    _buildDashboardContent(
                      context,
                      context.textTheme,
                      context.colorScheme,
                      state,
                      state.editMode,
                    ),
                    if (state.status.runtimeType ==
                        HomeStatus.failure(Exception()).runtimeType)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: MaterialBanner(
                          backgroundColor: context.colorScheme.errorContainer,
                          content: Text(
                            state.errorMessage ?? 'Error loading data.',
                            style: TextStyle(
                                color: context.colorScheme.onErrorContainer),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(const HomeInitialised()),
                              child: Text(
                                'Retry',
                                style: TextStyle(
                                    color: context.colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
        Container(
          color: context.colorScheme.surface,
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.normal,
            vertical: Insets.small,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              Patient? selectedPatient;
              if (userState.selectedPatientId != null &&
                  userState.patients.isNotEmpty) {
                try {
                  selectedPatient = userState.patients.firstWhere(
                    (p) => p.id == userState.selectedPatientId,
                  );
                } catch (e) {
                  selectedPatient = userState.patients.isNotEmpty
                      ? userState.patients.first
                      : null;
                }
              } else if (userState.patients.isNotEmpty) {
                selectedPatient = userState.patients.first;
              }
              final selectedPatientName = selectedPatient != null
                  ? selectedPatient.displayTitle
                  : 'No patient selected';
              return Text(
                'Patient: $selectedPatientName',
                style: AppTextStyle.bodyMedium.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              );
            },
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
                    BlocBuilder<RecordsBloc, RecordsState>(
                      builder: (context, recordsState) {
                        if (state.hasDataLoaded || editMode) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.l10n.homeVitalSigns,
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                  if (editMode)
                                    InkWell(
                                      onTap: () => _showEditVitalsDialog(state),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Insets.small,
                                          vertical: Insets.extraSmall,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              colorScheme.primary.withAlpha(45),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Assets.icons.filter.svg(
                                              colorFilter: ColorFilter.mode(
                                                context.colorScheme.primary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Filter Vitals',
                                              style: AppTextStyle.bodySmall
                                                  .copyWith(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: Insets.smallNormal),
                              VitalsSection(
                                key: _vitalsSectionKey,
                                vitals: state.vitalsExpanded
                                    ? state.allAvailableVitals
                                    : state.patientVitals,
                                allAvailableVitals: state.allAvailableVitals,
                                editMode: editMode,
                                vitalsExpanded: state.vitalsExpanded,
                                firstCardKey: _firstVitalCardKey,
                                secondCardKey:
                                    null, // Removed for now, add back if needed
                                firstCardFocusNode:
                                    _firstVitalCardFocusNode, // Pass FocusNode
                                selectedVitals: Map.fromEntries(
                                  state.selectedVitals.entries.map(
                                    (e) => MapEntry(e.key.title, e.value),
                                  ),
                                ),
                                onReorder: (oldIndex, newIndex) {
                                  context.read<HomeBloc>().add(
                                      HomeVitalsReordered(oldIndex, newIndex));
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
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: Insets.large),
                    BlocBuilder<RecordsBloc, RecordsState>(
                      builder: (context, recordsState) {
                        if (state.hasDataLoaded || editMode) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Overview',
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                  if (editMode)
                                    InkWell(
                                      onTap: () =>
                                          _showEditRecordsDialog(state),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Insets.small,
                                          vertical: Insets.extraSmall,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              colorScheme.primary.withAlpha(45),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Assets.icons.filter.svg(
                                              colorFilter: ColorFilter.mode(
                                                context.colorScheme.primary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Filter Records',
                                              style: AppTextStyle.bodySmall
                                                  .copyWith(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else if (state.sources.isNotEmpty)
                                    BlocBuilder<UserBloc, UserState>(
                                      builder: (context, userState) {
                                        Patient? currentPatient;
                                        if (userState.selectedPatientId !=
                                                null &&
                                            userState.patients.isNotEmpty) {
                                          try {
                                            currentPatient =
                                                userState.patients.firstWhere(
                                              (p) =>
                                                  p.id ==
                                                  userState.selectedPatientId,
                                            );
                                          } catch (e) {
                                            currentPatient =
                                                userState.patients.isNotEmpty
                                                    ? userState.patients.first
                                                    : null;
                                          }
                                        } else if (userState
                                            .patients.isNotEmpty) {
                                          currentPatient =
                                              userState.patients.first;
                                        }

                                        return SourceSelectorWidget(
                                          sources: state.sources,
                                          selectedSource: state.selectedSource,
                                          onSourceChanged: (String newSource) {
                                            context.read<HomeBloc>().add(
                                                HomeSourceChanged(newSource));
                                          },
                                          currentPatient: currentPatient,
                                        );
                                      },
                                    )
                                  else
                                    Builder(
                                      builder: (context) {
                                        return Text(
                                          'No sources available',
                                          style:
                                              AppTextStyle.bodySmall.copyWith(
                                            color: context.colorScheme.onSurface
                                                .withOpacity(0.6),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: Insets.smallNormal),
                              MedicalRecordsSection(
                                key: _overviewSectionKey,
                                overviewCards: filteredCards,
                                editMode: editMode,
                                firstCardKey: _firstOverviewCardKey,
                                firstCardFocusNode:
                                    _firstOverviewCardFocusNode, // Pass FocusNode
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
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<RecordsBloc, RecordsState>(
                      builder: (context, recordsState) {
                        if (!state.hasDataLoaded) {
                          return PlaceholderWidget(
                            hasRealData: false,
                            colorScheme: colorScheme,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: Insets.large),
                    BlocBuilder<RecordsBloc, RecordsState>(
                      builder: (context, recordsState) {
                        if (state.recentRecords.isNotEmpty ||
                            state.hasDataLoaded ||
                            editMode) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recent records',
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      widget.pageController.animateToPage(
                                        1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          context.colorScheme.primary,
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'View all',
                                      style: AppTextStyle.labelLarge.copyWith(
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Insets.smallNormal),
                              RecentRecordsSection(
                                recentRecords: state.recentRecords,
                                onViewAll: () {
                                  widget.pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                onTapRecord: (record) {
                                  context.router.push(
                                      RecordDetailsRoute(resource: record));
                                },
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 116),
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
