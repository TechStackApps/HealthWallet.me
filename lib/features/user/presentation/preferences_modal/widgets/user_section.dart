import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class UserSection extends StatefulWidget {
  const UserSection({super.key});

  @override
  State<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _startEditing(String currentName) {
    setState(() {
      _isEditing = true;
      _nameController.text = currentName;
    });
    _nameFocusNode.requestFocus();
  }

  void _saveName() {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      setState(() {
        _isEditing = false;
      });
      _nameFocusNode.unfocus();

      context.read<UserBloc>().add(UserNameUpdated(newName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = context.isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;
        final userName = user.name.isNotEmpty ? user.name : 'User';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Assets.icons.information.svg(
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: Insets.extraSmall),
                  Text(
                    'Display name',
                    style: AppTextStyle.labelMedium.copyWith(
                      color: iconColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _isEditing
                        ? TextField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            style: AppTextStyle.bodyLarge,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onSubmitted: (_) => _saveName(),
                            onEditingComplete: _saveName,
                          )
                        : Text(
                            userName,
                            style: AppTextStyle.bodyLarge,
                          ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: IconButton(
                      icon: _isEditing
                          ? const Icon(
                              Icons.check,
                              color: AppColors.primary,
                              size: 21,
                            )
                          : Assets.icons.edit.svg(
                              width: 21,
                              height: 19.5,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                      onPressed: _isEditing
                          ? _saveName
                          : () => _startEditing(userName),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
