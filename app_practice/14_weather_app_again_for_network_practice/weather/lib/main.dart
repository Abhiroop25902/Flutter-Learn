/// refer here for PageView and navbar stuffs
/// https://stackoverflow.com/questions/61269906/flutter-bottom-navigation-bar-with-pageview

import 'package:flutter/material.dart';
import 'package:weather/Pages/added_location_page.dart';
import 'package:weather/Pages/curr_location_page.dart';
import 'package:weather/utils/app_scroller.dart';

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
      scrollBehavior: AppScrollBehavior(),
      title: 'Weather',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'OpenSans_app'),
      home: Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _idx = index;
              });
            },
            children: const [CurrLocationWeatherPage(), AddedLocationPage()]),
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
}
