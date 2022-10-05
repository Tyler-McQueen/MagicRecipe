import 'package:flutter/material.dart';
import 'package:test_project/models/myuser.dart';
import 'package:test_project/screens/authenticate/authenticate.dart';
import 'package:test_project/screens/home/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<MyUser?>(context);
    print(user);
    //Return either home or authenticate widget

    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }

  }
}