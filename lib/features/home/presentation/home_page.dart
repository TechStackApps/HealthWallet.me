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
import 'package:health_wallet/features/home/presentation/widgets/source_label_edit_dialog.dart';
import 'package:health_wallet/features/home/presentation/widgets/section_info_modal.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/preference_modal.dart';
import 'package:health_wallet/features/home/domain/entities/patient_vitals.dart';
import 'package:health_wallet/features/home/core/constants/home_constants.dart';
import 'package:health_wallet/features/sync/presentation/widgets/sync_placeholder_widget.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/navigation/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PatientBloc, PatientState>(
          listenWhen: (previous, current) =>
              previous.selectedPatientSourceId !=
                  current.selectedPatientSourceId ||
              (current.status.toString().contains('Success') &&
                  !current.isEditingPatient),
          listener: (context, patientState) {
            if (patientState.selectedPatientSourceId != null &&
                patientState.selectedPatientSourceId != 'All') {
              context.read<HomeBloc>().add(
                    HomeSourceChanged(patientState.selectedPatientSourceId!),
                  );
            }

            if (patientState.status.toString().contains('Success') &&
                !patientState.isEditingPatient) {
              context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
            }
          },
        ),
      ],
      child: HomeView(pageController: pageController),
    );
  }
}

class HomeView extends StatefulWidget {
  final PageController pageController;
  const HomeView({super.key, required this.pageController});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
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

  void showOnboardingDirectly() {
    _hasShownOnboarding = false;

    if (_onboardingKey.currentState != null) {
      try {
        _onboardingKey.currentState!.show();
      } catch (e) {
        // Handle onboarding error
      }
    }
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());
    await Future.delayed(HomeConstants.refreshDelay);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SyncBloc, SyncState>(
      listenWhen: (previous, current) {
        return (previous.shouldShowTutorial != current.shouldShowTutorial &&
                current.shouldShowTutorial) ||
            (previous.shouldShowTutorial && !current.shouldShowTutorial);
      },
      listener: (context, syncState) {
        if (!syncState.shouldShowTutorial) {
          _hasShownOnboarding = false;
        }

        if (syncState.shouldShowTutorial && !_hasShownOnboarding) {
          _hasShownOnboarding = true;

          context.read<HomeBloc>().add(const HomeRefreshPreservingOrder());

          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted && _onboardingKey.currentState != null) {
              try {
                _onboardingKey.currentState!.show();
              } catch (e) {}
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
              // Reset onboarding state when tutorial ends
              context.read<SyncBloc>().add(const ResetTutorial());

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
                            child: Text(context.l10n.done),
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
      return SyncPlaceholderWidget(
        pageController: widget.pageController,
        onSyncPressed: () {
          context.router.push(const SyncRoute());
        },
        recordTypeName: null, // No specific record type for home page
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height < 700
                            ? Insets.small
                            : Insets.medium),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: context.l10n.homeVitalSigns,
                            filterLabel: editMode ? context.l10n.vitals : null,
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
                            isFilterDisabled: state.vitalsExpanded,
                            onInfoTap: () => SectionInfoModal.show(
                              context,
                              context.l10n.vitalSigns,
                              context.l10n.longPressToReorder,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height < 700
                                  ? Insets.small
                                  : Insets.smallNormal),
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height < 700
                            ? Insets.medium
                            : Insets.large),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: context.l10n.overview,
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
                                    onSourceTap: (source) {
                                      SourceLabelEditDialog.show(
                                        context,
                                        source,
                                        (newLabel) {
                                          context.read<HomeBloc>().add(
                                                HomeSourceLabelUpdated(
                                                    source.id, newLabel),
                                              );
                                        },
                                      );
                                    },
                                  )
                                : null,
                            filterLabel: context.l10n.records,
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
                            onInfoTap: () => SectionInfoModal.show(
                              context,
                              context.l10n.overview,
                              context.l10n.longPressToReorder,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height < 700
                                  ? Insets.small
                                  : Insets.smallNormal),
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height < 700
                            ? Insets.medium
                            : Insets.large),
                    if (state.hasDataLoaded || editMode)
                      Column(
                        children: [
                          HomeSectionHeader(
                            title: context.l10n.recentRecords,
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
                                context.l10n.viewAll,
                                style: AppTextStyle.labelLarge.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                            colorScheme: colorScheme,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height < 700
                                  ? Insets.small
                                  : Insets.smallNormal),
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
