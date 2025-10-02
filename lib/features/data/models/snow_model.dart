import '../../domain/entities/snow_entity.dart';

class SnowModel extends SnowEntity {
  const SnowModel({super.lastHourVolume});

  factory SnowModel.fromJson(Map<String, dynamic> json) {
    return SnowModel(
      lastHourVolume: json['1h'] != null
          ? (json['1h'] as num).toDouble()
          : null,
    );
  }
}
