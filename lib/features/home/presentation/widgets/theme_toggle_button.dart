import 'package:flutter/material.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton(
      {super.key, required this.isDarkMode, required this.onPressed});

  final bool isDarkMode;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;

    return IconButton(
      icon: isDarkMode
          ? Assets.icons.moon.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            )
          : Assets.icons.sun.svg(
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
      onPressed: onPressed,
    );
  }
}
