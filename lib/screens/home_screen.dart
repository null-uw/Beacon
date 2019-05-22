import 'package:flutter/material.dart';
import 'dart:async';
import './../utilities/firebase-connector.dart';
import 'friend_preferences.dart';
import '../widgets/map-view.dart';
import '../widgets/friend-list.dart';
import '../widgets/current-user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The Home screen is the first screen that the user will see after logging in.
// This screen has four view components and one connector component. The
// views will take in their specified data and output a view that the user can
// interact with. These views will also initiate actions that are specified
// in a section below. There is also a connector component that shares data
// between multiple components.
class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionFriends;
  Map<String, StreamSubscription> _locationSubscriptions;
  Map<String, dynamic> _userLocations;

  @override
  void initState() {
    _locationSubscriptions = new Map();
    _userLocations = new Map();

    FirebaseConnector.getUserFriendStream(_onChange)
        .then((StreamSubscription s) => _subscriptionFriends = s);

    super.initState();
  }

  // Handles changes to the user's friend node in Firebase Database.
  // Inner method 'iterateMapEntry' loops through returned snapshot,
  // instantiating new StreamSubscriptions if not found in state map.
  _onChange(Map value) {
    void iterateMapEntry(key, value) {
      if (!_locationSubscriptions.containsKey(key)) {
        FirebaseConnector.getUserLocationStream(key, _onLocationChange)
            .then((StreamSubscription s) => _locationSubscriptions[key] = s);
      }
    }

    value.forEach(iterateMapEntry);
  }

  // Handles changes to a user's location node in Firebase Database.
  // Updates state variable _userLocations with new value returned from Stream.
  _onLocationChange(String key, Map value) {
    _userLocations[key] = value;
    print(_userLocations);
  }

  // Destroys all streams when Widget is unmounted.
  @override
  void dispose() {
    if (_subscriptionFriends != null) {
      _subscriptionFriends.cancel();
    }

    for (StreamSubscription value in _locationSubscriptions.values) {
      if (value != null) {
        value.cancel();
      }
    }

    super.dispose();
  }

  void signOut(BuildContext ctx) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(ctx, '/sign-in');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user);
    print("Signed out!");
  }

  @override
  Widget build(BuildContext ctx) {
    _showLogout() {
      showDialog(
          context: ctx,
          builder: (BuildContext dialogCtx) {
            return AlertDialog(
              title: new Text("Are you sure you want to sign out?"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Sign Out"),
                  onPressed: () {
                    signOut(ctx);
                  },
                )
              ],
            );
          });
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Beacon"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
                Navigator.push(
                  ctx,
                  new MaterialPageRoute(
                      builder: (ctx) => new FriendPreferences()),
                );
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _showLogout(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: MapView()),
            Expanded(child: FriendList()),
            CurrentUser()
          ],
        ));
  }
}


