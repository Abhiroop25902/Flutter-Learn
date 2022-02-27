import 'package:flutter/material.dart';
import 'package:weather/Pages/widgets/mixin/weather.dart';
import 'package:weather/utils/time_widget.dart';
import 'package:weather/utils/weather_info.dart';

class WeatherCard extends StatelessWidget with Weather {
  WeatherCard({Key? key, required WeatherInfo weatherInfo}) : super(key: key) {
    initWeather(weatherInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeWidget(
                  timeString: weatherInfo.localTime,
                  textStyle: const TextStyle(fontSize: 30),
                ),
                Text(
                  location,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          weatherRow()
        ]),
      ),
    );
  }
}
