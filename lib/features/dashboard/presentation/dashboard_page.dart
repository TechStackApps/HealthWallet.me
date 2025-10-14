import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/scan/presentation/pages/scan_page.dart';
import 'package:health_wallet/features/scan/presentation/pages/import_page.dart';
import 'package:health_wallet/features/home/presentation/home_page.dart';
import 'package:health_wallet/features/records/presentation/pages/records_page.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/dashboard/presentation/helpers/page_view_navigation_controller.dart';
// incoming additions
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/utils/deep_link_file_cache.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  final int initialPage;
  const DashboardPage({
    super.key,
    @queryParam this.initialPage = 0,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final PageViewNavigationController _navigationController;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _navigationController = PageViewNavigationController(
      initialPage: widget.initialPage,
    );
    _navigationController.currentPageNotifier.addListener(_onPageChanged);

    // Adopt incoming deep link file check to jump to Scan tab after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForDeepLinkFile();
    });
  }

  void _checkForDeepLinkFile() {
    if (DeepLinkFileCache.instance.hasFile()) {
      // Jump to Scan tab (index 2) using your controller to keep logic unified
      _navigationController.jumpToPage(2);
    }
  }

  void _onPageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _navigationController.currentPageNotifier.removeListener(_onPageChanged);
    _navigationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    if (_isKeyboardVisible != isKeyboardVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isKeyboardVisible = isKeyboardVisible;
        });
      });
    }

    return BlocListener<SyncBloc, SyncState>(
      listenWhen: (previous, current) {
        // Combine: your original tutorial trigger and incoming demoDataConfirmed/onboarding flow
        final incomingTrigger = current.demoDataConfirmed && !current.hasSyncedData;
        final yourTrigger = current.shouldShowTutorial && !previous.shouldShowTutorial;
        return incomingTrigger || yourTrigger;
      },
      listener: (context, syncState) async {
        // Incoming behavior: if demo data confirmed and onboarding not shown, animate to page 0 then trigger tutorial
        if (syncState.demoDataConfirmed && !syncState.hasSyncedData) {
          final prefs = await SharedPreferences.getInstance();
          final onboardingShown = prefs.getBool('onboarding_shown') ?? false;

          if (!onboardingShown) {
            _navigationController.pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );

            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted && context.mounted) {
                try {
                  context.read<SyncBloc>().add(const TriggerTutorial());
                } catch (_) {}
              }
            });
            return;
          }
        }

        // Your existing tutorial trigger behavior remains
        if (syncState.shouldShowTutorial) {
          _navigationController.navigateToPage(0);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _navigationController.pageController,
              onPageChanged: (index) {
                FocusScope.of(context).unfocus();
              },
              itemCount: 4,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return HomePage(
                      pageController: _navigationController.pageController,
                    );
                  case 1:
                    return RecordsPage(
                      pageController: _navigationController.pageController,
                    );
                  case 2:
                    // Keep your ScanPage API that expects navigationController
                    return ScanPage(
                      navigationController: _navigationController,
                    );
                  case 3:
                    return ImportPage(
                      navigationController: _navigationController,
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
            BlocBuilder<SyncBloc, SyncState>(
              builder: (context, syncState) {
                if (!_isKeyboardVisible) {
                  return Positioned(
                    left: 8,
                    right: 8,
                    bottom: 24,
                    child: SizedBox(
                      height: 60,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? Colors.white.withOpacity(0.03)
                                      : Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: context.isDarkMode
                                        ? Colors.white.withOpacity(0.08)
                                        : Colors.white.withOpacity(0.2),
                                    width: 1.0,
                                  ),
                                  boxShadow: context.isDarkMode
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            spreadRadius: 0,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(Insets.extraSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: _buildNavItem(
                                    context: context,
                                    icon: Assets.icons.dashboard.svg(
                                      width: 24,
                                      height: 24,
                                      colorFilter: ColorFilter.mode(
                                        _navigationController.currentPage == 0
                                            ? (context.isDarkMode
                                                ? Colors.white
                                                : context.colorScheme.surface)
                                            : context.colorScheme.onSurface,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    label: context.l10n.dashboardTitle,
                                    isSelected:
                                        _navigationController.currentPage == 0,
                                    pageIndex: 0,
                                  ),
                                ),
                                Expanded(
                                  child: _buildNavItem(
                                    context: context,
                                    icon: Assets.icons.timeline.svg(
                                      width: 24,
                                      height: 24,
                                      colorFilter: ColorFilter.mode(
                                        _navigationController.currentPage == 1
                                            ? (context.isDarkMode
                                                ? Colors.white
                                                : context.colorScheme.surface)
                                            : context.colorScheme.onSurface,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    label: context.l10n.recordsTitle,
                                    isSelected:
                                        _navigationController.currentPage == 1,
                                    pageIndex: 1,
                                  ),
                                ),
                                Expanded(
                                  child: _buildNavItem(
                                    context: context,
                                    icon: Assets.icons.documentFile.svg(
                                      width: 24,
                                      height: 24,
                                      colorFilter: ColorFilter.mode(
                                        _navigationController.currentPage == 2
                                            ? (context.isDarkMode
                                                ? Colors.white
                                                : context.colorScheme.surface)
                                            : context.colorScheme.onSurface,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    label: context.l10n.documentScanTitle,
                                    isSelected:
                                        _navigationController.currentPage == 2,
                                    pageIndex: 2,
                                  ),
                                ),
                                Expanded(
                                  child: _buildNavItem(
                                    context: context,
                                    icon: Assets.icons.cloudDownload.svg(
                                      width: 24,
                                      height: 24,
                                      colorFilter: ColorFilter.mode(
                                        _navigationController.currentPage == 3
                                            ? (context.isDarkMode
                                                ? Colors.white
                                                : context.colorScheme.surface)
                                            : context.colorScheme.onSurface,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    label: 'Import',
                                    isSelected:
                                        _navigationController.currentPage == 3,
                                    pageIndex: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required Widget icon,
    required String label,
    required bool isSelected,
    required int pageIndex,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _navigationController.jumpToPage(pageIndex);
      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: Insets.extraSmall),
              Text(
                label,
                style: AppTextStyle.labelSmall.copyWith(
                  color: isSelected
                      ? (context.isDarkMode
                          ? Colors.white
                          : context.colorScheme.surface)
                      : context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
