import 'dart:async';
import 'package:location/location.dart';

class DeviceLocation {
  Location location = Location();
  StreamSubscription<LocationData> locationSubscription;

  startLocationSubscription(Function onLocation, [double distanceFilter = 0]) {
    location.changeSettings(distanceFilter: distanceFilter);
    location.getLocation();

    locationSubscription = location.onLocationChanged().listen(onLocation);
  }

  cancelLocationSubscription() {
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
  }
}
