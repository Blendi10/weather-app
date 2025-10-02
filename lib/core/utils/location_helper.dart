import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationHelper {
  static const _cacheKey = 'cached_position';

  static Future<Position> getCurrentOrDefaultPosition() async {
    Position? position;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location disabled');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permanently denied');
      }

      position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
      );

      await cachePosition(position);
    } catch (e) {
      position = await loadCachedPosition();
    }

    position ??= Position(
      latitude: 48.1351,
      longitude: 11.5820,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    return position;
  }

  static Future<void> cachePosition(Position pos) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({
      'lat': pos.latitude,
      'lon': pos.longitude,
      'ts': pos.timestamp.toIso8601String(),
    });
    await prefs.setString(_cacheKey, data);
  }

  static Future<Position?> loadCachedPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cacheKey);
    if (data == null) return null;

    final json = jsonDecode(data);
    return Position(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
      timestamp: DateTime.tryParse(json['ts']) ?? DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }
}
