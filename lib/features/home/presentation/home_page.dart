import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return HomeView(pageController: pageController);
  }
}

class HomeView extends StatelessWidget {
  final PageController pageController;
  HomeView({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.status.when(
          initial: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          failure: (error) => Scaffold(
            body: Center(
              child: Text(
                'Error: $error',
                style: TextStyle(color: context.colorScheme.error),
              ),
            ),
          ),
          success: () => Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(text: context.l10n.homeHi),
                        TextSpan(
                          text: 'SourceName',
                          style: TextStyle(color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Assets.icons.settings.svg(),
                        onPressed: () {
                          PreferenceModal.show(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              backgroundColor: context.colorScheme.surface,
              elevation: 0,
              actions: const [],
            ),
            body: _buildDashboardContent(
              context,
              context.textTheme,
              context.colorScheme,
              state,
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
  ) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Vital Signs Section
              BlocBuilder<SyncBloc, SyncState>(
                builder: (context, state) {
                  final lastSync =
                      state.history.isNotEmpty ? state.history.first : null;
                  return state.status.maybeWhen(
                    success: () => Text(
                      '${context.l10n.homeLastSynced}${lastSync != null ? DateFormat.yMd().add_jm().format(lastSync) : context.l10n.homeNever}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              const SizedBox(height: Insets.medium),
              Text(
                context.l10n.homeVitalSigns,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: Insets.smallNormal),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.8,
                ),
                itemCount: state.vitalSigns.length,
                itemBuilder: (context, index) {
                  final vital = state.vitalSigns[index];
                  return _buildVitalSignCard(
                    context,
                    vital.title,
                    vital.value,
                    vital.unit,
                    vital.status,
                  );
                },
              ),

              // Overview Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.homeOverview,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        context.l10n.homeSource,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: Insets.extraSmall),
                      DropdownButton<String>(
                        value: state.selectedSource,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context.read<HomeBloc>().add(
                                  HomeEvent.sourceChanged(newValue),
                                );
                          }
                        },
                        items: state.sources
                            .where((source) => source.id != 'All')
                            .map((source) {
                          return DropdownMenuItem<String>(
                            value: source.id,
                            child: Text(source.name?.isNotEmpty == true
                                ? source.name!
                                : source.id),
                          );
                        }).toList()
                          // Add 'All' option at the top
                          ..insert(
                              0,
                              DropdownMenuItem<String>(
                                value: 'All',
                                child: Text(context.l10n.homeAll),
                              )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Insets.smallNormal),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                ),
                itemCount: state.overviewCards.length,
                itemBuilder: (context, index) {
                  final card = state.overviewCards[index];
                  return _buildOverviewCard(
                    context,
                    card.title,
                    card.count,
                  );
                },
              ),
              const SizedBox(height: Insets.medium),

              // Recent Records Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.homeRecentRecords,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      context.l10n.homeViewAll,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.smallNormal),
              ...state.recentRecords.map(
                (record) {
                  final resourceJson = record.resourceJson;
                  final title = resourceJson['code']?['text'] ??
                      resourceJson['vaccineCode']?['text'] ??
                      record.resourceType;
                  final doctor = resourceJson['recorder']?['display'] ??
                      context.l10n.homeNA;
                  final date = record.updatedAt.toString();
                  return _buildRecentRecordCard(
                    context,
                    title,
                    doctor,
                    date,
                    record.resourceType,
                    Colors.blue.withOpacity(0.1),
                    Colors.blue,
                    onTap: () {
                      context.router.push(RecordDetailRoute(resource: record));
                    },
                  );
                },
              ),
              const SizedBox(height: 116),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildVitalSignCard(
    BuildContext context,
    String title,
    String value,
    String unit,
    String status,
  ) {
    final TextTheme textTheme = context.textTheme;
    Color cardColor;
    Widget statusIcon;

    // Select icon based on title
    Widget icon;
    switch (title) {
      case 'Heart Rate':
        icon = Assets.icons.heartFavorite.svg();
        break;
      case 'Blood Pressure':
        icon = Assets.icons.drop.svg();
        break;
      case 'Temperature':
        icon = Assets.icons.temperature.svg();
        break;
      case 'Blood Oxygen':
        icon = Assets.icons.activity.svg();
        break;
      default:
        icon = const SizedBox.shrink();
    }

    // Select status icon based on status
    switch (status) {
      case 'Normal':
        cardColor = AppColors.success.withAlpha(25);
        statusIcon =
            Assets.icons.checkmarkCircleOutline.svg(width: 18, height: 18);
        break;
      case 'High':
      case 'Low':
        cardColor = AppColors.warning.withAlpha(25);
        statusIcon = Assets.icons.warning.svg(width: 18, height: 18);
        break;
      default:
        cardColor = Theme.of(context).colorScheme.surface;
        statusIcon = const SizedBox.shrink();
    }

    return Card(
      color: cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(Insets.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 16, width: 16, child: icon),
                const SizedBox(width: Insets.smaller),
                Text(
                  title,
                  style: textTheme.bodyMedium,
                ),
                const Spacer(),
                statusIcon,
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: Insets.extraSmall),
                Text(
                  unit,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context,
    String title,
    String count,
  ) {
    final TextTheme textTheme = context.textTheme;
    Widget icon;
    switch (title) {
      case ClinicalDataTags.allergy:
        icon = Assets.icons.faceMask.svg();
        break;
      case ClinicalDataTags.medication:
        icon = Assets.icons.medication.svg();
        break;
      case ClinicalDataTags.condition:
        icon = Assets.icons.stethoscope.svg();
        break;
      case ClinicalDataTags.immunization:
        icon = Assets.icons.shield.svg();
        break;
      case ClinicalDataTags.labResult:
        icon = Assets.icons.lab.svg();
        break;
      case ClinicalDataTags.procedure:
        icon = Assets.icons.scalpel.svg();
        break;
      default:
        icon = const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        final homeState = context.read<HomeBloc>().state;
        final selectedSource = homeState.selectedSource;
        context.read<RecordsBloc>().add(
              RecordsEvent.loadRecords(
                sourceId: selectedSource == 'All' ? null : selectedSource,
                filter: title,
              ),
            );
        pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 16, height: 16, child: icon),
                  const SizedBox(width: Insets.small),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: Insets.small),
                      Text(
                        count,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentRecordCard(
    BuildContext context,
    String title,
    String doctor,
    String date,
    String tag,
    Color tagBackgroundColor,
    Color tagTextColor, {
    String? status,
    Color? statusColor,
    VoidCallback? onTap,
  }) {
    final TextTheme textTheme = context.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Insets.small,
                          vertical: Insets.extraSmall,
                        ),
                        decoration: BoxDecoration(
                          color: tagBackgroundColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: textTheme.bodySmall?.copyWith(
                            color: tagTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (status != null) ...[
                        const SizedBox(height: Insets.extraSmall),
                        Text(
                          status,
                          style: textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    doctor,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.extraSmall),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    date,
                    style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
