import 'package:equatable/equatable.dart';

class WeatherMetricsEntity extends Equatable {
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int pressure;
  final int humidity;
  final int? seaLevelPressure;
  final int? groundLevelPressure;

  const WeatherMetricsEntity({
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.humidity,
    this.seaLevelPressure,
    this.groundLevelPressure,
  });

  @override
  List<Object?> get props => [
    temperature,
    feelsLike,
    minTemperature,
    maxTemperature,
    pressure,
    humidity,
    seaLevelPressure,
    groundLevelPressure,
  ];
}
