import 'dart:convert';
import 'package:health_wallet/core/config/constants/shared_prefs_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<void> saveVitalsOrder(List<String> vitalsOrder);
  Future<List<String>?> getVitalsOrder();
  Future<void> saveRecordsOrder(List<String> recordsOrder);
  Future<List<String>?> getRecordsOrder();
  Future<void> clearPreferences();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<void> saveVitalsOrder(List<String> vitalsOrder) async {
    final prefs = await _prefs;
    final jsonString = jsonEncode(vitalsOrder);
    await prefs.setString(SharedPrefsConstants.vitalsOrder, jsonString);
  }

  @override
  Future<List<String>?> getVitalsOrder() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(SharedPrefsConstants.vitalsOrder);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.cast<String>();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveRecordsOrder(List<String> recordsOrder) async {
    final prefs = await _prefs;
    final jsonString = jsonEncode(recordsOrder);
    await prefs.setString(SharedPrefsConstants.recordsOrder, jsonString);
  }

  @override
  Future<List<String>?> getRecordsOrder() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(SharedPrefsConstants.recordsOrder);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.cast<String>();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearPreferences() async {
    final prefs = await _prefs;
    await prefs.remove(SharedPrefsConstants.vitalsOrder);
    await prefs.remove(SharedPrefsConstants.recordsOrder);
  }
}
