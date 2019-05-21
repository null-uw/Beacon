import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:my_app/utilities/secret_loader.dart';

class MapView extends StatefulWidget {
  final Map data;
  final MapController mapController;

  MapView({this.data, this.mapController});

  @override
  _MapState createState() => _MapState(this.data, this.mapController);
}

class _MapState extends State<MapView> {
  final Map data;
  MapController mapController;

  _MapState(this.data, this.mapController);

  @override
  void initState() {
    super.initState();
  }

  Marker buildFriendMarker(String name, Color color, double lat, double lng) {
    return new Marker(
      width: 40.0,
      height: 40.0,
      point: new LatLng(lat, lng),
      builder: (ctx) => new Container(
            child: new RawMaterialButton(
              constraints: BoxConstraints.tight(Size(40, 40)),
              onPressed: null,
              child: Text(name[0].toUpperCase(), textAlign: TextAlign.center),
              shape: new CircleBorder(),
              elevation: 0.0,
              fillColor: color,
            ),
          ),
    );
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

        _markers.add(buildFriendMarker(user['name'], user['color'], lat, lng));
      }
    }

    return new FutureBuilder(
        future: SecretLoader(secretPath: "mapbox_secret.json").load(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
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
                      'accessToken': snapshot.data.apiKey,
                      'id': 'mapbox.streets',
                    },
                  ),
                  new MarkerLayerOptions(
                    markers: _markers.toList(),
                  ),
                ],
              );
            }
          } else {
            return new CircularProgressIndicator();
          }
        });
  }
}
