import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SERVER_IP = 'http://192.168.1.118:3000';

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
  print("A");
  // Test if location services are enabled.
  _serviceEnabled = await location.serviceEnabled();
  _permissionGranted = await location.hasPermission();
  print("AB");
  print(_serviceEnabled);

  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
    print("B");
  }
  print("BA");
  print(_permissionGranted);
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    print("D");
  }

  if (_permissionGranted == PermissionStatus.granted) {
    print("eee");
    var onValue = await location.getLocation();

    print(onValue.latitude.toString() + "," + onValue.longitude.toString());
    currentLocation = onValue;
    print("C");
    return currentLocation;
  } else {
    print("E");
    return currentLocation;
  }
  print("F");
}

//updating rescuer's disponibility (disponible-indisponible)
updateDisponibility(bool isFree) async {
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

Future<String> changeUserActivation(String userId, bool activation) async {
  var jwt = await getToken();
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];
  print("hello");
  print(userId);
  print(activation);
  var res = await http.put("$SERVER_IP/users/activationUser", headers: {
    'Authorization': '$token',
  }, body: {
    "id": userId,
    "activated": activation.toString()
  });
  print("okok");
  print(res.body);
  if (res.statusCode == 200) return res.body;
  return null;
}

Future<String> changeUsertype(String userId, bool admin) async {
  var jwt = await getToken();
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];
  print("hello");
  print(userId);
  print(admin);
  var res = await http.put("$SERVER_IP/users/adminuser", headers: {
    'Authorization': '$token',
  }, body: {
    "id": userId,
    "admin": admin.toString()
  });
  print("okok");
  print(res.body);
  if (res.statusCode == 200) return res.body;
  return null;
}
