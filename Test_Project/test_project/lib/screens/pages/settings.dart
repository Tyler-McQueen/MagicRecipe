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
      body: Stack(
      ));
  }
}