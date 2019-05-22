import 'dart:async';

import 'package:flutter/material.dart';
import './../utilities/firebase-connector.dart';

import '../widgets/received-requests.dart';
import '../widgets/search-friends.dart';

// The user accesses the Friend Preference screen when they press on the friend's Icon in the Home Screen.
// This screen has 2 major components, searchFriends and receivedRequests. These components will work
// together to enable the user to send requests to other users and respond to them.
// The user can return back to the home screen by pressing on the backButton component.

class FriendPreferences extends StatefulWidget {
  @override
  FriendPreferenceState createState() => new FriendPreferenceState();
}

class FriendPreferenceState extends State<FriendPreferences> {
  StreamSubscription requestSubscription;
  Map<dynamic, dynamic> requestList;
    var dummyData = [
    Request("Charlye", "charlye@gmail.com"),
    Request("Ben", "Ben@gmail.com"),
    Request("Joe", "Joe@gmail.com"),
    Request("Mat", "Mat@gmail.com"),
  ];

    @override
  void initState() {

    FirebaseConnector.getUserFriendStream( _onChange)
        .then((StreamSubscription s) => requestSubscription = s);

    super.initState();
  }

  _onChange(Map value) {
    setState(() {
      requestList = value;
      print(requestList);
    });
  }


  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friend Preferences"),
        ),
        body: new Container(
          child: Column(
            children: <Widget>[SearchFriends(), RecievedRequests(data: dummyData)]
          ),
        ));
  }
}
