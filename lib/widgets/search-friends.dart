import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchFriends extends StatefulWidget {
  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  final databaseReference = FirebaseDatabase.instance.reference();
  Map result;
  bool noFound = false;

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
          noFound ? NoFoundMessage() : SizedBox.shrink(),
          result != null ? FoundResult(result: result) : SizedBox.shrink(),
        ],
      ),
    );
  }

  searchFriend(value) async {
    DataSnapshot snapshot = await databaseReference
        .child("index")
        .orderByChild('email')
        .equalTo(value)
        .once();

    if (snapshot.value != null) {
      var uid = snapshot.value.keys.first;

      setState(() {
        result = Map.from({
          "name": snapshot.value[uid]['name'],
          "email": snapshot.value[uid]['email'],
          'uid': uid
        });
        noFound = false;
      });
    } else {
      setState(() {
        noFound = true;
        result = null;
      });
    }
  }
}

class NoFoundMessage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Sorry...",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("There is no matching email.")
        ],
      ),
    );
  }
}

class FoundResult extends StatelessWidget {
  FoundResult({@required this.result});
  final Map result;

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: <Widget>[
        Text("Search Results...", style: TextStyle(fontSize: 16)),
        ListTile(
          title: Text(result['name']),
          subtitle: Text(result['email']),
          trailing: FlatButton(
            child: Text('Add Friend', style: TextStyle(color: Colors.blue)),
            onPressed: addFriend,
          ),
        )
      ],
    );
  }

  addFriend() {
    print(result['uid']);
  }
}
