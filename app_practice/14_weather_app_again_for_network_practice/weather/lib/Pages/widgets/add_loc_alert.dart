import 'package:flutter/material.dart';
import 'package:weather/Pages/added_location_page/added_locations.dart';

class AddLocAlert extends StatefulWidget {
  const AddLocAlert({Key? key, required this.addedLocations}) : super(key: key);

  final AddedLocations addedLocations;

  @override
  State<AddLocAlert> createState() => _AddLocAlertState();
}

class _AddLocAlertState extends State<AddLocAlert> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void addLocation() {
    var location = _textEditingController.text.toLowerCase();
    // var addedLocations = Provider.of<AddedLocations>(context, listen: false);
    widget.addedLocations.addLocation(location);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Location'),
      content: TextField(
        controller: _textEditingController,
        autofocus: true,
        onSubmitted: (value) {
          addLocation();
        },
        decoration: const InputDecoration(hintText: 'Enter a Place'),
      ),
      actions: [
        ElevatedButton(onPressed: addLocation, child: const Text('Search'))
      ],
    );
  }
}
