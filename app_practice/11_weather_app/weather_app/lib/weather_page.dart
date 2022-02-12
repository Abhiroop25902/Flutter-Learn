import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherInfo {
  final String name;
  final String region;
  final String country;
  final String localTime;
  final int tempC;
  final int tempF;
  final String iconUrl;

  WeatherInfo({
    required this.name,
    required this.region,
    required this.country,
    required this.localTime,
    required this.tempC,
    required this.tempF,
    required this.iconUrl,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        name: json['location']['name'],
        region: json['location']['region'],
        country: json['location']['country'],
        localTime: json['location']['localtime'],
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
        localTime: '',
        iconUrl: 'https://picsum.photos/200/300');
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key, required this.weatherInfo}) : super(key: key);

  final WeatherInfo weatherInfo;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late String _timeString;
  late WeatherInfo weatherInfo;

  @override
  void initState() {
    weatherInfo = widget.weatherInfo;
    _timeString = _formatDateTime(DateTime.parse(weatherInfo.localTime));
    Timer.periodic(const Duration(seconds: 1), (timer) => _getTime());
    super.initState();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  void _getTime() {
    final DateTime now =
        DateTime.parse(_timeString).add(const Duration(seconds: 1));
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

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
          Text(_timeString, style: const TextStyle(fontSize: 20)),
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
