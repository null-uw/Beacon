import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Example implementation: https://gist.github.com/branflake2267/ea80ce71179c41fdd8bbdb796ca889f4
class FirebaseConnector {
  static Future<StreamSubscription<Event>> getUserFriendStream(
      void onData(Map value)) async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    // Creates a StreamSubscription to the current user's friend node in FB database.
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(currentUser.uid)
        .child("friends")
        .onValue
        .listen((Event event) {
      onData(event.snapshot.value);
    });

    return subscription;
  }

  // Creates a StreamSubscription to a location node in FB database.
  static Future<StreamSubscription<Event>> getUserLocationStream(
      String userKey, void onData(String key, Map value)) async {
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("locations")
        .child(userKey)
        .onValue
        .listen((Event event) {
      onData(userKey, event.snapshot.value);
    });
    return subscription;
  }

  // Creates a StreamSubscription to the current users request node in FB database
  static Future<StreamSubscription<Event>> getUserRequestStream(
      void onData(Map value)) async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    // Creates a StreamSubscription to the current user's friend node in FB database.
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(currentUser.uid)
        .child("requests")
        .onValue
        .listen((Event event) {
      onData(event.snapshot.value);
    });

    return subscription;
  }
}
