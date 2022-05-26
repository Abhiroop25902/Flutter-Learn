/// refer here for PageView and navbar stuffs
/// https://stackoverflow.com/questions/61269906/flutter-bottom-navigation-bar-with-pageview

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather/Pages/added_location_page/added_location_page.dart';
import 'package:weather/Pages/curr_location_page.dart';
import 'package:weather/utils/app_scroller.dart';
import 'package:system_proxy/system_proxy.dart';

// FOR PROXY DETECTION -> source https://github.com/kaivean/system_proxy
class ProxiedHttpOverrides extends HttpOverrides {
  final String _port;
  final String _host;
  ProxiedHttpOverrides(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      // set proxy
      ..findProxy = (uri) {
        return _host.isNotEmpty ? "PROXY $_host:$_port;" : 'DIRECT';
      };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, String>? proxy = await SystemProxy.getProxySettings();

  if (proxy != null) {
    HttpOverrides.global = ProxiedHttpOverrides(proxy['host']!, proxy['port']!);
  }
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
      theme:
          ThemeData(brightness: Brightness.light, fontFamily: 'OpenSans_app'),
      darkTheme:
          ThemeData(brightness: Brightness.dark, fontFamily: 'OpenSans_app'),
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
