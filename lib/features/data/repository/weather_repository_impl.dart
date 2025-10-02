import 'dart:developer';

import 'package:dio/dio.dart';

import '../data_sources/weather_api_service.dart';
import '../models/weather_model.dart';
import '../../../core/resources/data_state.dart';
import '../../domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;

  const WeatherRepositoryImpl(this.apiService);
  @override
  Future<DataState<WeatherModel>> getWeather({
    required double lat,
    required double lon,
    String? units,
    String? languageCode,
  }) async {
    try {
      final responseBody = await apiService.getWeather(
        lat: lat,
        lon: lon,
        units: units,
        lang: languageCode,
      );
      log('WeatherRepositoryImpl: Received response: $responseBody');
      final WeatherModel weather = WeatherModel.fromJson(responseBody);
      return DataSuccess(weather);
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions, message: e.message);
    }
  }

  @override
  Future<DataState<WeatherModel>> getWeatherByCity({
    required String cityName,
    String? units,
    String? languageCode,
  }) async {
    try {
      final responseBody = await apiService.getWeatherByCity(
        cityName: cityName,
        units: units,
        lang: languageCode,
      );
      log('WeatherRepositoryImpl: Received response: $responseBody');
      final WeatherModel weather = WeatherModel.fromJson(responseBody);
      return DataSuccess(weather);
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions, message: e.message);
    }
  }
}
