import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  final WeatherEntity? weatherData;
  final String? units;
  final DioException? exception;

  const WeatherState({this.exception, this.weatherData, this.units});
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading() : super();
}

class WeatherDone extends WeatherState {
  const WeatherDone(WeatherEntity? weather, String? units)
    : super(weatherData: weather, units: units);
}

class WeatherError extends WeatherState {
  const WeatherError(DioException? exception) : super(exception: exception);
}
