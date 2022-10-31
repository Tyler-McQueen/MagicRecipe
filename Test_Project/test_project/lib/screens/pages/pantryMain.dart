import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:test_project/screens/pages/pantryAdd.dart';
import 'package:test_project/screens/pages/pantryHome.dart';

class Pantry2 extends StatefulWidget {
  @override
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

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PantryAdd(),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantryAddItem(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
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