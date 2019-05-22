import 'package:flutter/material.dart';

// ReceivedRequest is a widget that renders a ListView of all received request within a Request widget
class RecievedRequests extends StatelessWidget {
  //Dummy Data
  final List data;
  RecievedRequests({this.data});

  @override
  Widget build(BuildContext ctx) {
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
              child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: this.data.length,
                itemBuilder: (context, i) {
                  var request = this.data[i];
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
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(request.getName(),
                        style: new TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    new Text(request.getEmail())
                  ],
                ),
              )),
              new Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        print("Accepted Request!");
                      }),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        print("Denied Request!");
                      })
                ],
              )
            ],
          ),
          new Divider()
        ],
      ),
    );
  }
}

// Temporary Request Object that contains a users name & email
class Request {
  String name;
  String email;

// Request Constructor
  Request(String name, String email) {
    this.name = name;
    this.email = email;
  }

// Returns users name
  String getName() {
    return this.name;
  }

// Returns users email
  String getEmail() {
    return this.email;
  }
}
