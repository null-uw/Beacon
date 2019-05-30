import 'package:flutter/material.dart';
import 'widgets/authentication.dart';
import 'widgets/root_page.dart';

// Entry point for the Flutter application
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/sign_in':(context) => LoginSignUpPage(auth:new Auth()),
      //   '/sign_up': (context) => LoginSignUpPage(auth:new Auth())
      // },
      title:'Beacon',
      theme: new ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: RootPage(auth: new Auth())
    );
  }
}

