import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/features/home/presentation/home_page.dart';
import 'package:health_wallet/features/records/presentation/pages/records_page.dart';
import 'package:health_wallet/features/sync/presentation/bloc/sync_bloc.dart';
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
  bool _isKeyboardVisible = false;

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

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              FocusScope.of(context).unfocus();
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              HomePage(pageController: _pageController),
              RecordsPage(pageController: _pageController),
            ],
          ),
          // Bottom navigation bar
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
                                          ? (context.isDarkMode
                                              ? Colors.white
                                              : context.colorScheme.surface)
                                          : context.colorScheme.onSurface,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  label: context.l10n.dashboardTitle,
                                  isSelected: _currentIndex == 0,
                                  onTap: () {
                                    // Dismiss keyboard when tapping navigation
                                    FocusScope.of(context).unfocus();
                                    _pageController.animateToPage(
                                      0,
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                          ? (context.isDarkMode
                                              ? Colors.white
                                              : context.colorScheme.surface)
                                          : context.colorScheme.onSurface,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  label: context.l10n.recordsTitle,
                                  isSelected: _currentIndex == 1,
                                  onTap: () {
                                    // Dismiss keyboard when tapping navigation
                                    FocusScope.of(context).unfocus();
                                    _pageController.animateToPage(
                                      1,
                                      duration:
                                          const Duration(milliseconds: 300),
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
                );
              }
              return const SizedBox.shrink();
            },
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
