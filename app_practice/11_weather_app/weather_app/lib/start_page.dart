import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'weather_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final controller = TextEditingController();

  void _showAlert(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(text));
        });
  }

  void _getWeatherInfo(BuildContext context, String location) async {
    final queryParameters = {
      'key': 'ac47448b620f4482868174026212712',
      'q': location,
    };

    final uri =
        Uri.http('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherPage(
            weatherInfo: WeatherInfo.fromJson(jsonDecode(response.body)));
      }));
    } else if (response.statusCode == 400) {
      _showAlert(jsonDecode(response.body)['error']['message']);
    } else {
      _showAlert('Error: No Interet Connection');
    }

    controller.text = "";
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submitResponse(String input) {
    if (input.isNotEmpty) {
      _getWeatherInfo(context, input);
    } else {
      _showAlert('Please Enter something');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Enter Place',
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: controller,
            onSubmitted: _submitResponse,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: 'Enter Place'),
            autofillHints: const ['mumbai', 'delhi', 'kolkata'],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
                onPressed: () => _submitResponse(controller.text),
                child: const Text('Search')),
          )
        ]),
      )),
    );
  }
}
