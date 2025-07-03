abstract class AuthenticationRepository {
  Future login({required String email, required String password});

  Future signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future loginWithGoogle();

  Future loginWithApple();

  Future logout();

  bool get isLoggedIn;
}
