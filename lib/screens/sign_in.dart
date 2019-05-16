import 'package:flutter/material.dart';

// The sign in component will show up if the user has clicked the sign in button from the signup screen.
// The goal of the screen is to get the user to log in with their already created email and password.
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Sign In"),
              onPressed: () {
                Navigator.pushNamed(ctx, '/');
              },
            ),
            FlatButton(
              child: Text("Don't have an account? Sign Up"),
              onPressed: () {
                Navigator.pushNamed(ctx, '/sign-up');
              },
            ),
          ]),
    ));
  }
}
