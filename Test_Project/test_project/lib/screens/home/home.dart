import 'package:test_project/screens/pages/pantry.dart';
import 'package:test_project/screens/pages/recipies.dart';
import 'package:test_project/screens/pages/shopping.dart';
import 'package:test_project/screens/pages/barcodeTest.dart';
import 'package:flutter/material.dart';
import 'package:test_project/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<Home> {
  int currentIndex = 0;
  final screens = [
    Recipies1(),
    Pantry2(),
    Shopping3(),
    Barcode4(),
  ];
  @override
  final AuthService _auth = AuthService();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        title: Text('Magic Recipe'),
        backgroundColor: Colors.green[500],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              primary: Colors.white
            ),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.greenAccent,
        selectedFontSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            backgroundColor: Colors.green,
            label: 'Recipies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            backgroundColor: Colors.green,
            label: 'Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            backgroundColor: Colors.green,
            label: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.barcode_reader),
            backgroundColor: Colors.green,
            label: 'Barcode Reader',
          ),
        ],
      ),
    );
  }
}