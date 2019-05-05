import 'package:flutter/material.dart';

import 'friend_preferences.dart';
import '../widgets/map.dart';
import '../widgets/friend-list.dart';
import '../widgets/current-user.dart';

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
