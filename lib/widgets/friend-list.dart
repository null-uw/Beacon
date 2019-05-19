import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  final Map data;
  FriendList({this.data});

  @override
  Widget build(BuildContext ctx) {
    return new Expanded(
        child: new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, i) {
        String key = data.keys.elementAt(i);
        return new SingleFriendRow(user: data[key]);
      },
    ));
  }
}

class SingleFriendRow extends StatelessWidget {
  final Map user;
  SingleFriendRow({this.user});

  @override
  Widget build(BuildContext ctx) {
    return new Container(
        padding: new EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          new Row(children: <Widget>[
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(40, 40)),
              onPressed: null,
              child: Text(user['name'][0].toUpperCase(), textAlign: TextAlign.center),
              shape: new CircleBorder(),
              elevation: 0.0,
              fillColor: user['color'],
            ),
            new Expanded(
              child: new Container( 
                margin: const EdgeInsets.only(left: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(user['name'],
                        style: new TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    new Text(user['email'])
                  ],
                ),
              ),
            ),
          ])
        ]));
  }
}
