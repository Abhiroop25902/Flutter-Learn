import 'dart:async';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Badges Experiments'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: CustomBadgeWidget(),
      ),
    );
  }
}

class CustomBadgeWidget extends StatefulWidget {
  const CustomBadgeWidget({Key? key}) : super(key: key);

  @override
  _CustomBadgeWidgetState createState() => _CustomBadgeWidgetState();
}

class _CustomBadgeWidgetState extends State<CustomBadgeWidget> {
  int _notifCount = 0;
  bool _showNextTime = false;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) => _updateNotifCount());
    super.initState();
  }

  _updateNotifCount() {
    _showNextTime = !_showNextTime;
    if (_notifCount >= 100 && !_showNextTime) return;
    setState(() {
      if (_showNextTime) _notifCount += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text(
        _notifCount >= 100 ? "99+" : _notifCount.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      badgeColor: Theme.of(context).colorScheme.primary,
      child: const Icon(
        Icons.notifications,
        size: 100,
      ),
      showBadge: _notifCount > 0 && _showNextTime,
      padding: const EdgeInsets.all(10),
      animationType: BadgeAnimationType.slide,
    );
  }
}
