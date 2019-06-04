import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ReceivedRequest is a widget that renders a ListView of all received request within a Request widget
class RecievedRequests extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  RecievedRequests({this.data});

  @override
  Widget build(BuildContext ctx) {
    List requestListValues = [];
    List requestListkeys = [];

    if (data != null) {
      requestListkeys = data.keys.toList();
      requestListValues = data.values.toList();
    }
    return new Expanded(
      child: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Requests",
                style:
                    new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            new Expanded(
              child: new ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: requestListValues.length,
                itemBuilder: (context, i) {
                  var request = requestListValues[i];
                  request["id"] = requestListkeys[i];
                  return new SingleRequest(request);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//SinlgeRequest is a widget that renders a single request, it displays the users name and email. It also renders 2 buttons to allow the user to either deny or accept the request
class SingleRequest extends StatelessWidget {
  final request;
  SingleRequest(this.request);

  @override
  Widget build(BuildContext ctx) {
    return new ListTile(
      title: Text(request['name']),
      subtitle: Text(request['email']),
      trailing: IconRow(request),
    );
  }
}

//IconRow is a widget that renders the accept button and deny button for each request widget.
class IconRow extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final request;
  IconRow(this.request);

  @override
  Widget build(BuildContext ctx) {
    return new Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.check), onPressed: () => {acceptRequest(request)}),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {removeRequest(request["id"])})
      ],
    ));
  }

  //takes in a userID and removes the speceific request from the current users request object
  removeRequest(otherUserID) async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();

    databaseReference
        .child("users")
        .child(currentUser.uid)
        .child("requests")
        .child(otherUserID)
        .remove();
  }

  //Takes in a request object, establishes a friendship between both users and removes the request from the request list.
  acceptRequest(request) async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();
    final otherUserID = request["id"];

    //add current user object to other users friend object
    await databaseReference
        .child("users")
        .child(otherUserID)
        .child("friends")
        .child(currentUser.uid)
        .set({"name": currentUser.displayName, "email": currentUser.email});

    //appends the user object to current users friends object
    await databaseReference
        .child("users")
        .child(currentUser.uid)
        .child("friends")
        .child(otherUserID)
        .set({"name": request["name"], "email": request["email"]});

    //removes the request from the firebase db
    await removeRequest(otherUserID);
  }
}
