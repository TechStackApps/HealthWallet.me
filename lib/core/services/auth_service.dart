import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    final canCheck =
        await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    if (!canCheck) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access your health wallet',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
