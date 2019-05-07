import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;

import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/home_screen.dart';

// Entry point for the Flutter application
Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:940614893575:ios:37266125a5e1c1b7',
            databaseURL: 'https://beacon-1177a.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:940614893575:android:37266125a5e1c1b7',
            databaseURL: 'https://beacon-1177a.firebaseio.com',
          ),
  );
  runApp(MyApp(app: app));
}

class MyApp extends StatefulWidget {
  MyApp({this.app});
  final FirebaseApp app;

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyApp> {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/sign-in': (context) => SignIn(),
        '/sign-up': (context) => SignUp(),
      },
      initialRoute: '/sign-in',
    );
  }
}
