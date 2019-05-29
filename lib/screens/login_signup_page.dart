import 'package:flutter/material.dart';
import '../widgets/authentication.dart';

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();

}

enum FormMode { LOGIN, SIGNUP}

class _LoginSignUpPageState extends State<LoginSignUpPage>{
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading;
  FormMode _formMode = FormMode.LOGIN;
  
  //Checks if form has valid input
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Will validate and attempt to login or sign up user through firebase
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true; 
    });
    if(_validateAndSave()) {
      String userId = "";
      try {
        if(_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in : $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Sign up user: $userId');
        }
        //After signing in the callback function from root will cause a rebuild and open up home screen
        if(userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        String error = e.message;
        print('Error: $error');
        setState(() {
          _isLoading = false;
          _errorMessage= e.message;
        });
      }
    }
  }

  //Will either show body or loading screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Beacon"),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress()
        ],
      ),
    );
  }

  //Either shows loading screen or nothing depending on if state is still loading
  Widget _showCircularProgress() {
    if(_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(height:0.0, width: 0.0);
    }
  }

  //Creates beacon logo
  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor:Colors.transparent,
          radius:48.0,
          child:Image.asset('images/components/beacon_logo.png')
        )
      )
    );
  }

  //Creates email input that will validate and save input
  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines:1,
        keyboardType: TextInputType.emailAddress,
        autofocus:false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color:Colors.grey
          )
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  //Creates password input that will validate and save input
  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  //The main button for logging in or signing up depending on formMode
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child: _formMode == FormMode.LOGIN
              ? new Text('Login',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white))
              : new Text('Create account',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: _validateAndSubmit,
        ));
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  //Switches button usage for sign up
  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  //Switches button usage for sign in
  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  //Secondary button for moving to sign in or sign up
  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
            ? new Text('Create an account',
                style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
            : new Text('Have an account? Sign in',
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _formMode == FormMode.LOGIN
            ? _changeFormToSignUp
            : _changeFormToLogin,
      );
  }

  //Presents errors based off what comes from firebase
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child:new Text(
          _errorMessage,
          style: TextStyle(
              fontSize: 13.0,
              color: Colors.red,
              height: 1.0,
              fontWeight: FontWeight.w300),
        )
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  //Creates the main body of the login/sign up
  Widget _showBody(){
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showErrorMessage(),
            _showPrimaryButton(),
            _showSecondaryButton(),
          ],
        ),
      )
    );
  }
}