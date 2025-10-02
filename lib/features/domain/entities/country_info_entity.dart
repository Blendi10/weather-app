import 'package:equatable/equatable.dart';

class CountryInfoEntity extends Equatable {
  final String countryCode;
  final int sunriseTime;
  final int sunsetTime;

  const CountryInfoEntity({
    required this.countryCode,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  List<Object?> get props => [countryCode, sunriseTime, sunsetTime];
}
