import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listWidgets = nouns
        .map((e) => Container(
              width: 100,
              height: 100,
              child: Center(
                child: Text(e.toString()),
              ),
            ))
        .toList();

    return Scaffold(
        // body: ListView.builder(
        //     itemBuilder: (context, index) =>
        //         listWidgets[index % listWidgets.length]),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) =>
                listWidgets[index % listWidgets.length]));
  }
}
