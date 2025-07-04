import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncService {
  final Dio _dio;
  final SharedPreferences _prefs;

  SyncService(this._dio, this._prefs);

  Future<DateTime?> getLastServerUpdateTime() async {
    final token = _prefs.getString('sync_token');
    final address = _prefs.getString('sync_address');
    final port = _prefs.getString('sync_port');

    if (token == null || address == null || port == null) {
      return null;
    }

    try {
      final response = await _dio.get(
        'http://$address:$port/api/secure/sync/last-updated',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return DateTime.parse(response.data['data']['last_updated']);
      }
    } catch (e) {
      print('Error getting last server update time: $e');
    }
    return null;
  }

  Future<void> setLastSyncTimestamp() async {
    await _prefs.setString(
        'last_sync_timestamp', DateTime.now().toIso8601String());
  }

  DateTime? getLastSyncTimestamp() {
    final timestamp = _prefs.getString('last_sync_timestamp');
    if (timestamp != null) {
      return DateTime.parse(timestamp);
    }
    return null;
  }
}
