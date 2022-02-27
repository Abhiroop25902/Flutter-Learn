import 'package:flutter/material.dart';
import 'package:weather/Pages/widgets/weather_card.dart';
import 'package:weather/utils/weather_info.dart';

class AddedLocationPage extends StatelessWidget {
  const AddedLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Locations'),
        //TODO: add on pressed
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
            WeatherCard(weatherInfo: WeatherInfo.getDummy()),
          ]),
    );
  }
}
