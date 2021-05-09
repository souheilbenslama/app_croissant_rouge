import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SERVER_IP = 'http://192.168.43.68:3000';

/// this function  Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

Future<LocationData> getPosition() async {
  Location location;
  location = new Location();
  LocationData currentLocation;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  // Test if location services are enabled.
  _serviceEnabled = await location.serviceEnabled();

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
  }

  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  if (_permissionGranted != PermissionStatus.granted) {
    currentLocation = await location.getLocation();

    return currentLocation;
  }
  return null;
}

//updating rescuer's disponibility (disponible-indisponible)
updateDisponibility(bool isFree) async {
  print("#################################################");

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var jwt = prefs.getString("jwt");
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];

  var res = await http.put("$SERVER_IP/secouriste/disponibility",
      //headers: {HttpHeaders.authorizationHeader: token},
      headers: {
        'Authorization': '$token',
      }, body: {
    "isFree": isFree.toString()
  });

  print(res.body);
  //print(res.statusCode);
  // print(res);
  //print("token = " + token);

  if (res.statusCode == 200) return res.body;
  return null;
}

// The function to get the token from shared preferences
Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

// The function to update the lcation
// The Server to the backend

Future<String> updateLocation(double longitude, double latitude) async {
  var jwt = await getToken();
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];
  var res = await http.put("$SERVER_IP/secouriste/location",
      //headers: {HttpHeaders.authorizationHeader: token},
      headers: {
        'Authorization': '$token',
      }, body: {
    "longitude": longitude.toString(),
    "latitude": latitude.toString()
  });
  //print(res.statusCode);
  // print(res);
  //print("token = " + token);
  if (res.statusCode == 200) return res.body;
  return null;
}
