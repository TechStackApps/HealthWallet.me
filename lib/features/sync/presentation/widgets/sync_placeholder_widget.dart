import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/features/home/presentation/bloc/home_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/navigation/app_router.dart';

class SyncPlaceholderWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
    );
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
          ],
          // Sync Data button - always visible
          SizedBox(
            width: double.infinity,
            child: hasAnyMeaningfulData
                ? ElevatedButton.icon(
                    onPressed:
                        onSyncPressed ?? () => _handleSyncRecords(context),
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
                    onPressed:
                        onSyncPressed ?? () => _handleSyncRecords(context),
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
    if (hasAnyMeaningfulData && recordTypeName != null) {
      return 'No $recordTypeName yet';
    }
    return context.l10n.noMedicalRecordsYet;
  }

  String _getSubtitle(BuildContext context, bool hasAnyMeaningfulData) {
    if (hasAnyMeaningfulData && recordTypeName != null) {
      return 'Sync or update your data to view $recordTypeName records';
    }
    return context.l10n.loadDemoDataMessage;
  }

  void _handleLoadDemoData(BuildContext context) {
    context.read<SyncBloc>().add(const SyncLoadDemoData());

    if (pageController != null) {
      _navigateToHomePage(context);

      Future.delayed(const Duration(milliseconds: 500), () {
        // Check if the widget is still mounted before accessing context
        if (context.mounted) {
          context.read<SyncBloc>().add(const OnboardingOverlayTriggered());
        }
      });
    }
  }

  void _handleSyncRecords(BuildContext context) {
    if (context.mounted) {
      context.router.push(const SyncRoute());
    }
  }

  void _navigateToHomePage(BuildContext context) {
    if (pageController != null && context.mounted) {
      pageController!.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }
}
