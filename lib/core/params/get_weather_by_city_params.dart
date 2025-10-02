class GetWeatherByCityParams {
  final String cityName;
  String? units;
  final String? languageCode;

  GetWeatherByCityParams({
    required this.cityName,
    this.units,
    this.languageCode,
  });
}
