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
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(children: <Widget>[
          const Flexible(
            flex: 6,
            child: Image(
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/magic-recipe-1bbfe.appspot.com/o/app%2Flogo.png?alt=media&token=9179b1ae-3d73-4d3b-8925-d44ddc132ce9'),
            ),
          ),
          Flexible(
              flex: 4,
              child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Login',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: FractionallySizedBox(
                      widthFactor: .8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.signinEmailAccount(
                              emailController.text, passwordController.text);
                          if (result == null) {
                            print('error signing in');
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('ERROR'),
                                      content: const Text(
                                          'Something Went Wrong! Username or Password Do Not Match.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          } else {
                            print('signed in');
                            print(result.uid);
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: FractionallySizedBox(
                      widthFactor: .8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                          dynamic result = await _auth.registerEmailAccount(
                              emailController.text, passwordController.text);
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ),
                ]),
              )),
        ]),
      ),
    );
  }
}
