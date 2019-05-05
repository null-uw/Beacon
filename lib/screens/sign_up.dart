import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Sign up"),
              onPressed: () {
                Navigator.pushNamed(ctx, '/');
              },
            ),
            FlatButton(
              child: Text("Already have an account? Sign In"),
              onPressed: () {
                Navigator.pushNamed(ctx, '/sign-in');
              },
            ),
          ]),
    ));
  }
}
