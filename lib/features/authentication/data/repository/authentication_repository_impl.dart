import 'package:health_wallet/features/authentication/data/data_source/local/authentication_local_data_source.dart';
import 'package:health_wallet/features/authentication/data/data_source/network/authentication_network_data_source.dart';
import 'package:health_wallet/features/authentication/domain/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this.networkDataSource, this.localDataSource);

  final AuthenticationNetworkDataSource networkDataSource;
  final AuthenticationLocalDataSource localDataSource;

  @override
  bool get isLoggedIn => localDataSource.isLoggedIn;

  @override
  Future login({required String email, required String password}) async {
    String? token = await networkDataSource.login(
      email: email,
      password: password,
    );

    if (token != null) {
      await localDataSource.saveAuthToken(token);
    }
  }

  @override
  Future signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    String? token = await networkDataSource.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    if (token != null) {
      await localDataSource.saveAuthToken(token);
    }
  }

  @override
  Future loginWithGoogle() async {
    await localDataSource.saveAuthToken('exampleToken');
  }

  @override
  Future loginWithApple() async {
    await localDataSource.saveAuthToken('exampleToken');
  }

  @override
  Future logout() async {
    await localDataSource.removeAuthToken();
  }
}
