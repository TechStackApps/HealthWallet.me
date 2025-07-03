import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:health_wallet/core/navigation/app_router.dart';
import 'package:health_wallet/features/authentication/presentation/login/bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
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
                  onChanged: (value) => context.read<LoginBloc>().add(
                    LoginEmailChanged(value: value),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(value: value),
                  ),
                ),
                const SizedBox(height: 36),
                MaterialButton(
                  onPressed: state.canLogIn
                      ? () => context.read<LoginBloc>().add(
                          const LoginButtonPressed(),
                        )
                      : null,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () => context.read<LoginBloc>().add(
                        const LoginWithGooglePressed(),
                      ),
                      child: const Text('Login with Google'),
                    ),
                    MaterialButton(
                      onPressed: () => context.read<LoginBloc>().add(
                        const LoginWithApplePressed(),
                      ),
                      child: const Text('Login with Apple'),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                MaterialButton(
                  onPressed: () => context.router.push(const SignupRoute()),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
