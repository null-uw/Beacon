import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class FriendList extends StatelessWidget {
  final Map data;
  final MapController mapController;
  FriendList({this.data, this.mapController});

  @override
  Widget build(BuildContext ctx) {
    List inactive = [];
    List active = [];

    for (var user in data.values) {
      if (user.containsKey('location')) {
        active.add(user);
      } else {
        inactive.add(user);
      }
    }

    active.sort((a, b) => a['name'].compareTo(b['name']));
    inactive.sort((a, b) => a['name'].compareTo(b['name']));

    active.addAll(inactive);

    return new ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: active.length,
      itemBuilder: (context, i) {
        var user = active[i];

        return user.containsKey('location')
            ? SingleFriendRowActive(user: user, mapController: mapController)
            : SingleFriendRowInActive(user: user);
      },
    );
  }
}

class SingleFriendRowActive extends StatelessWidget {
  final Map user;
  final MapController mapController;
  SingleFriendRowActive({this.user, this.mapController});

  void moveToUser() {
    if (mapController != null &&
        user.containsKey('location') &&
        user['location'].containsKey('lat') &&
        user['location'].containsKey('lng')) {
      double lat = user['location']['lat'];
      double lng = user['location']['lng'];

      mapController.move(new LatLng(lat, lng), 13);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return new ListTile(
      leading: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(40, 40)),
        onPressed: null,
        child: Text(user['name'][0].toUpperCase(), textAlign: TextAlign.center),
        shape: new CircleBorder(),
        elevation: 0.0,
        fillColor: user['color'],
      ),
      title: Text(user['name']),
      subtitle: Text(user['email']),
      onTap: () => moveToUser(),
    );
  }
}

class SingleFriendRowInActive extends StatelessWidget {
  final Map user;
  SingleFriendRowInActive({this.user});

  @override
  Widget build(BuildContext ctx) {
    return new ListTile(
      enabled: false,
      leading: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(40, 40)),
        onPressed: null,
        child: Text(user['name'][0].toUpperCase(), textAlign: TextAlign.center),
        shape: new CircleBorder(),
        elevation: 0.0,
        fillColor: Colors.grey[600],
      ),
      title: Text(user['name']),
      subtitle: Text(user['email']),
    );
  }
}
