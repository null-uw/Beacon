import 'package:flutter/material.dart';

import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
