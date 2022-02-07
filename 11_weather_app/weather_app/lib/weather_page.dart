import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherInfo {
  final String name;
  final String region;
  final String country;
  final int tempC;
  final int tempF;
  final String iconUrl;

  WeatherInfo({
    required this.name,
    required this.region,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.iconUrl,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        name: json['location']['name'],
        region: json['location']['region'],
        country: json['location']['country'],
        tempC: (json['current']['temp_c'] as double).round(),
        tempF: (json['current']['temp_f'] as double).round(),
        iconUrl: 'http:' + json['current']['condition']['icon']);
  }

  factory WeatherInfo.dummy() {
    return WeatherInfo(
        name: '',
        region: '',
        tempC: 0,
        tempF: 0,
        country: '',
        iconUrl: 'https://picsum.photos/200/300');
  }
}

class NetworkGetter extends StatelessWidget {
  const NetworkGetter({Key? key, required this.location}) : super(key: key);

  final String location;

  Future<WeatherInfo> _getWeatherInfo(
      BuildContext context, String location) async {
    final queryParameters = {
      'key': 'ac47448b620f4482868174026212712',
      'q': location,
    };

    final uri =
        Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: Text(jsonDecode(response.body)['error']['message']));
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                content: Text('Error: No Interet Connection'));
          });
    }
    return WeatherInfo.dummy();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherInfo>(
        future: _getWeatherInfo(context, location),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An Error has occured'),
            );
          } else if (snapshot.hasData) {
            return WeatherPage(weatherInfo: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.weatherInfo}) : super(key: key);

  final WeatherInfo weatherInfo;

  Widget _getWeatherRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${weatherInfo.tempC}',
          style: const TextStyle(fontSize: 100),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: const Text(
            '°C',
            style: TextStyle(fontSize: 50),
          ),
        ),
        Image.network(
          weatherInfo.iconUrl,
          height: 100,
          fit: BoxFit.fitHeight,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(weatherInfo.name)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getWeatherRowWidget(),
          Text(
            weatherInfo.region.isNotEmpty && !weatherInfo.region.contains(',')
                ? '${weatherInfo.name}, ${weatherInfo.region}'
                : '${weatherInfo.name}, ${weatherInfo.country}',
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
