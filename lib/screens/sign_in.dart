import 'package:flutter/material.dart';

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
