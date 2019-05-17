import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final Map data;

  MapView({this.data});

  @override
  _MapState createState() => _MapState(this.data);
}

class _MapState extends State<MapView> {
  final Map data;

  _MapState(this.data);

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  BitmapDescriptor _markerIcon;
  static const LatLng _center = const LatLng(47.6062, -122.3321);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });

    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    final Set<Marker> _markers = {};

    for (var key in data.keys) {
      var user = data[key];
      if (user.containsKey('location') &&
          user['location'].containsKey('lat') &&
          user['location'].containsKey('lng')) {
        double lat = user['location']['lat'];
        double lng = user['location']['lng'];

        _markers.add(Marker(
            markerId: MarkerId(key),
            position: new LatLng(lat, lng),
            infoWindow: InfoWindow(title: user['name'], snippet: user['email']),
            icon: _markerIcon));
      }
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      myLocationEnabled: true,
    );
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/blob_1.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }
}
