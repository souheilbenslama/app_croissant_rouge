import 'dart:convert';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../accidentProvider.dart';

const SERVER_IP = 'http://192.168.1.118:3000';

class AccidentService {
//get the list of interventions in progress
  static Future<List<Accident>> getInProgressInterventions() async {
    var client = http.Client();
    var res = await client.get('$SERVER_IP/accident/inprogress');

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Accident> interventionsInProgress =
          body.map((dynamic item) => Accident.fromJson(item)).toList();
      return interventionsInProgress;
    } else {
      print("Request Failed");
      return [];
    }
  }

//update the intervention's status to finished
  static Future<bool> updateToFinished(String id) async {
    print("here i am");
    var updated = false;
    var client = http.Client();
    try {
      var res =
          await client.put('$SERVER_IP/accident/finished/', body: {"id": id});
      if (res.statusCode == 200) {
        updated = true;
        print(res.body);
      } else if (res.statusCode == 403) {
        //go to login screen
      }
    } catch (Exception) {
      return updated;
    }
    return updated;
  }

// The method to create the accident
  static Future<String> createAccident(
      String idtemoin,
      String longitude,
      String latitude,
      String cas,
      String description,
      bool needSecouriste,
      String address,
      String localite) async {
    var res = await http.post("$SERVER_IP/accident", body: {
      "id_temoin": idtemoin,
      "longitude": longitude.toString(),
      "latitude": latitude.toString(),
      "cas": cas,
      "description": description,
      "needSecouriste": needSecouriste.toString(),
      "localite": localite,
      "address": address
    });

    return res.statusCode == 200 ? res.body : null;
  }
}

Future<List<String>> getDeviceDetails() async {
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
