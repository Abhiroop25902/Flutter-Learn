import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather_page.dart';
import 'package:geolocator/geolocator.dart';

class GeographicLocation {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getPositionString() async {
    final position = await _determinePosition();
    return "${position.latitude.toString()},${position.longitude.toString()}";
  }
}

Future<WeatherInfo> getRequest() async {
  final queryParameters = {
    'key': 'ac47448b620f4482868174026212712',
    'q': await GeographicLocation.getPositionString(),
  };

  final uri =
      Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Weather Info');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  late int _idx;
  late PageController _pageController;

  @override
  void initState() {
    _idx = 0;
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _idx = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _idx = index;
              });
            },
            children: [_currLocationWeatherPage(), const Text('Hello')]),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _idx,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),
                  label: 'Current Position'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_city_sharp), label: 'Extra Cities')
            ],
            onTap: (idx) {
              _onItemTapped(idx);
            }),
      ),
    );
  }

  FutureBuilder<WeatherInfo> _currLocationWeatherPage() {
    return FutureBuilder<WeatherInfo>(
      future: getRequest(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WeatherScreen(
            weatherInfo: snapshot.data!,
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Location Permission not allowed')),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
