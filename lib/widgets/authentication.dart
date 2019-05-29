import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Signs in the user and returns the uid
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  //Signs up the user and returns uid
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  //Gets curren user's uid; if user is not authenticated, then it will return null
  Future<String> getCurrentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.uid;
    } catch(e) {
      return null;
    }
    
  }

  //Signs user out and returns uid
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}