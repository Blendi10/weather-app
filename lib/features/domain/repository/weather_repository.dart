import '../entities/weather_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class WeatherRepository {
  Future<DataState<WeatherEntity>> getWeather({
    required double lat,
    required double lon,
    String? units,
    String? languageCode,
  });

  Future<DataState<WeatherEntity>> getWeatherByCity({
    required String cityName,
    String? units,
    String? languageCode,
  });
}
