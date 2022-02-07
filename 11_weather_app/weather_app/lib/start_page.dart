import 'package:flutter/material.dart';

import 'weather_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submitResponse(String input) {
    if (input.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NetworkGetter(location: input),
          ));
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
