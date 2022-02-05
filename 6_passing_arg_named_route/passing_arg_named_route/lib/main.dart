import 'package:flutter/material.dart';

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
      routes: {
        '/': (context) => const FirstRoute(),
        '/second': (context) => const SecondRoute()
      },
      initialRoute: '/',
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
          child: ElevatedButton(
              child: const Text('Open Route'),
              onPressed: () => Navigator.pushNamed(context, '/second',
                  arguments: PassObject('Random Heading', 'YOLO')))),
    );
  }
}

class PassObject {
  final String heading;
  final String message;

  PassObject(this.heading, this.message);
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passobj = ModalRoute.of(context)!.settings.arguments as PassObject;
    return Scaffold(
      appBar: AppBar(title: Text(passobj.heading)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(passobj.message),
          ),
          ElevatedButton(
            child: const Text("Go back"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
