import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../utilities/device-location.dart';

class CurrentUser extends StatefulWidget {
  @override
  _CurrentUserState createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
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
                    deviceLocation
                        .startLocationSubscription((LocationData location) {
                      setState(() {
                        currentLocation = location;
                      });
                    });
                  } else {
                    setState(() {
                      deviceLocation.cancelLocationSubscription();
                      currentLocation = null;
                    });
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
}
