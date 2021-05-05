import 'dart:convert';

import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const SERVER_IP = 'http://192.168.43.68:3000';

//updating rescuer's disponibility (disponible-indisponible)
//
Future<bool> updateDisponibility(bool isFree) async {
  var client = http.Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  var jwtDecoded = jsonDecode('jwt');
  var token = jwtDecoded["token"];
  var updated = false;
  try {
    var response = await client.put(
      '$SERVER_IP/secouriste/disponibility',
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

Future<bool> updateRescuerSocketId(String socketId) async {
  var client = http.Client();
  print("/////////////////////////::");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  var jwtDecoded = jsonDecode(jwt);
  print(jwtDecoded);
  var token = jwtDecoded["token"];
  var updated = false;
  try {
    print(token);
    var response = await client.put(
      '$SERVER_IP/secouriste/socket',
      headers: {'Authorization': '$token'},
      body: {"socketId": socketId},
    );

    print(response.body);

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
