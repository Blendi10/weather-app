import 'package:equatable/equatable.dart';

class WindEntity extends Equatable {
  final double speed;
  final int directionDegrees;
  final double? gust;

  const WindEntity({
    required this.speed,
    required this.directionDegrees,
    this.gust,
  });

  @override
  List<Object?> get props => [speed, directionDegrees, gust];
}
