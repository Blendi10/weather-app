import '../../domain/entities/rain_entity.dart';

class RainModel extends RainEntity {
  const RainModel({super.lastHourVolume});

  factory RainModel.fromJson(Map<String, dynamic> json) {
    return RainModel(
      lastHourVolume: json['1h'] != null
          ? (json['1h'] as num).toDouble()
          : null,
    );
  }
}
