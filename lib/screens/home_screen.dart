import 'package:flutter/material.dart';

import 'friend_preferences.dart';
import '../widgets/map.dart';
import '../widgets/friend-list.dart';
import '../widgets/current-user.dart';

// The Home screen is the first screen that the user will see after logging in.
// This screen has four view components and one connector component. The
// views will take in their specified data and output a view that the user can
// interact with. These views will also initiate actions that are specified
// in a section below. There is also a connector component that shares data
// between multiple components.
class HomeScreen extends StatelessWidget {
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
                    Navigator.pushReplacementNamed(ctx, '/sign-in');
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
            Expanded(child: Map()),
            Expanded(child: FriendList()),
            CurrentUser()
          ],
        ));
  }
}
