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
            onPressed: () {
              print(request);
            }),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () => {denyRequest(request["id"])})
      ],
    ));
  }
}

denyRequest(userID) {
  FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(
          "uid") // hardcoded to grab uid in FB. Will be changed to currenUser.uid once auth is established
      .child("requests")
      .child(userID)
      .remove();
}

acceptRequest(userID) {
  FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(
          "uid") // hardcoded to grab uid in FB. Will be changed to currenUser.uid once auth is established
      .child("requests")
      .child(userID)
      .remove();
}

// https://stackoverflow.com/questions/46856559/flutter-listview-with-map-instead-of-list
