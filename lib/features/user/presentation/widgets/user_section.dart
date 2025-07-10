part of 'profile_content.dart';

class UserSection extends StatelessWidget {
  final String firstName;
  final String lastName;
  final VoidCallback? onEdit;

  const UserSection({
    super.key,
    required this.firstName,
    required this.lastName,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: onEdit,
        ),
      ],
    );
  }
}
