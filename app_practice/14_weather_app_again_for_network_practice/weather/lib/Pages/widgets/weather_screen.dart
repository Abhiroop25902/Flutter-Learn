import 'package:flutter/material.dart';
import 'package:weather/Pages/widgets/mixin/weather.dart';
import 'package:weather/utils/time_widget.dart';

import 'package:weather/utils/weather_info.dart';

class WeatherScreen extends StatelessWidget with Weather {
  WeatherScreen({Key? key, required weatherInfo}) : super(key: key) {
    initWeather(weatherInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeWidget(
                textStyle: const TextStyle(fontSize: 30),
                timeString: weatherInfo.localTime,
              ),
              weatherRow(),
              Text(
                location,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
