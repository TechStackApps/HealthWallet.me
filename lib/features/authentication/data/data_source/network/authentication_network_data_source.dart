import 'package:injectable/injectable.dart';

abstract class AuthenticationNetworkDataSource {
  Future<String?> login({required String email, required String password});

  Future<String?> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}

@LazySingleton(as: AuthenticationNetworkDataSource)
class AuthenticationNetworkDataSourceImpl
    implements AuthenticationNetworkDataSource {
  AuthenticationNetworkDataSourceImpl();

  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    return 'exampleToken';
  }

  @override
  Future<String?> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return 'exampleToken';
  }
}
