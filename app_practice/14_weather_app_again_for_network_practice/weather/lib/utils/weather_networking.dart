import 'package:weather/utils/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/utils/weather_info.dart';

Future<WeatherInfo> get requestCurrLoc async {
  final queryParameters = {
    'key': 'ac47448b620f4482868174026212712',
    'q': await GeographicLocation.currLocationString,
  };

  final uri =
      Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    String errorMessage = jsonDecode(response.body)['error']['message'];
    throw Exception(errorMessage);
  } else {
    throw Exception('Failed to load Weather Info');
  }
}
