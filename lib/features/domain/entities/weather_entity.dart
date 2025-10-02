import 'package:equatable/equatable.dart';

import 'clouds_entity.dart';
import 'cordinates_entity.dart';
import 'country_info_entity.dart';
import 'rain_entity.dart';
import 'snow_entity.dart';
import 'weather_condition_entity.dart';
import 'weather_metrics_entity.dart';
import 'wind_entity.dart';

class WeatherEntity extends Equatable {
  final CoordinatesEntity coordinates;
  final List<WeatherConditionEntity> conditions;
  final String baseStation;
  final WeatherMetricsEntity metrics;
  final int visibilityMeters;
  final WindEntity wind;
  final RainEntity? rain;
  final SnowEntity? snow;
  final CloudsEntity clouds;
  final int timestamp;
  final CountryInfoEntity countryInfo;
  final int timezoneOffset;
  final int cityId;
  final String cityName;
  final int statusCode;

  const WeatherEntity({
    required this.coordinates,
    required this.conditions,
    required this.baseStation,
    required this.metrics,
    required this.visibilityMeters,
    required this.wind,
    this.rain,
    this.snow,
    required this.clouds,
    required this.timestamp,
    required this.countryInfo,
    required this.timezoneOffset,
    required this.cityId,
    required this.cityName,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
    coordinates,
    conditions,
    baseStation,
    metrics,
    visibilityMeters,
    wind,
    rain,
    snow,
    clouds,
    timestamp,
    countryInfo,
    timezoneOffset,
    cityId,
    cityName,
    statusCode,
  ];
}
