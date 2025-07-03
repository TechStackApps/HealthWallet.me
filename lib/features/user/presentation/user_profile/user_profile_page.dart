import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/features/user/domain/entity/user.dart';
import 'package:health_wallet/features/user/presentation/user_profile/bloc/user_profile_bloc.dart';

@RoutePage()
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      bloc: BlocProvider.of<UserProfileBloc>(context)
        ..add(UserProfileInitialised()),
      listener: (context, state) {
        state.status.whenOrNull(
            // logOutSuccess: () => context.router.replace(const LoginRoute()),
            );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  context
                      .read<UserProfileBloc>()
                      .add(const UserProfileSignedOut());
                },
              ),
            ],
          ),
          body: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              return state.status.maybeWhen(
                success: () => _buildUserProfile(context, state.user),
                failure: (exception) =>
                    Center(child: Text('Error: $exception')),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildUserProfile(BuildContext context, User user) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<UserProfileBloc>().add(UserProfileRefreshed()),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
              radius: 50, backgroundImage: NetworkImage(user.photoUrl)),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (!user.isEmailVerified)
            ElevatedButton(
              onPressed: () {
                context
                    .read<UserProfileBloc>()
                    .add(const UserProfileEmailVerified());
              },
              child: const Text('Verify Email'),
            ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: user.isDarkMode,
            onChanged: (value) {
              context
                  .read<UserProfileBloc>()
                  .add(const UserProfileThemeToggled());
            },
            secondary: Icon(
              user.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: user.isDarkMode ? Colors.amber : Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<UserProfileBloc>()
                            .add(const UserProfileUserDeleted());
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
