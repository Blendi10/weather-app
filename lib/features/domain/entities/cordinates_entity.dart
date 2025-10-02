import 'package:equatable/equatable.dart';

class CoordinatesEntity extends Equatable {
  final double longitude;
  final double latitude;

  const CoordinatesEntity({required this.longitude, required this.latitude});

  @override
  List<Object?> get props => [longitude, latitude];
}
