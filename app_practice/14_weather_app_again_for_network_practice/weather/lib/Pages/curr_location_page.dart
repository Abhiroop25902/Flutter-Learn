import 'package:flutter/material.dart';
import 'package:weather/utils/weather_info.dart';

import 'package:weather/utils/weather_networking.dart' as weather_api;

import 'widgets/weather_screen.dart';

class CurrLocationWeatherPage extends StatelessWidget {
  const CurrLocationWeatherPage({Key? key, this.appBar, this.future})
      : super(key: key);

  final AppBar? appBar;
  final Future<WeatherInfo>? future;

  FutureBuilder<WeatherInfo> _currLocationWeatherPage() {
    return FutureBuilder<WeatherInfo>(
      future: future ?? weather_api.requestCurrLoc,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: WeatherScreen(
              weatherInfo: snapshot.data!,
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: AlertDialog(
              title: Text("${snapshot.error}"),
            ),
          );
          // Center(child: Text("${snapshot.error}"));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _currLocationWeatherPage(),
    );
  }
}
