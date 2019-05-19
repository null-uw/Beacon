import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatefulWidget {
  final Map data;

  MapView({this.data});

  @override
  _MapState createState() => _MapState(this.data);
}

class _MapState extends State<MapView> {
  final Map data;
  MapController mapController;
  _MapState(this.data);

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = {};

    for (var key in data.keys) {
      var user = data[key];
      if (user.containsKey('location') &&
          user['location'].containsKey('lat') &&
          user['location'].containsKey('lng')) {
        double lat = user['location']['lat'];
        double lng = user['location']['lng'];

        _markers.add(new Marker(
          width: 40.0,
          height: 40.0,
          point: new LatLng(lat, lng),
          builder: (ctx) => new Container(
                child: new RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(40, 40)),
                  onPressed: null,
                  child: Text(user['name'][0].toUpperCase(),
                      textAlign: TextAlign.center),
                  shape: new CircleBorder(),
                  elevation: 0.0,
                  fillColor: user['color'],
                ),
              ),
        ));
      }
    }

    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(47.608013, -122.335167),
        zoom: 13.0,
      ),
      mapController: mapController,
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoibWF0dGhld2tsaTk3IiwiYSI6ImNqMzE5M254MjAwMHYzMm1ydG43MnV6cm8ifQ.lMMwzXJokvtW4hispPYEIg',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: _markers.toList(),
        ),
      ],
    );
  }
}
