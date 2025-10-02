import '../../../core/params/get_weather_params.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/weather_entity.dart';
import '../repository/weather_repository.dart';

class GetWeatherUseCase
    implements UseCase<DataState<WeatherEntity>, GetWeatherParams> {
  final WeatherRepository repository;
  const GetWeatherUseCase(this.repository);

  @override
  Future<DataState<WeatherEntity>> call({GetWeatherParams? params}) async {
    if (params == null) {
      throw ArgumentError('GetOneCallWeatherParams cannot be null');
    }
    return repository.getWeather(
      lat: params.lat,
      lon: params.lon,
      units: params.units,
      languageCode: params.languageCode,
    );
  }
}
