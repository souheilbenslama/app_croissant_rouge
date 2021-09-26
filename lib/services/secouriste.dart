import 'dart:convert';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_croissant_rouge/globals.dart' as globals;

//updating rescuer's disponibility (disponible-indisponible)
//
Future<bool> updateDisponibility(bool isFree) async {
  var client = http.Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString("jwt");
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];
  var updated = false;
  try {
    var response = await client.put(
      Uri.parse('http://${globals.Server}/secouriste/disponibility'),
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
  var updated = false;
  if (jwt != null) {
    var jwtDecoded = jsonDecode(jwt);
    print(jwtDecoded);
    var token = jwtDecoded["token"];

    try {
      print(token);
      var response = await client.put(
        Uri.parse('http://${globals.Server}/secouriste/socket'),
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
  } else {
    var details = await UserService.getDeviceDetails();
    var userId = details[2];
    try {
      var response = await client.put(
        Uri.parse('http://${globals.Server}/users/socket'),
        body: {"socketId": socketId, "deviceId": userId},
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
}
