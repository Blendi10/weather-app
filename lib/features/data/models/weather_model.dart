import '../../domain/entities/weather_entity.dart';
import 'cloud_model.dart';
import 'cordinates_model.dart';
import 'country_info_model.dart';
import 'rain_model.dart';
import 'snow_model.dart';
import 'weather_condition_model.dart';
import 'weather_metrics_model.dart';
import 'wind_model.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.coordinates,
    required super.conditions,
    required super.baseStation,
    required super.metrics,
    required super.visibilityMeters,
    required super.timestamp,
    required super.countryInfo,
    required super.cityId,
    required super.cityName,
    required super.statusCode,
    required super.wind,
    super.rain,
    super.snow,
    required super.clouds,
    required super.timezoneOffset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coordinates: CoordinatesModel.fromJson(json['coord']),
      conditions: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionModel.fromJson(e))
          .toList(),
      baseStation: json['base'] as String,
      metrics: WeatherMetricsModel.fromJson(json['main']),
      visibilityMeters: json['visibility'] as int,
      timestamp: json['dt'] as int,
      countryInfo: CountryInfoModel.fromJson(json['sys']),
      cityId: json['id'] as int,
      cityName: json['name'] as String,
      statusCode: json['cod'] as int,
      wind: WindModel.fromJson(json['wind']),
      rain: json['rain'] != null ? RainModel.fromJson(json['rain']) : null,
      snow: json['snow'] != null ? SnowModel.fromJson(json['snow']) : null,
      clouds: CloudsModel.fromJson(json['clouds']),
      timezoneOffset: json['timezone'] as int,
    );
  }
}
