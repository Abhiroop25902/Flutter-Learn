import 'package:flutter/material.dart';
import 'package:weather/utils/weather_info.dart';

mixin Weather {
  late final WeatherInfo _weatherInfo;

  get weatherInfo => _weatherInfo;

  initWeather(WeatherInfo weatherInfo) {
    _weatherInfo = weatherInfo;
  }

  String get location =>
      "${weatherInfo.name}, " +
      ((weatherInfo.region.isEmpty || weatherInfo.region.contains(','))
          ? weatherInfo.country
          : weatherInfo.region);

  Widget weatherRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weatherInfo.tempC}',
          style: const TextStyle(fontSize: 80),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: const Text(
            '°C',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Image.network(weatherInfo.iconUrl)
      ],
    );
  }
}
