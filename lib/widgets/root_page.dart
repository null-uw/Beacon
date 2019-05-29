import 'package:flutter/material.dart';
import '../screens/login_signup_page.dart';
import './authentication.dart';
import '../screens/home_screen.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  //Checks if user is logged in or not for the initial state
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((uid) {
      setState(() {
        if (uid != null) {
          _userId = uid;
        }
        authStatus =
            uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  //Used as callback function. Will cause a rebuild when user signs in
  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((uid){
      setState(() {
        _userId = uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  //Used as callback function. Will cause a rebuild when user signs out.
  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  //Creates a loading screen
  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  //Determines which screen to show based off the authentication status
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      //Loading screen will show while constructor is initializing state
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      //Send to login/sign up if user is not authenticated
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      //Send to home screen if user is logged in
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomeScreen(
            auth:widget.auth,
            onSignedOut:_onSignedOut
          );
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}