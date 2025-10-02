import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? apiKey = dotenv.env['API_KEY'];
final String? baseUrl = dotenv.env['BASE_URL'];

const Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

String getWeatherIconUrl(String iconCode) {
  return '${dotenv.env['IMG_URL']}/$iconCode@2x.png';
}
