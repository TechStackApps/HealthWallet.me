import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_wallet/core/l10n/arb/app_localizations.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/home_page.dart';
import 'package:health_wallet/features/records/presentation/pages/records_page.dart';
import 'package:health_wallet/gen/assets.gen.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              HomePage(pageController: _pageController),
              const RecordsPage(),
            ],
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 24,
            child: SizedBox(
              height: 60,
              child: Stack(
                children: [
                  // LiquidGlass background
                  ClipRRect(
                    child: LiquidGlass(
                      shape: const LiquidRoundedRectangle(
                        borderRadius: Radius.circular(100),
                      ),
                      settings: const LiquidGlassSettings(blur: 15),
                      child: Container(),
                    ),
                  ),
                  // Foreground content
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
                            icon: Assets.icons.dashboard.svg(
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                _currentIndex == 0
                                    ? context.colorScheme.surface
                                    : context.colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: context.l10n.dashboardTitle,
                            isSelected: _currentIndex == 0,
                            onTap: () {
                              _pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: _buildNavItem(
                            icon: Assets.icons.timeline.svg(
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                _currentIndex == 1
                                    ? context.colorScheme.surface
                                    : context.colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: context.l10n.recordsTitle,
                            isSelected: _currentIndex == 1,
                            onTap: () {
                              _pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          // Ensures vertical centering of content
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: Insets.extraSmall),
              Text(
                label,
                style: AppTextStyle.labelSmall.copyWith(
                  color: isSelected
                      ? context.colorScheme.surface
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
