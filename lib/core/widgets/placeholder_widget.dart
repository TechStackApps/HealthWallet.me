import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/gen/assets.gen.dart';
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
            width: 240,
            height: 240,
            child: Assets.images.placeholder.svg(
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: Insets.large),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            child: Column(
              children: [
                Text(
                  'No medical records yet',
                  style: AppTextStyle.titleLarge.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.medium),
                Text(
                  'Load demo data to explore the app or sync your real medical records',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.large),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            child: Column(
              children: [
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
                      'Load Home data',
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
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
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
                      'Sync Data',
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
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  void _handleLoadDemoData(BuildContext context) async {
    final syncBloc = context.read<SyncBloc>();
    final prefs = await SharedPreferences.getInstance();
    final onboardingShown = prefs.getBool('onboarding_shown') ?? false;

    syncBloc.add(const SyncLoadDemoData());

    if (!onboardingShown) {
      if (pageController != null) {
        _showSuccessDialog(
          context,
          'Demo Data Loaded Successfully!',
          'You can now explore the app with sample medical records.',
        ).then((_) {
          _navigateToHomePage(context);

          Future.delayed(const Duration(milliseconds: 500), () {
            syncBloc.add(const OnboardingOverlayTriggered());
          });
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          syncBloc.add(const OnboardingOverlayTriggered());
        });
      }
    }
  }

  void _handleSyncRecords(BuildContext context) async {
    context.router.push(const SyncRoute());
  }

  void _navigateToHomePage(BuildContext context) {
    if (pageController != null) {
      pageController!.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {}
  }

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
