import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final isDarkMode = state.user.isDarkMode;
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
          onPressed: () {
            context.read<UserProfileBloc>().add(
              const UserProfileThemeToggled(),
            );
          },
        );
      },
    );
  }
}
