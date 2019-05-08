import 'package:flutter/material.dart';

import '../widgets/received-requests.dart';
import '../widgets/search-friends.dart';

class FriendPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friend Preferences"),
        ),
        body: new Container(
          child: Column(
            children: <Widget>[SearchFriends(), RecievedRequests()],
          ),
        ));
  }
}
