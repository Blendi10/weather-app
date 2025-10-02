import 'package:equatable/equatable.dart';

class WeatherConditionEntity extends Equatable {
  final int conditionId;
  final String group;
  final String description;
  final String icon;

  const WeatherConditionEntity({
    required this.conditionId,
    required this.group,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [conditionId, group, description, icon];
}
