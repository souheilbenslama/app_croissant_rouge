import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class UserService {
// The Server to the backend
  static const SERVER_IP = 'http://192.168.1.118:3000';
// The method to register the user
  static Future<String> attemptLogInUser(String userId) async {
    var res = await http
        .post("$SERVER_IP/users/normalUser", body: {"userid": userId});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  static Future<String> attemptgetUser(String userId) async {
    var res = await http.post("$SERVER_IP/users/anonyme", body: {"id": userId});
    if (res.statusCode == 200) return res.body;
    return null;
  }

// To get Device Details
  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    deviceName = build.model;
    deviceVersion = build.version.toString();
    identifier = build.androidId; //UUID for Android
//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

  Future<bool> updateUserSocketId(String socketId, String userDeviceId) async {
    var client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    var jwtDecoded = jsonDecode(jwt);
    var token = jwtDecoded["token"];
    var updated = false;
    try {
      print(token);
      var response = await client.put(
        '$SERVER_IP/users/socket',
        headers: {'Authorization': '$token'},
        body: {"socketId": socketId, "deviceId": userDeviceId},
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

  static Future<String> attemptRateApp(String userId, int value) async {
    var res = await http.post("$SERVER_IP/users/Rate",
        body: {"id": userId, "value": value.toString()});
    if (res.statusCode == 200) {
      print(res.body);
      return res.body;
    }

    return null;
  }
}
