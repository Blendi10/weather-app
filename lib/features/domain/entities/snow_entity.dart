import 'package:equatable/equatable.dart';

class SnowEntity extends Equatable {
  final double? lastHourVolume;

  const SnowEntity({this.lastHourVolume});

  @override
  List<Object?> get props => [lastHourVolume];
}
