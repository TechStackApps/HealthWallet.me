import 'package:flutter/services.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canAuthenticate() async {
    final canAuth =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    logger.i('Can authenticate: $canAuth');
    return canAuth;
  }

  Future<bool> authenticate() async {
    try {
      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to access your health wallet',
        options: const AuthenticationOptions(
          biometricOnly: false,
        ),
      );
      logger.i('Did authenticate: $didAuthenticate');
      return didAuthenticate;
    } on PlatformException catch (e) {
      logger.e('Error during authentication: $e');
      return false;
    }
  }
}
