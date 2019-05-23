import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The sign in component will show up if the user has clicked the sign in button from the signup screen.
// The goal of the screen is to get the user to log in with their already created email and password.
class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignInPageState();
}

enum FormType { login, register }

class _SignInPageState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  bool _combo = true;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit(BuildContext ctx) async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.register) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email, password: _password);

          //TODO: create user node with the given name
        }
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.pushReplacementNamed(ctx, '/');
        } catch (e) {
          setState(() {
            _combo = false;
          });
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  void moveToRegister() {
    setState(() {
      _combo = true;
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  String checkVal(String val) {
    if (val.isEmpty) {
      return "Cannot be empty";
    } else if (!_combo) {
      return "Improper combination";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Beacon")),
        body: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Form(
              key: formKey,
              child:
                  new Column(children: buildInput() + buildSubmitButton(ctx)),
            )));
  }

  List<Widget> buildInput() {
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: "Email"),
          validator: (val) => val.isEmpty ? 'Email cannot be empty' : null,
          onSaved: (val) => _email = val,
        ),
        new TextFormField(
            decoration: new InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (val) => val.isEmpty ? 'Password cannot be empty' : null,
            onSaved: (val) => _password = val)
      ];
    } else {
      return [
        TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            validator: (val) => val.isEmpty ? 'Name cannot be empty' : null,
            onSaved: (val) => _name = val),
        TextFormField(
          decoration: InputDecoration(labelText: "Email"),
          validator: (val) => val.isEmpty ? 'Email cannot be empty' : null,
          onSaved: (val) => _email = val,
        ),
        TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (val) => val.isEmpty ? 'Password cannot be empty' : null,
            onSaved: (val) => _password = val)
      ];
    }
  }

  List<Widget> buildSubmitButton(BuildContext ctx) {
    if (!_combo) {
      return [
        new Text(
          "Invalid combination",
          style: TextStyle(
              fontSize: 20, fontStyle: FontStyle.italic, color: Colors.red),
        ),
        new RaisedButton(
          child: new Text('Sign In', style: TextStyle(fontSize: 20)),
          onPressed: () {
            validateAndSubmit(ctx);
          },
        ),
        new FlatButton(
            child: new Text('Create Account', style: TextStyle(fontSize: 20)),
            onPressed: moveToRegister)
      ];
    } else if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Sign In', style: TextStyle(fontSize: 20)),
          onPressed: () {
            validateAndSubmit(ctx);
          },
        ),
        new FlatButton(
            child: new Text('Create Account', style: TextStyle(fontSize: 20)),
            onPressed: moveToRegister)
      ];
    } else {
      return [
        new RaisedButton(
            child: new Text('Register', style: TextStyle(fontSize: 20)),
            onPressed: () {
              validateAndSubmit(ctx);
            }),
        new FlatButton(
            child: new Text('Already have an account? Sign in',
                style: TextStyle(fontSize: 20)),
            onPressed: moveToLogin)
      ];
    }
  }
}
