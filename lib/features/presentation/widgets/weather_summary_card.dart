import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../domain/entities/weather_entity.dart';
import 'metric_chip.dart';
import 'pill_widget.dart';

class WeatherSummaryCard extends StatelessWidget {
  final WeatherEntity? weather;
  final String unitSymbol;
  final String windUnit;

  const WeatherSummaryCard({
    super.key,
    required this.weather,
    this.unitSymbol = '°C',
    this.windUnit = 'm/s',
  });

  @override
  Widget build(BuildContext context) {
    final w = weather;
    final theme = Theme.of(context);

    if (w == null) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final condition = w.conditions.isNotEmpty ? w.conditions.first : null;
    final iconUrl = condition != null
        ? getWeatherIconUrl(condition.icon)
        : null;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.place, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    w.cityName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Pill(text: '${w.clouds.coverage}% clouds'),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            w.metrics.temperature.toStringAsFixed(0),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 6),
                            child: Text(
                              unitSymbol,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        condition?.description ?? (condition?.group ?? '—'),
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Feels like ${w.metrics.feelsLike.toStringAsFixed(0)}$unitSymbol',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                if (iconUrl != null)
                  Image.network(iconUrl, width: 72, height: 72),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                MetricChip(
                  icon: Icons.arrow_downward,
                  label:
                      'Min ${w.metrics.minTemperature.toStringAsFixed(0)}$unitSymbol',
                ),
                MetricChip(
                  icon: Icons.arrow_upward,
                  label:
                      'Max ${w.metrics.maxTemperature.toStringAsFixed(0)}$unitSymbol',
                ),
                MetricChip(
                  icon: Icons.water_drop,
                  label: 'Humidity ${w.metrics.humidity}%',
                ),
                MetricChip(
                  icon: Icons.speed,
                  label: 'Pressure ${w.metrics.pressure} hPa',
                ),
                MetricChip(
                  icon: Icons.air,
                  label:
                      'Wind ${w.wind.speed.toStringAsFixed(1)} $windUnit'
                      '${' •  ${w.wind.directionDegrees}° '}',
                ),
                if (w.rain?.lastHourVolume != null)
                  MetricChip(
                    icon: Icons.grain,
                    label:
                        'Rain ${w.rain?.lastHourVolume?.toStringAsFixed(1)} mm}',
                  ),
                if (w.snow?.lastHourVolume != null)
                  MetricChip(
                    icon: Icons.ac_unit,
                    label:
                        'Snow ${w.snow?.lastHourVolume?.toStringAsFixed(1)} mm',
                  ),
                MetricChip(
                  icon: Icons.public,
                  label: w.countryInfo.countryCode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
