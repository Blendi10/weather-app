import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/params/get_weather_params.dart';
import 'package:weather_app/core/utils/location_helper.dart';
import 'package:weather_app/core/utils/unit_cache.dart';

import '../../../core/resources/data_state.dart';
import '../../domain/usecases/get_weather_by_city_usecase.dart';
import '../../domain/usecases/get_weather_usecase.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  final GetWeatherByCityUseCase getWeatherByCityUseCase;
  WeatherBloc(this.getWeatherUseCase, this.getWeatherByCityUseCase)
    : super(const WeatherLoading()) {
    on<GetWeather>(getWeather);
    on<GetWeatherByCity>(getWeatherByCity);
    on<RefreshWeather>(refreshWeather);
  }

  void getWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final dataState = await getWeatherUseCase.call(params: event.params);

    if (dataState is DataSuccess && dataState.data != null) {
      await LocationHelper.cachePosition(
        Position(
          longitude: dataState.data!.coordinates.longitude,
          latitude: dataState.data!.coordinates.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
      );
      emit(WeatherDone(dataState.data, event.params.units));
    }

    if (dataState is DataFailed) {
      emit(WeatherError(dataState.exception));
    }
  }

  void refreshWeather(RefreshWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    Position? position = await LocationHelper.loadCachedPosition();
    String units = await UnitCache.loadUnit();
    final dataState = await getWeatherUseCase.call(
      params: GetWeatherParams(
        lat: position!.latitude,
        lon: position.longitude,
        units: units,
      ),
    );

    if (dataState is DataSuccess && dataState.data != null) {
      emit(WeatherDone(dataState.data, units));
    }

    if (dataState is DataFailed) {
      emit(WeatherError(dataState.exception));
    }
  }

  void getWeatherByCity(
    GetWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    event.params.units = await UnitCache.loadUnit();
    final dataState = await getWeatherByCityUseCase.call(params: event.params);
    emit(WeatherLoading());

    if (dataState is DataSuccess && dataState.data != null) {
      await LocationHelper.cachePosition(
        Position(
          longitude: dataState.data!.coordinates.longitude,
          latitude: dataState.data!.coordinates.latitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
      );
      emit(WeatherDone(dataState.data, event.params.units));
    }

    if (dataState is DataFailed) {
      emit(WeatherError(dataState.exception));
    }
  }
}
