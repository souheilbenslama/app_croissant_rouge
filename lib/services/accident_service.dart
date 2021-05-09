import 'dart:convert';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:http/http.dart' as http;

const SERVER_IP = 'http://192.168.43.68:3000';

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
  static Future<bool> updateToFinished(int id) async {
    var updated = false;
    var client = http.Client();
    try {
      var res =
          await client.put('$SERVER_IP/accident/finished/' + id.toString());
      if (res.statusCode == 200) {
        updated = true;
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
      String protectionDesc,
      String hemorragieDesc,
      String respirationDesc,
      String conscienceDesc) async {
    var res = await http.post("$SERVER_IP/accident", body: {
      "id_temoin": idtemoin,
      "longitude": longitude,
      "latitude": latitude,
      "protectionDesc": protectionDesc,
      "hemorragieDesc": hemorragieDesc,
      "respirationDesc": respirationDesc,
      "conscienceDesc": conscienceDesc
    });

    return res.statusCode == 200 ? res.body : null;
  }
}
