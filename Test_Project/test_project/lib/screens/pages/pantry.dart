import 'package:flutter/material.dart';

class Pantry2 extends StatefulWidget {
  @override
  _Pantry2State createState() => _Pantry2State();
}

class _Pantry2State extends State<Pantry2> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("PANTRY"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

