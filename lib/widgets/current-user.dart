import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';
import '../utilities/device-location.dart';

class CurrentUser extends StatefulWidget {
  @override
  _CurrentUserState createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  final databaseReference = FirebaseDatabase.instance.reference();
  bool isSwitched = false;

  DeviceLocation deviceLocation = DeviceLocation();
  LocationData currentLocation;

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
              children: [
                Text(
                  "First Last",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("email@email.com"),
                Text(currentLocation == null
                    ? ''
                    : "Lat:${currentLocation.latitude.toStringAsFixed(8)}, Lng:${currentLocation.longitude.toStringAsFixed(8)}")
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

  updateLocation(LocationData loc) {
    //appends the user object to current users friends object
    databaseReference
        .child("locations")
        .child("todo_current-user") // TODO: update with current user id
        .child("location")
        .set({"lat": loc.latitude, "lng": loc.longitude});
  }

  removeLocation() {
    //appends the user object to current users friends object
    databaseReference
        .child("locations")
        .child("todo_current-user") // TODO: update with current user id
        .child("location")
        .remove();
  }
}
