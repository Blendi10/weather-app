import '../../domain/entities/country_info_entity.dart';

class CountryInfoModel extends CountryInfoEntity {
  const CountryInfoModel({
    required super.countryCode,
    required super.sunriseTime,
    required super.sunsetTime,
  });

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      countryCode: json['country'] as String,
      sunriseTime: json['sunrise'] as int,
      sunsetTime: json['sunset'] as int,
    );
  }
}
