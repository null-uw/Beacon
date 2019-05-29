import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchFriends extends StatefulWidget {
  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  Map result;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext ctx) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Add friend",
              style:
                  new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: new TextField(
                onSubmitted: searchFriend,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Search by email")),
          ),
          result != null ? Text(result['name']) : Text('')
        ],
      ),
    );
  }

  searchFriend(value) async {
    print(value);

    DataSnapshot snapshot = await databaseReference
        .child("index")
        .orderByChild('email')
        .equalTo(value)
        .once();

    var uid = snapshot.value.keys.first;

    setState(() {
      result = Map.from({
        "name": snapshot.value[uid]['name'],
        "email": snapshot.value[uid]['email']
      });
    });
  }
}
