import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/preferences_modal/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/home/presentation/widgets/edit_records_dialog.dart';
import 'package:health_wallet/features/home/presentation/sections/vitals_section.dart';
import 'package:health_wallet/features/home/presentation/sections/medical_records_section.dart';
import 'package:health_wallet/features/home/presentation/sections/recent_records_section.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/records/domain/factory/entity_factories/patient_entity_display_factory.dart';

import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/home/presentation/widgets/source_selector_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) {
            // Only listen when patient selection changes, not on theme changes
            return previous.selectedPatientSourceId !=
                    current.selectedPatientSourceId ||
                previous.selectedPatientId != current.selectedPatientId;
          },
          listener: (context, userState) {
            // Notify HomeBloc about the patient selection change using sourceId
            if (userState.selectedPatientSourceId != null) {
              context.read<HomeBloc>().add(HomePatientSelected(
                    userState.selectedPatientSourceId,
                    null, // HomeBloc will extract the name
                  ));
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
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _patientFactory = PatientEntityDisplayFactory();

  void _showEditRecordsDialog(HomeState state) {
    showDialog(
      context: context,
      builder: (context) {
        return EditRecordsDialog(
          selectedResources: state.selectedRecordTypes,
          onSelectionChanged: (newSelection) {
            context.read<HomeBloc>().add(HomeFiltersChanged(newSelection));
          },
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    // Trigger data refresh
    context.read<HomeBloc>().add(const HomeInitialised());

    // Check for sync token updates
    context.read<SyncBloc>().add(const SyncEvent.checkTokenStatus());

    // Check connection validity
    context.read<SyncBloc>().add(const SyncEvent.checkConnectionValidity());

    // Small delay to allow the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final editMode = state.editMode;
        if (state.status.runtimeType == HomeStatus.initial().runtimeType) {
          return Scaffold(
            backgroundColor: context.colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.primary,
              ),
            ),
          );
        }
        return Scaffold(
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
                    return RichText(
                      text: TextSpan(
                        style: AppTextStyle.titleMedium.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(text: context.l10n.homeHi),
                          TextSpan(
                            text: userState.user.name.isNotEmpty
                                ? userState.user.name
                                : 'User',
                            style:
                                TextStyle(color: context.colorScheme.primary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                editMode
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
                  editMode,
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
                        'Error loading data.',
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
                            style:
                                TextStyle(color: context.colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
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
        // Patient Info Section
        Container(
          color: context.colorScheme.surface,
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.normal,
            vertical: Insets.small,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              Patient? selectedPatient;
              if (userState.selectedPatientId != null) {
                try {
                  selectedPatient = userState.patients.firstWhere(
                    (p) => p.id == userState.selectedPatientId,
                  );
                } catch (e) {
                  // If selected patient not found, use first patient if available
                  selectedPatient = userState.patients.isNotEmpty
                      ? userState.patients.first
                      : null;
                }
              } else {
                // If no selected patient ID, use first patient if available
                selectedPatient = userState.patients.isNotEmpty
                    ? userState.patients.first
                    : null;
              }

              final selectedPatientName = selectedPatient != null
                  ? _patientFactory.extractPrimaryDisplay(selectedPatient)
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
        // Main Content
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: Insets.medium),
                    // Vital Signs Section
                    Text(
                      context.l10n.homeVitalSigns,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Insets.smallNormal),
                    VitalsSection(
                      vitals: state.vitalSigns,
                      editMode: editMode,
                      onReorder: (oldIndex, newIndex) {
                        context
                            .read<HomeBloc>()
                            .add(HomeVitalsReordered(oldIndex, newIndex));
                      },
                      onLongPressCard: () => context
                          .read<HomeBloc>()
                          .add(const HomeEditModeChanged(true)),
                    ),

                    const SizedBox(height: Insets.large),

                    // Medical Records Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Overview',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        if (editMode)
                          // Show "Edit Records" when in edit mode
                          InkWell(
                            onTap: () => _showEditRecordsDialog(state),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Insets.small,
                                vertical: Insets.extraSmall,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withAlpha(45),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Edit Records',
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (state.sources.isNotEmpty)
                          Builder(
                            builder: (context) {
                              return SourceSelectorWidget(
                                sources: state.sources,
                                selectedSource: state.selectedSource,
                                onSourceChanged: (String newSource) {
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeSourceChanged(newSource));
                                },
                              );
                            },
                          )
                        else
                          Builder(
                            builder: (context) {
                              return Text(
                                'No sources available',
                                style: AppTextStyle.bodySmall.copyWith(
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
                      overviewCards: filteredCards,
                      editMode: editMode,
                      onLongPressCard: () => context
                          .read<HomeBloc>()
                          .add(const HomeEditModeChanged(true)),
                      onReorder: (oldIndex, newIndex) {
                        context
                            .read<HomeBloc>()
                            .add(HomeRecordsReordered(oldIndex, newIndex));
                      },
                      onTapCard: (card) {
                        context.read<RecordsBloc>().add(
                            RecordsFilterToggled(card.category.resourceTypes));

                        widget.pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),

                    const SizedBox(height: Insets.large),

                    // Recent Records Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              duration: const Duration(milliseconds: 300),
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
