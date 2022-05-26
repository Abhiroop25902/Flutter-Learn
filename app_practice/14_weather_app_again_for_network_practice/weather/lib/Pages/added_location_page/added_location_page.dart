import 'package:flutter/material.dart';
import 'package:weather/Pages/added_location_page/added_locations.dart';
import 'package:weather/Pages/widgets/add_loc_alert.dart';
import 'package:weather/Pages/widgets/mixin/weather.dart';
import 'package:weather/Pages/widgets/weather_card.dart';
import 'package:provider/provider.dart';

class AddedLocationPage extends StatelessWidget {
  const AddedLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddedLocations>(
      create: (context) => AddedLocations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Locations'),
          actions: [
            Consumer<AddedLocations>(
              builder: (context, addedLocation, child) => IconButton(
                  onPressed: () =>
                      showAddLocationDialog(context, addedLocation),
                  icon: const Icon(Icons.add)),
            )
          ],
        ),
        body:
            Consumer<AddedLocations>(builder: (context, addedLocation, child) {
          if (addedLocation.locations.isNotEmpty) {
            return AnimatedList(
                key: addedLocation.listKey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                initialItemCount: addedLocation.locations.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(Tween(
                        begin: const Offset(0, 0.5), end: const Offset(0, 0))),
                    child: WeatherCard(
                      location: addedLocation.locations[index],
                      addedLocations: addedLocation,
                    ),
                  );
                });
          } else {
            return const Center(
                child: Opacity(
              opacity: 0.5,
              child: Text(
                'Add location using + icon',
                style: TextStyle(fontSize: 25),
              ),
            ));
          }
        }),
      ),
    );
  }

  Future<dynamic> showAddLocationDialog(
      BuildContext context, AddedLocations addedLocations) {
    return showDialog(
        context: context,
        builder: (context) => AddLocAlert(addedLocations: addedLocations));
  }
}
