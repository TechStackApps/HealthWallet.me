import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceholderWidget extends StatelessWidget {
  final bool hasDataLoaded;
  final ColorScheme colorScheme;
  final VoidCallback? onSyncPressed;
  final PageController? pageController;

  const PlaceholderWidget({
    super.key,
    required this.hasDataLoaded,
    required this.colorScheme,
    this.onSyncPressed,
    this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasDataLoaded) {
      return Column(
        children: [
          const SizedBox(height: Insets.medium),
          Container(
            padding: const EdgeInsets.all(Insets.large),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.science_outlined,
                  size: 48,
                  color: colorScheme.primary.withOpacity(0.6),
                ),
                const SizedBox(height: Insets.medium),
                Text(
                  'No medical records yet',
                  style: AppTextStyle.titleMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: Insets.small),
                Text(
                  'Load demo data to explore the app or sync your real medical records',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: Insets.large),
                Column(
                  children: [
                    // Load Demo Data Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleLoadDemoData(context),
                        icon: const Icon(Icons.science),
                        label: const Text('Load Home Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: context.isDarkMode
                              ? Colors.white
                              : colorScheme.onPrimary,
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Insets.medium),
                    // Sync Data Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            onSyncPressed ?? () => _handleSyncRecords(context),
                        icon: const Icon(Icons.sync),
                        label: const Text('Sync Data'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          foregroundColor: context.isDarkMode
                              ? Colors.white
                              : colorScheme.onSecondary,
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  /// Handle demo data loading
  void _handleLoadDemoData(BuildContext context) async {
    final syncBloc = context.read<SyncBloc>();

    syncBloc.add(const SyncResetOnboarding());

    syncBloc.add(const SyncLoadDemoData());

    _showSuccessDialog(
      context,
      'Demo Data Loaded Successfully!',
      'You can now explore the app with sample medical records.',
    ).then((_) async {
      _navigateToHomePage(context);

      Future.delayed(const Duration(milliseconds: 1500), () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboarding_shown', true);

        syncBloc.add(const OnboardingOverlayTriggered());
      });
    });
  }

  /// Handle sync records
  void _handleSyncRecords(BuildContext context) async {
    final syncBloc = context.read<SyncBloc>();

    syncBloc.add(const SyncResetOnboarding());

    _showSuccessDialog(
      context,
      'Sync Initiated!',
      'Your medical records are being synchronized. You will be redirected to the home page.',
    ).then((_) async {
      _navigateToHomePageViaRouter(context);

      Future.delayed(const Duration(milliseconds: 1500), () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboarding_shown', true);
        print('💾 Sync data onboarding marked as shown in SharedPreferences');

        syncBloc.add(const OnboardingOverlayTriggered());
        print('🔄 PlaceholderWidget: OnboardingOverlayTriggered event sent');
      });
    });
  }

  /// Navigate to home page using PageController (for demo data)
  void _navigateToHomePage(BuildContext context) {
    if (pageController != null) {
      pageController!.animateToPage(
        0, // HomePage index
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {}
  }

  void _navigateToHomePageViaRouter(BuildContext context) {
    context.appRouter.replace(const DashboardRoute());
  }

  /// Show success dialog
  Future<void> _showSuccessDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
