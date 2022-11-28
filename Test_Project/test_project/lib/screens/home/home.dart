import 'package:test_project/screens/pages/Pantry/pantryMain.dart';
import 'package:test_project/screens/pages/Recipe/recipiesnew.dart';
import 'package:test_project/screens/pages/Shopping/shopping.dart';
import 'package:test_project/screens/pages/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _homePageState createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<Home> {
  int currentIndex = 0;
  SnakeShape snakeShape = SnakeShape.circle;

  final screens = [
    RecipiesNew1(),
    Pantry2(),
    Shopping3(),
    Settings(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
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
            icon: Icon(
              Icons.shopping_basket,
            ),
            label: 'Shopping List',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
