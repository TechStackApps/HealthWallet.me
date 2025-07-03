import 'package:health_wallet/core/config/constants/shared_prefs_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  Future saveAuthToken(String token);
  Future removeAuthToken();
  bool get isLoggedIn;
}

@LazySingleton(as: AuthenticationLocalDataSource)
class AuthenticationLocalDataSourceDummy
    implements AuthenticationLocalDataSource {
  AuthenticationLocalDataSourceDummy(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future saveAuthToken(String token) async {
    await _sharedPreferences.setString(SharedPrefsConstants.bearerToken, token);
  }

  @override
  Future removeAuthToken() async {
    await _sharedPreferences.setString(SharedPrefsConstants.bearerToken, '');
  }

  @override
  bool get isLoggedIn =>
      (_sharedPreferences.getString(SharedPrefsConstants.bearerToken) ?? '') !=
      '';
}
