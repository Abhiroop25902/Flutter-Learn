import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/selection_screen');

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _navigateAndDisplaySelection(context),
            child: const Text('Pick an option, any option!')),
      ),
    );
  }
}
