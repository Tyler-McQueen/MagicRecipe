// ignore: file_names
import 'package:flutter/material.dart';
import 'package:test_project/screens/pages/Pantry/pantryAdd.dart';
import 'package:test_project/screens/pages/Pantry/pantryHome.dart';

// ignore: use_key_in_widget_constructors
class Pantry2 extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Pantry2State createState() => _Pantry2State();
}

class _Pantry2State extends State<Pantry2> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page2(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PantryAdd(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantryAddItem(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page1()),
          );
        },
      ),
    );
  }
}
