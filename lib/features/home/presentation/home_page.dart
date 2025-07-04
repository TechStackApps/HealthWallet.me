import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/features/records/presentation/bloc/records_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/preference_modal.dart';
import 'package:health_wallet/gen/assets.gen.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          getIt<HomeBloc>()..add(const HomeEvent.initialised()),
      child: HomeView(pageController: pageController),
    );
  }
}

class HomeView extends StatelessWidget {
  final PageController pageController;
  const HomeView({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
          success: () => Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, SourceName', // TODO: Get name from state
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.sync, color: colorScheme.onSurface),
                        onPressed: () {
                          context.router.push(const SyncRoute());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.menu, color: colorScheme.onSurface),
                        onPressed: () {
                          PreferenceModal.show(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              backgroundColor: colorScheme.surface,
              elevation: 0,
              actions: const [],
            ),
            body: _buildDashboardContent(
              context,
              textTheme,
              colorScheme,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Vital Signs Section
              Text(
                'Vital Signs',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
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
                    vital.icon,
                    vital.title,
                    vital.value,
                    vital.unit,
                    vital.status,
                  );
                },
              ),
              const SizedBox(height: 24),

              // Overview Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Source:',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 4),
                      DropdownButton<String>(
                        value: state.selectedSource,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context.read<HomeBloc>().add(
                                  HomeEvent.sourceChanged(newValue),
                                );
                          }
                        },
                        items: <String>['All', 'Epic', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          Widget child;
                          switch (value) {
                            case 'Epic':
                              child = Assets.icons.facilities.svg(
                                colorFilter: ColorFilter.mode(
                                  colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                                width: 24,
                                height: 24,
                              );
                              break;
                            case 'Other':
                              child = const Icon(Icons.more_horiz);
                              break;
                            default:
                              child = const Text('All');
                          }
                          return DropdownMenuItem<String>(
                            value: value,
                            child: child,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.2,
                ),
                itemCount: state.overviewCards.length,
                itemBuilder: (context, index) {
                  final card = state.overviewCards[index];
                  return _buildOverviewCard(
                    context,
                    card.title,
                    card.count,
                    card.icon,
                    card.iconColor,
                  );
                },
              ),
              const SizedBox(height: 24),

              // Recent Records Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Records',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle View All
                    },
                    child: Text(
                      'View All',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...state.recentRecords.map(
                (record) => _buildRecentRecordCard(
                  context,
                  record.title,
                  record.doctor,
                  record.date,
                  record.tag,
                  record.tagBackgroundColor,
                  record.tagTextColor,
                  status: record.status,
                  statusColor: record.statusColor,
                ),
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
    IconData icon,
    String title,
    String value,
    String unit,
    String status,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    Color cardColor;
    IconData statusIcon;
    Color statusIconColor;

    switch (status) {
      case 'Normal':
        cardColor = AppColors.secondaryGreen.withAlpha(25);
        statusIcon = Icons.check_circle_outline;
        statusIconColor = AppColors.secondaryGreen;
        break;
      case 'High':
        cardColor = AppColors.secondaryRed.withAlpha(25);
        statusIcon = Icons.error_outline;
        statusIconColor = AppColors.secondaryRed;
        break;
      case 'Low':
        cardColor = AppColors.secondaryYellow.withAlpha(25);
        statusIcon = Icons.warning_amber_outlined;
        statusIconColor = AppColors.secondaryYellow;
        break;
      default:
        cardColor = Theme.of(context).colorScheme.surface;
        statusIcon = Icons.info_outline;
        statusIconColor = Theme.of(context).colorScheme.onSurface;
    }

    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Icon(statusIcon, size: 20, color: statusIconColor),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
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
    IconData icon,
    Color iconColor,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        context
            .read<RecordsBloc>()
            .add(RecordsEvent.fetchRecords(resourceType: title));
      },
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
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
  }) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        horizontal: 8,
                        vertical: 4,
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
                      const SizedBox(height: 4),
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
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  doctor,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
