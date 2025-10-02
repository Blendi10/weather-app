import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/utils/location_helper.dart';
import '../../../core/utils/unit_cache.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../../../core/params/get_weather_params.dart';

class UnitBtn extends StatefulWidget {
  const UnitBtn({super.key});

  @override
  State<UnitBtn> createState() => _UnitBtnState();
}

class _UnitBtnState extends State<UnitBtn> {
  String _selectedUnit = 'metric';

  @override
  void initState() {
    super.initState();
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final unit = await UnitCache.loadUnit();
    setState(() {
      _selectedUnit = unit;
    });
  }

  void _changeUnit(String unit) async {
    setState(() {
      _selectedUnit = unit;
    });
    await UnitCache.saveUnit(unit);
    Position? position = await LocationHelper.loadCachedPosition();

    if (mounted) {
      context.read<WeatherBloc>().add(
        GetWeather(
          params: GetWeatherParams(
            lat: position!.latitude,
            lon: position.longitude,
            units: unit,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Change Unit',
      color: Colors.white,
      initialValue: _selectedUnit,
      icon: const Icon(Icons.thermostat_outlined, color: Colors.black),
      onSelected: _changeUnit,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'metric',
          child: Row(
            children: [
              Radio<String>(
                value: 'metric',
                groupValue: _selectedUnit,
                onChanged: (v) => _changeUnit(v!),
              ),
              const Text('Metric (°C, m/s)'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'imperial',
          child: Row(
            children: [
              Radio<String>(
                value: 'imperial',
                groupValue: _selectedUnit,
                onChanged: (v) => _changeUnit(v!),
              ),
              const Text('Imperial (°F, mph)'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'standard',
          child: Row(
            children: [
              Radio<String>(
                value: 'standard',
                groupValue: _selectedUnit,
                onChanged: (v) => _changeUnit(v!),
              ),
              const Text('Standard (K)'),
            ],
          ),
        ),
      ],
    );
  }
}
