import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/Pages/added_location_page/added_locations.dart';
import 'package:weather/Pages/curr_location_page.dart';
import 'package:weather/Pages/widgets/mixin/weather.dart';

import 'package:weather/utils/time_widget.dart';
import 'package:weather/utils/weather_info.dart';

import 'package:weather/utils/weather_networking.dart' as weather_api;

class WeatherCard extends StatelessWidget {
  WeatherCard({Key? key, required this.location, required this.addedLocations})
      : super(key: key);

  final String location;
  final AddedLocations addedLocations;

  @override
  Widget build(BuildContext context) {
    var _tapable = true;
    return GestureDetector(
      child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
            height: 130,
            child: FutureBuilder<WeatherInfo>(
              future: weather_api.requestLoc(location),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherCardInside(weatherInfo: snapshot.data!);
                } else if (snapshot.hasError) {
                  _tapable = false;
                  String errorString;
                  if (snapshot.error.toString() ==
                      'Exception: No matching location found.') {
                    errorString = "$location is not a valid location";
                  } else {
                    errorString = snapshot.error.toString();
                  }

                  return Center(
                    child: Text(
                      errorString,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
      onLongPress: () {
        HapticFeedback.vibrate();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Remove $location?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('NO')),
                    TextButton(
                        onPressed: () {
                          addedLocations.removeLocation(location);
                          Navigator.pop(context);
                        },
                        child: const Text('YES'))
                  ],
                ));
      },
      onTap: () {
        if (_tapable) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CurrLocationWeatherPage(
                appBar: AppBar(), future: weather_api.requestLoc(location));
          }));
        }
      },
    );
  }
}

class WeatherCardInside extends StatelessWidget with Weather {
  WeatherCardInside({Key? key, required WeatherInfo weatherInfo})
      : super(key: key) {
    initWeather(weatherInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeWidget(
                timeString: weatherInfo.localTime,
                textStyle: const TextStyle(fontSize: 25),
              ),
              Text(
                location,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        weatherRow(card: true)
      ]),
    );
  }
}
