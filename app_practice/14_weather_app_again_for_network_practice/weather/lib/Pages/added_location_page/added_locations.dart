import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/Pages/widgets/weather_card.dart';

class AddedLocations with ChangeNotifier {
  Set<String> _locations = {};
  late final SharedPreferences prefs;

  get locations => _locations.toList();

  final _myListKey = GlobalKey<AnimatedListState>();
  get listKey => _myListKey;

  AddedLocations() {
    _setup();
  }

  void _setup() async {
    prefs = await SharedPreferences.getInstance();
    _locations = prefs.getStringList('addedLocations')?.toSet() ?? {};
    notifyListeners();
  }

  void addLocation(String location) {
    _locations.add(location);
    _myListKey.currentState?.insertItem(locations.length - 1);
    notifyListeners();
  }

  void removeLocation(String location) {
    int idx = _locations.toList().indexOf(location);
    _locations.remove(location);
    _myListKey.currentState?.removeItem(
        idx,
        (context, animation) => SizeTransition(
              sizeFactor: animation.drive(Tween(begin: 0, end: 1)),
              child: WeatherCard(
                location: location,
                addedLocations: this,
              ),
            ));
    notifyListeners();
  }

  @override
  void dispose() {
    prefs.setStringList('addedLocations', _locations.toList());
    super.dispose();
  }
}
