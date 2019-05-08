import 'package:flutter/material.dart';

class RecievedRequests extends StatelessWidget {
  final requestList = [
    Request("Charlye", "charlye@gmail.com"),
    Request("Ben", "Ben@gmail.com"),
    Request("Joe", "Joe@gmail.com"),
    Request("Mat", "Mat@gmail.com"),
  ];

  @override
  Widget build(BuildContext ctx) {
    return
     new Container(
        padding: new EdgeInsets.all(16.0),
        child: 
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Requests",
                style:
                    new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
    // new Expanded(
    //child: 
      new ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                itemCount: this.requestList.length,
                itemBuilder: (context, i) {
                  var request = this.requestList[i];
                  return new EachRequest(request);
                },
              ),
    
               
          ],
        ),
     );
  }
}

class EachRequest extends StatelessWidget {
  final request;
  EachRequest(this.request);

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

class Request {
  String name;
  String email;

  Request(String name, String email) {
    this.name = name;
    this.email = email;
  }

  String getName() {
    return this.name;
  }

  String getEmail() {
    return this.email;
  }
}
