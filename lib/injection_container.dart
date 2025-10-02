import 'package:get_it/get_it.dart';

import 'features/domain/usecases/get_weather_by_city_usecase.dart';
import 'features/presentation/bloc/weather_bloc.dart';
import 'features/data/data_sources/weather_api_service.dart';
import 'features/data/repository/weather_repository_impl.dart';
import 'features/domain/repository/weather_repository.dart';
import 'features/domain/usecases/get_weather_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Api Service
  sl.registerSingleton<WeatherApiService>(WeatherApiService());

  //Repository
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetWeatherUseCase>(GetWeatherUseCase(sl()));
  sl.registerSingleton<GetWeatherByCityUseCase>(GetWeatherByCityUseCase(sl()));

  //Blocs
  sl.registerFactory<WeatherBloc>(() => WeatherBloc(sl(), sl()));
}
