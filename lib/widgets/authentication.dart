import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password, String name);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  //Signs in the user and returns the uid
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  //Signs up the user and returns uid
  Future<String> signUp(String email, String password, String name) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // update the user's display name
    final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await user.updateProfile(userUpdateInfo);

    // create db entries
    await _databaseReference
        .child("locations")
        .child(user.uid)
        .update({"name": name, "email": email});
    await _databaseReference
        .child("index")
        .child(user.uid)
        .update({"name": name, "email": email});

    return user.uid;
  }

  //Gets curren user's uid; if user is not authenticated, then it will return null
  Future<String> getCurrentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.uid;
    } catch (e) {
      return null;
    }
  }

  //Signs user out and returns uid
  Future<void> signOut() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    //appends the user object to current users friends object
    _databaseReference
        .child("locations")
        .child(user.uid)
        .child("location")
        .remove();

    // sign out
    return _firebaseAuth.signOut();
  }
}
