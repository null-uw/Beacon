import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchFriends extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext ctx) {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });

    return Text("Add friend");
  }
}
