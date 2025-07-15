import 'dart:convert';
import 'package:health_wallet/core/config/constants/shared_prefs_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class HomePreferencesService {
  final SharedPreferences _sharedPreferences;

  HomePreferencesService(this._sharedPreferences);

  /// Save the vitals order to persistent storage
  Future<void> saveVitalsOrder(List<String> vitalsOrder) async {
    final jsonString = jsonEncode(vitalsOrder);
    await _sharedPreferences.setString(
        SharedPrefsConstants.vitalsOrder, jsonString);
  }

  /// Load the vitals order from persistent storage
  List<String>? getVitalsOrder() {
    final jsonString =
        _sharedPreferences.getString(SharedPrefsConstants.vitalsOrder);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.cast<String>();
      } catch (e) {
        // If there's an error parsing, return null to use default order
        return null;
      }
    }
    return null;
  }

  /// Save the records order to persistent storage
  Future<void> saveRecordsOrder(List<String> recordsOrder) async {
    final jsonString = jsonEncode(recordsOrder);
    await _sharedPreferences.setString(
        SharedPrefsConstants.recordsOrder, jsonString);
  }

  /// Load the records order from persistent storage
  List<String>? getRecordsOrder() {
    final jsonString =
        _sharedPreferences.getString(SharedPrefsConstants.recordsOrder);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.cast<String>();
      } catch (e) {
        // If there's an error parsing, return null to use default order
        return null;
      }
    }
    return null;
  }

  /// Clear all home preferences
  Future<void> clearPreferences() async {
    await _sharedPreferences.remove(SharedPrefsConstants.vitalsOrder);
    await _sharedPreferences.remove(SharedPrefsConstants.recordsOrder);
  }
}
