import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/utils/unit_cache.dart';
import 'package:weather_app/injection_container.dart';

import 'core/params/get_weather_params.dart';
import 'core/utils/location_helper.dart';
import 'features/presentation/bloc/weather_bloc.dart';
import 'features/presentation/bloc/weather_event.dart';
import 'features/presentation/screens/weather_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDependencies();

  Position position = await LocationHelper.getCurrentOrDefaultPosition();
  String units = await UnitCache.loadUnit();

  runApp(MyApp(lat: position.latitude, lon: position.longitude, units: units));
}

class MyApp extends StatelessWidget {
  final double lat;
  final double lon;
  final String units;

  const MyApp({
    super.key,
    required this.lat,
    required this.lon,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => sl()
        ..add(
          GetWeather(
            params: GetWeatherParams(lat: lat, lon: lon, units: units),
          ),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const WeatherScreen(),
      ),
    );
  }
}
