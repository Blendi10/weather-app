import '../../domain/entities/weather_metrics_entity.dart';

class WeatherMetricsModel extends WeatherMetricsEntity {
  const WeatherMetricsModel({
    required super.temperature,
    required super.feelsLike,
    required super.minTemperature,
    required super.maxTemperature,
    required super.pressure,
    required super.humidity,
    super.seaLevelPressure,
    super.groundLevelPressure,
  });

  factory WeatherMetricsModel.fromJson(Map<String, dynamic> json) {
    return WeatherMetricsModel(
      temperature: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      minTemperature: (json['temp_min'] as num).toDouble(),
      maxTemperature: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      seaLevelPressure: json['sea_level'] as int?,
      groundLevelPressure: json['grnd_level'] as int?,
    );
  }
}
