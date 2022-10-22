import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pantryAddItems.dart';

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
        onPressed: () => _dialogBuilder(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  final optionscreen = pantryAddItem();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: double.infinity,
          width: 700,
          child: optionscreen,
        ),
      );
    }
  );
}

