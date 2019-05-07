import 'package:flutter/material.dart';

// The sign up component will show up if the user had clicked on the sign up button from the sign in component.
// The sign up component will also have a sign in button that can redirect back to the sign in component.
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
