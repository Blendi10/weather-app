import '../../domain/entities/wind_entity.dart';

class WindModel extends WindEntity {
  const WindModel({
    required super.speed,
    required super.directionDegrees,
    super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: (json['speed'] as num).toDouble(),
      directionDegrees: json['deg'] as int,
      gust: json['gust'] != null ? (json['gust'] as num).toDouble() : null,
    );
  }
}
