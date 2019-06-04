import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchFriends extends StatefulWidget {
  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  TextEditingController textFieldController = TextEditingController();
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
              style: new TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: new TextField(
              controller: textFieldController,
              onChanged: clearResult,
              onSubmitted: searchFriend,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search by email",
                suffixIcon: textFieldController.text != ""
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: clearTextBox,
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ),
          noFound ? NoFoundMessage() : SizedBox.shrink(),
          result != null ? FoundResult(result: result) : SizedBox.shrink(),
        ],
      ),
    );
  }

  clearTextBox() {
    setState(() {
      textFieldController.text = "";
    });
  }

  clearResult(String _) {
    setState(() {
      result = null;
      noFound = false;
    });
  }

  searchFriend(value) async {
    DataSnapshot snapshot = await databaseReference
        .child("index")
        .orderByChild('email')
        .equalTo(value.toString().trim())
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

class FoundResult extends StatefulWidget {
  FoundResult({@required this.result});

  final Map result;

  @override
  _FoundResultState createState() => _FoundResultState();
}

class _FoundResultState extends State<FoundResult> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool confirmation = false;

  @override
  Widget build(BuildContext ctx) {
    return confirmation
        ? Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, size: 24),
                Text('Request Sent!')
              ],
            ))
        : Column(
            children: <Widget>[
              Text("Search Results...", style: TextStyle(fontSize: 16)),
              ListTile(
                title: Text(widget.result['name']),
                subtitle: Text(widget.result['email']),
                trailing: FlatButton(
                  child:
                      Text('Add Friend', style: TextStyle(color: Colors.blue)),
                  onPressed: addFriend,
                ),
              )
            ],
          );
  }

  addFriend() async {
    FirebaseUser currentUser = await firebaseAuth.currentUser();

    DataSnapshot currentNameSnapshot = await databaseReference
        .child("index")
        .child(currentUser.uid)
        .child('name')
        .once();

    String curEmail = currentUser.email;
    String curName = currentNameSnapshot.value;

    await databaseReference
        .child("users")
        .child(widget.result['uid'])
        .child("requests")
        .child(currentUser.uid)
        .set({"name": curName, "email": curEmail});

    setState(() {
      confirmation = true;
    });
  }
}
