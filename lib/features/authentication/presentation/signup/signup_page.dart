import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/authentication/presentation/signup/bloc/signup_bloc.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<SignupBloc>(),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          state.status.whenOrNull(
            success: () {
              // Here we should navigate to first screen after login
              context.router.replace(const DashboardRoute());
            },
            failure: (error) {
              // Here we should show error
            },
          );
        },
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) => context.read<SignupBloc>().add(
                    SignupEmailChanged(value: value),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'First name'),
                  onChanged: (value) => context.read<SignupBloc>().add(
                    SignupFirstNameChanged(value: value),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'First name'),
                  onChanged: (value) => context.read<SignupBloc>().add(
                    SignupLastNameChanged(value: value),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) => context.read<SignupBloc>().add(
                    SignupPasswordChanged(value: value),
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                  ),
                  obscureText: true,
                  onChanged: (value) => context.read<SignupBloc>().add(
                    SignupConfirmPasswordChanged(value: value),
                  ),
                ),
                const SizedBox(height: 36),
                MaterialButton(
                  onPressed: state.canSignUp
                      ? () => context.read<SignupBloc>().add(
                          const SignupButtonPressed(),
                        )
                      : null,
                  child: const Text('Sign up'),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () => context.read<SignupBloc>().add(
                        const SignupWithGooglePressed(),
                      ),
                      child: const Text('Sign up with Google'),
                    ),
                    MaterialButton(
                      onPressed: () => context.read<SignupBloc>().add(
                        const SignupWithApplePressed(),
                      ),
                      child: const Text('Sign up with Apple'),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                MaterialButton(
                  onPressed: () => context.router.push(const LoginRoute()),
                  child: const Text('Go to login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
