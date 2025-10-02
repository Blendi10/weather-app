class GetWeatherParams {
  final double lat;
  final double lon;
  final String? units;
  final String? languageCode;
  final List<String> exclude;

  const GetWeatherParams({
    required this.lat,
    required this.lon,
    this.units,
    this.languageCode,
    this.exclude = const [],
  });
}
