import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home_screen.dart';

// The sign in component will show up if the user has clicked the sign in button from the signup screen.
// The goal of the screen is to get the user to log in with their already created email and password.
class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignInPageState();
}
enum FormType {
  login,
  register
}

class _SignInPageState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    print("test");
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      print("email: $_email");
      print("password: $_password");
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()) {
      try {
        if(_formType == FormType.login) {
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email:_email, password:_password);
        } else {
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email, password:_password);
          print(user.uid + ": $_name");
        }
      }
      catch(e) {
        print(e);
      }
    } else {

    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }
  
  @override
  Widget build(BuildContext ctx) {

    return Scaffold(
      appBar: new AppBar(
        title:new Text("Beacon")
      ),
      body:new Container(
        padding:new EdgeInsets.all(16.0),
        child:new Form(
          key:formKey,
          child:new Column(
            children: buildInput() + buildSubmitButton(ctx)
          ),
        )
      )
    );
  }

  List<Widget> buildInput() {
    if(_formType == FormType.login) {
      return[
        new TextFormField(
          decoration: new InputDecoration(labelText:"Email"),
          validator: (val) => val.isEmpty ? 'Email cannot be empty' : null,
          onSaved: (val) => _email = val,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText:"Password"),
          obscureText: true,
          validator: (val) => val.isEmpty ? 'Password cannot be empty' : null,
          onSaved: (val) => _password = val
        )
      ];
    } else {
      return[
        TextFormField(
          decoration: InputDecoration(labelText: "Name"),
          validator: (val) => val.isEmpty ? 'Name cannot be empty' : null,
          onSaved: (val) => _name = val
        ),
        TextFormField(
          decoration: InputDecoration(labelText:"Email"),
          validator: (val) => val.isEmpty ? 'Email cannot be empty' : null,
          onSaved: (val) => _email = val,
        ),
        TextFormField(
          decoration: InputDecoration(labelText:"Password"),
          obscureText: true,
          validator: (val) => val.isEmpty ? 'Password cannot be empty' : null,
          onSaved: (val) => _password = val
        )
      ];
    }
  }

  List<Widget> buildSubmitButton(BuildContext ctx) {
    if(_formType == FormType.login) {
      return[
        new RaisedButton(
          child: new Text('Sign In', style:TextStyle(fontSize: 20)),
          onPressed: () {
            validateAndSubmit();
            Navigator.push(
              ctx,
              new MaterialPageRoute(
                  builder: (ctx) => new HomeScreen()
              )
            );
          }
        ),
        new FlatButton(
          child:new Text('Create Account', style:TextStyle(fontSize:20)),
          onPressed: moveToRegister
        )
      ];
    } else {
      return[
        new RaisedButton(
          child: new Text('Register', style:TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child:new Text('Already have an account? Sign in', style:TextStyle(fontSize:20)),
          onPressed: moveToLogin
        )
      ];
    }
  }
}
