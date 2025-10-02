import '../../domain/entities/cordinates_entity.dart';

class CoordinatesModel extends CoordinatesEntity {
  const CoordinatesModel({required super.longitude, required super.latitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      longitude: (json['lon'] as num).toDouble(),
      latitude: (json['lat'] as num).toDouble(),
    );
  }
}
