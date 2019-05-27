import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// ReceivedRequest is a widget that renders a ListView of all received request within a Request widget
class RecievedRequests extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  List requestListkeys = [];
  List requestListValues = [];
  RecievedRequests({this.data});

  @override
  Widget build(BuildContext ctx) {
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
                  print("Individual");
                  print(request);
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
  final request;
  IconRow(this.request);

  @override
  Widget build(BuildContext ctx) {
    return new Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.check),
            onPressed: () => {acceptRequest(request)}),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {removeRequest(request["id"])})
      ],
    ));
  }
}

final databaseReference = FirebaseDatabase.instance.reference();

//takes in a userID and removes the speceific request from the current users request object
removeRequest(userID) {
  databaseReference
      .child("users")
      .child(
          "uid") // hardcoded to grab uid in FB. Will be changed to currenUser.uid once auth is established
      .child("requests")
      .child(userID)
      .remove();
}

//Takes in a request object, establishes a friendship between both users and removes the request from the request list.
acceptRequest(request) {

  //appends the user object to current users friends object
  databaseReference
      .child("users")
      .child(
          "uid") // hardcoded to grab uid in FB. Will be changed to currenUser.uid once auth is established
      .child("friends")
      .child(request["id"])
      .set({
        "name" : request["name"],
        "email" : request["email"]
      });
  

  //add current user object to other users friend object
    //{
    // databaseReference
    //   .child("users")
    //   .child(
    //       request["id"]) // hardcoded to grab uid in FB. Will be changed to currenUser.uid once auth is established
    //   .child("friends")
    //   .set({
    //   request["id"]: {
    //     "name" : request["name"],
    //     "email" : request["email"]
    //   }});
    //}

  //removes the request from the firebase db
      removeRequest(request["id"]);
}