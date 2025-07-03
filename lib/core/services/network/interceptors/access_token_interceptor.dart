import 'package:dio/dio.dart';
import 'package:health_wallet/core/config/constants/shared_prefs_constants.dart';
import 'package:health_wallet/core/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenInterceptor extends InterceptorsWrapper {
  AccessTokenInterceptor();

  final SharedPreferences _sharedPreferences = getIt.get<SharedPreferences>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token =
        _sharedPreferences.getString(SharedPrefsConstants.bearerToken) ?? '';
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
