import 'package:flutter/material.dart';
import 'package:test_project/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_project/services/auth.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'models/myuser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_,__) {},
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

