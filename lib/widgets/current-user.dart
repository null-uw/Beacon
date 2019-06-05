import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utilities/device-location.dart';

class CurrentUser extends StatefulWidget {
  @override
  _CurrentUserState createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map currentUser;
  bool isSwitched = false;

  DeviceLocation deviceLocation = DeviceLocation();
  LocationData currentLocation;

  @override
  initState() {
    super.initState();

    firebaseAuth.currentUser().then((user) {
      databaseReference.child("index").child(user.uid).once().then((snapshot) {
        setState(() {
          currentUser = snapshot.value;
        });
      });
    });
  }

  // Destroys stream when Widget is unmounted.
  @override
  void dispose() {
    deviceLocation.cancelLocationSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
        decoration: BoxDecoration(color: const Color(0xFFFFFFFF), boxShadow: [
          BoxShadow(
            color: Color(0xFFCCCCCC),
            blurRadius: 10.0,
          ),
        ]),
        padding: new EdgeInsets.all(24),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: currentUser == null
                  ? [Text("Loading...")]
                  : [
                      Text(
                        currentUser['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(currentUser['email'])
                    ],
            ),
            Container(
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  if (value) {
                    // if toggled on
                    deviceLocation.startLocationSubscription(
                        (LocationData location) {
                      setState(() {
                        currentLocation = location;
                      });
                      updateLocation(location);
                    }, 100);
                  } else {
                    // when toggled off
                    deviceLocation.cancelLocationSubscription();
                    setState(() {
                      currentLocation = null;
                    });
                    removeLocation();
                  }

                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }

  updateLocation(LocationData loc) async {
    FirebaseUser user = await firebaseAuth.currentUser();

    //appends the user object to current users friends object
    databaseReference
        .child("locations")
        .child(user.uid)
        .child("location")
        .set({"lat": loc.latitude, "lng": loc.longitude});
  }

  removeLocation() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    //appends the user object to current users friends object
    databaseReference
        .child("locations")
        .child(user.uid)
        .child("location")
        .remove();
  }
}
