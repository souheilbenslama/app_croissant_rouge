import 'dart:convert';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const SERVER_IP = 'http://192.168.1.8:3000';

//updating rescuer's disponibility (disponible-indisponible)
Future<bool> updateDisponibility(bool isFree) async {
  var client = http.Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  var jwtDecoded = jsonDecode('jwt');
  var token = jwtDecoded["token"];
  var updated = false;
  try {
    var response = await client.put(
      '$SERVER_IP/disponibility',
      headers: {'Authorization': '$token'},
      body: {isFree: isFree},
    );
    if (response.statusCode == 200) {
      updated = true;
    } else if (response.statusCode == 403) {
      //go to login screen
    }
  } catch (Exception) {
    return updated;
  }
  return updated;
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
