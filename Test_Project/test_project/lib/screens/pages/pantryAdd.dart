import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';

class PantryAdd extends StatefulWidget {
  @override
  _PantryAddState createState() => _PantryAddState();
}

class _PantryAddState extends State<PantryAdd> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
          Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration( 
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey ,
                  blurRadius: 6.0,
                  offset: Offset(0,2)
                )
              ],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)),
            ),
            width: double.infinity,
            height: 90,
            child: const Text(
              "PANTRY",
            ),
          ),
          
      ]),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),*/
    );
  }
}

/*
Future<void> _dialogBuilder(BuildContext context) {
  final optionscreen = pantryAddItem();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: double.infinity,
          width: 700,
          child: optionscreen,
        ),
      );
    }
  );
}
*/

