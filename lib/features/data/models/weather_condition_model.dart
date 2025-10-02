import '../../domain/entities/weather_condition_entity.dart';

class WeatherConditionModel extends WeatherConditionEntity {
  const WeatherConditionModel({
    required super.conditionId,
    required super.group,
    required super.description,
    required super.icon,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
      conditionId: json['id'] as int,
      group: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}
