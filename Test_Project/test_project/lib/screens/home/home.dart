import 'package:test_project/screens/pages/pantryMain.dart';
import 'package:test_project/screens/pages/recipies.dart';
import 'package:test_project/screens/pages/shopping.dart';
import 'package:test_project/screens/pages/barcodeTest.dart';
import 'package:test_project/screens/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:test_project/services/auth.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Home extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<Home> {
  int currentIndex = 0;
  SnakeShape snakeShape = SnakeShape.circle;
  
  final screens = [
    Recipies1(),
    Pantry2(),
    Shopping3(),
    Barcode4(),
    Settings(),
  ];
  @override
  final AuthService _auth = AuthService();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      /*appBar: AppBar(
        title: const Text('Magic Recipe'),
        backgroundColor: Colors.green[500],
        elevation: 4.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              primary: Colors.white
            ),
          )
        ],
      ),*/
      body: screens[currentIndex],
      bottomNavigationBar: SnakeNavigationBar.color(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        elevation: 8,
        snakeShape: snakeShape,
        snakeViewColor: Colors.green,
        unselectedItemColor: Colors.green,
        //selectedItemColor: Colors.greenAccent,
        //selectedFontSize: 20,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Recipe',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: 'Pantry',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket,),
            label: 'Shopping List',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.barcode_reader,),
            label: 'Barcode Reader',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings,),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}