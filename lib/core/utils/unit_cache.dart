import 'package:shared_preferences/shared_preferences.dart';

class UnitCache {
  static const String _unitKey = 'unit_system';

  /// Save the selected unit (metric / imperial / standard)
  static Future<void> saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unitKey, unit);
  }

  /// Load the saved unit, defaults to "metric"
  static Future<String> loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_unitKey) ?? 'metric';
  }
}
