import 'package:equatable/equatable.dart';

class RainEntity extends Equatable {
  final double? lastHourVolume;

  const RainEntity({this.lastHourVolume});

  @override
  List<Object?> get props => [lastHourVolume];
}
