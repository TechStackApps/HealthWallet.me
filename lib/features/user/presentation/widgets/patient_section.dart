part of 'profile_content.dart';

class PatientSection extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String age;
  final String gender;

  const PatientSection({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Patient Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.border,
                  child: Assets.icons.user.svg(
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: Insets.small),
                Text(
                  '$firstName $lastName',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            IconButton(
              icon: Assets.icons.edit.svg(
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                // TODO: Edit patient info
              },
            ),
          ],
        ),
        const SizedBox(height: Insets.normal),

        /// Info Cards
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                context,
                Assets.icons.calendar.svg(
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                age,
                context.l10n.age,
              ),
            ),
            const SizedBox(width: Insets.small),
            Expanded(
              child: _buildInfoCard(
                context,
                Assets.icons.genderMale.svg(
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                gender,
                context.l10n.sex,
              ),
            ),
            const SizedBox(width: Insets.small),
            Expanded(
              child: _buildInfoCard(
                context,
                Assets.icons.drop.svg(
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                'O+',
                context.l10n.bloodType,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    Widget icon,
    String value,
    String label,
  ) {
    final textTheme = context.textTheme;
    return Card(
      color: context.colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: AppColors.border, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.smallNormal,
          horizontal: Insets.small,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: Insets.small),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: Insets.small),
                Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
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
