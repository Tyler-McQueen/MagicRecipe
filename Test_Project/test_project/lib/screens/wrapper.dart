import 'package:flutter/material.dart';
import 'package:test_project/screens/authenticate/authenticate.dart';
import 'package:test_project/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    //Return either home or authenticate widget
    return Authenticate();
    
  }
}