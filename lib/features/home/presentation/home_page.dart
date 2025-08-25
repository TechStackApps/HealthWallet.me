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
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/home_onboarding_steps.dart';
import 'package:health_wallet/features/home/presentation/widgets/home_section_header.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/preference_modal.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/core/constants/home_constants.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';

import 'package:health_wallet/core/widgets/placeholder_widget.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/navigation/app_router.dart';

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
  late final HomeOnboardingController _onboardingController;
  late final HomeFocusController _focusController;

  final GlobalKey _firstVitalCardKey = GlobalKey();
  final GlobalKey _firstOverviewCardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _onboardingController = HomeOnboardingController();
    _focusController = HomeFocusController();
    _onboardingController.checkIfShouldShowOnboarding();
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
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.hasDataLoaded != current.hasDataLoaded,
      listener: (context, state) {
        if (state.status == const HomeStatus.success() && state.hasDataLoaded) {
          _onboardingController.triggerOnboardingIfNeeded(state);
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
            key: _onboardingController.onboardingKey,
            steps: HomeOnboardingSteps.createSteps(
              firstVitalCardFocusNode: _focusController.firstVitalCardFocusNode,
              firstOverviewCardFocusNode:
                  _focusController.firstOverviewCardFocusNode,
              context: context,
            ),
            onChanged: (index) => print('Onboarding step changed to: $index'),
            onEnd: (index) => _onboardingController.markOnboardingAsSeen(),
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
                              HomeSectionHeader(
                                title: context.l10n.homeVitalSigns,
                                filterLabel: editMode ? 'Filter Vitals' : null,
                                onFilterTap: editMode
                                    ? () => HomeDialogController
                                            .showEditVitalsDialog(
                                          context,
                                          state,
                                          (updated) {
                                            context.read<HomeBloc>().add(
                                                HomeVitalsFiltersChanged(
                                                    updated));
                                          },
                                        )
                                    : null,
                                colorScheme: colorScheme,
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
                              HomeSectionHeader(
                                title: 'Overview',
                                filterLabel: editMode ? 'Filter Records' : null,
                                onFilterTap: editMode
                                    ? () => HomeDialogController
                                            .showEditRecordsDialog(
                                          context,
                                          state,
                                          (newSelection) {
                                            context.read<HomeBloc>().add(
                                                HomeRecordsFiltersChanged(
                                                    newSelection));
                                          },
                                        )
                                    : null,
                                colorScheme: colorScheme,
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
                                    duration:
                                        HomeConstants.pageTransitionDuration,
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
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(height: Insets.smallNormal),
                              RecentRecordsSection(
                                recentRecords: state.recentRecords,
                                onViewAll: () {
                                  widget.pageController.animateToPage(
                                    1,
                                    duration:
                                        HomeConstants.pageTransitionDuration,
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
