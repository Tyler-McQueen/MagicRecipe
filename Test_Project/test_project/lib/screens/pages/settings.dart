import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:test_project/screens/authenticate/sign_in.dart';
import 'package:test_project/screens/authenticate/signinpagetest.dart';
import 'package:test_project/screens/pages/pantryHome.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int count = 0;

  final _formKey = GlobalKey<FormState>();

  var newPassword = '';
  var newEmail = '';

  final newPasswordController = TextEditingController();
  final newEmailController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    newEmailController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  changeUserInfo() async {
    try {
      await currentUser?.updateEmail(newEmail);
    } catch (error) {}

    try {
      await currentUser!.updatePassword(newPassword);
    } catch (error) {}

    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings Page'),
          backgroundColor: Colors.green[400]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Enter new password',
                  ),
                  controller: newPasswordController,
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter new email',
                  ),
                  controller: newEmailController,
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('Change Account Info'),
                  onPressed: () {
                    setState(() {
                      newPassword = newPasswordController.text;
                      newEmail = newEmailController.text;
                    });
                    changeUserInfo();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      fixedSize: Size(screenWidth, screenHeight / 15),
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.green[400],
                      onPrimary: Color.fromARGB(255, 250, 250, 250)),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('LogOut'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10.0),
                      fixedSize: Size(screenWidth, screenHeight / 15),
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.green[400],
                      onPrimary: Color.fromARGB(255, 250, 250, 250)),
                )),
          ],
        ),
      ),
    );
  }
}
