import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
  
}

class _SettingsState extends State<Settings> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'enter new User Name',
                //border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            TextField(
              decoration: InputDecoration(
                hintText: 'enter new password',
                //  border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            TextField(
              decoration: InputDecoration(
                hintText: 'enter new email',
                //  border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            Spacer(),
            ElevatedButton(
              child: Text('Change user Info'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  fixedSize: Size(screenWidth, screenHeight / 8),
                  textStyle: TextStyle(fontSize: 40),
                  primary: Colors.green[400],
                  onPrimary: Color.fromARGB(255, 250, 250, 250)),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
            ElevatedButton(
              child: Text('LogOut'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  fixedSize: Size(screenWidth, screenHeight / 8),
                  textStyle: TextStyle(fontSize: 40),
                  primary: Colors.green[400],
                  onPrimary: Color.fromARGB(255, 250, 250, 250)),
            ),
          ],
        ),
      ),
    );
  }
  }