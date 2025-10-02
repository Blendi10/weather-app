import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';

class WeatherApiService {
  WeatherApiService();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: headers,
    ),
  );

  Future<Map<String, dynamic>> getWeather({
    required double lat,
    required double lon,
    String? units,
    String? lang,
    List<String>? exclude,
  }) async {
    try {
      log(
        'Fetching weather data for url: $baseUrl ,lat: $lat, lon: $lon, appid: $apiKey, units: ${units ?? 'metric'}',
      );
      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
          'units': units ?? 'metric',
          'lang': lang ?? 'en',
        },
      );
      log('Request URL: ${response.requestOptions.uri}');
      log('Status Code: ${response.statusCode}');
      log('Weather API Response: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      log('DioException: ${e.message}', error: e);
      throw DioException(
        requestOptions: e.requestOptions,
        message: e.message,
        response: e.response,
        type: e.type,
        error: e.error,
        stackTrace: e.stackTrace,
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> getWeatherByCity({
    required String cityName,
    String? units,
    String? lang,
  }) async {
    try {
      log(
        'Fetching weather data for url: $baseUrl , city:$cityName , appid: $apiKey, units: ${units ?? 'metric'}',
      );
      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': units ?? 'metric',
          'lang': lang ?? 'en',
        },
      );

      return response.data;
    } on DioException catch (e) {
      log('DioException: ${e.message}', error: e);
      throw DioException(
        requestOptions: e.requestOptions,
        message: e.message,
        response: e.response,
        type: e.type,
        error: e.error,
        stackTrace: e.stackTrace,
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
