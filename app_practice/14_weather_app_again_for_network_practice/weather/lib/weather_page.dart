import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class WeatherInfo {
  WeatherInfo(
      {required this.localTime,
      required this.tempC,
      required this.iconUrl,
      required this.name,
      required this.region,
      required this.country});

  final String localTime;
  final int tempC;
  final String iconUrl;
  final String name;
  final String region;
  final String country;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        name: json['location']['name'],
        region: json['location']['region'],
        country: json['location']['country'],
        localTime: json['location']['localtime'],
        tempC: (json['current']['temp_c'] as double).round(),
        iconUrl: 'http:' + json['current']['condition']['icon']);
  }

  factory WeatherInfo.getDummy() {
    return WeatherInfo(
        localTime: "2022-02-13 17:25",
        tempC: 9,
        iconUrl: "http:${"//cdn.weatherapi.com/weather/64x64/night/296.png"}",
        name: "London",
        region: "City of London, Greater London",
        country: "United Kingdom");
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key, required this.weatherInfo}) : super(key: key);

  final WeatherInfo weatherInfo;

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
              _weatherRow(),
              Text(
                _location,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  String get _location =>
      "${weatherInfo.name}, " +
      ((weatherInfo.region.isEmpty || weatherInfo.region.contains(','))
          ? weatherInfo.country
          : weatherInfo.region);

  _weatherRow() {
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

class TimeWidget extends StatefulWidget {
  const TimeWidget(
      {Key? key, this.textStyle = const TextStyle(), required this.timeString})
      : super(key: key);

  final String timeString;
  final TextStyle textStyle;

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String _timeString = "";
  late DateTime time;

  String _getTimeString() {
    return DateFormat('hh:mm a').format(time);
  }

  void _updateTime() {
    setState(() {
      time = time.add(const Duration(seconds: 1));
      _timeString = _getTimeString();
    });
  }

  @override
  void initState() {
    var timeStr = widget.timeString;
    //API has the tendency to give date in following format -> "2022-02-14 4:21"
    //lack of 0 in "4:21" (should be "04:21")
    //gives error in DateTime.parse, so covering that corner case
    if (timeStr.length == 15) {
      timeStr = timeStr.substring(0, 11) + '0' + timeStr.substring(11);
    }

    time = DateTime.parse(timeStr);
    _timeString = _getTimeString();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: widget.textStyle,
    );
  }
}
