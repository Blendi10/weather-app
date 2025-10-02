import '../../../core/params/get_weather_by_city_params.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/weather_entity.dart';
import '../repository/weather_repository.dart';

class GetWeatherByCityUseCase
    implements UseCase<DataState<WeatherEntity>, GetWeatherByCityParams> {
  final WeatherRepository repository;
  const GetWeatherByCityUseCase(this.repository);

  @override
  Future<DataState<WeatherEntity>> call({
    GetWeatherByCityParams? params,
  }) async {
    if (params == null) {
      throw ArgumentError('GetOneCallWeatherParams cannot be null');
    }
    return repository.getWeatherByCity(
      cityName: params.cityName,
      units: params.units,
      languageCode: params.languageCode,
    );
  }
}
