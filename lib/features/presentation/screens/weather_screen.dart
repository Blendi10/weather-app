import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/params/get_weather_by_city_params.dart';
import '../widgets/unit_btn.dart';
import '../../../core/params/no_params.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_summary_card.dart';
import '../widgets/city_picker_bottomsheet.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Weather',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () async {
              final String city = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => const CityPickerSheet(),
              );

              if (context.mounted) {
                context.read<WeatherBloc>().add(
                  GetWeatherByCity(
                    params: GetWeatherByCityParams(cityName: city),
                  ),
                );
              }
            },
          ),
          UnitBtn(),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              context.read<WeatherBloc>().add(
                RefreshWeather(params: NoParams()),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WeatherDone) {
            final weather = state.weatherData;

            final imgUrl = getWeatherIcon(
              weather?.conditions.first.group ?? '',
            );
            ;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(imgUrl),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  WeatherSummaryCard(
                    weather: weather,
                    unitSymbol: getUnitSymbol(state.units!),
                    windUnit: getWindUnit(state.units!),
                  ),
                ],
              ),
            );
          }

          if (state is WeatherError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.exception?.message ?? 'Please try again.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(
                          const RefreshWeather(params: NoParams()),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String getUnitSymbol(String? units) {
    switch (units) {
      case 'metric':
        return '°C';
      case 'imperial':
        return '°F';
      case 'standard':
        return 'K';
      default:
        return '°C';
    }
  }

  String getWindUnit(String units) {
    switch (units) {
      case 'metric':
        return 'm/s';
      case 'imperial':
        return 'mph';
      default:
        return 'm/s';
    }
  }

  String getWeatherIcon(String group) {
    switch (group) {
      case 'Rain':
        return 'assets/images/rain.png';
      case 'Snow':
        return 'assets/images/snow.png';
      case 'Clouds':
      case 'Cloud':
        return 'assets/images/cloud.png';
      default:
        return 'assets/images/sun.png';
    }
  }
}
