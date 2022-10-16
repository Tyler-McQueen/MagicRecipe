// ignore_for_file: sort_child_properties_last

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test_project/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign Into Magic Recipe'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child:TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter A Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter A Password',
                ),
              ),
            ),
          ],
        ),
        
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(height: 70.0),
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              left: 100,
              bottom: 40,
              child: FloatingActionButton.extended(
                icon: Icon(Icons.login),
                onPressed: () async {await _auth.signOut();
                  dynamic result = await _auth.registerEmailAccount(emailController.text, passwordController.text);
                }, 
              label: Text('Register'),
              ),
            ),
            Positioned(
              right: 100,
              bottom: 40,
              child: FloatingActionButton.extended(
                icon: Icon(Icons.login),
                onPressed: () async {
                    dynamic result = await _auth.signinEmailAccount(emailController.text, passwordController.text);
                    if (result == null){
                      print('error signing in');
                    } else {
                      print('signed in');
                      print(result.uid);
                    }
                }, 
              label: Text('LOGIN'),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
    );
  }
}