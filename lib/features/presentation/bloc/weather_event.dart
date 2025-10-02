import '../../../core/params/get_weather_params.dart';
import '../../../core/params/get_weather_by_city_params.dart';
import '../../../core/params/no_params.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final GetWeatherParams params;
  const GetWeather({required this.params});
}

class RefreshWeather extends WeatherEvent {
  final NoParams params;
  const RefreshWeather({required this.params});
}

class GetWeatherByCity extends WeatherEvent {
  final GetWeatherByCityParams params;
  const GetWeatherByCity({required this.params});
}
