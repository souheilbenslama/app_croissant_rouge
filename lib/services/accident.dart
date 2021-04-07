import 'dart:convert';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:http/http.dart' as http;

//get the list of interventions in progress
Future<List<Accident>> getInProgressInterventions() async {
  var Client = http.Client();
  var res = await Client.get('http://localhost:3000/inprogress');
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
Future<bool> updateToFinished(int id) async {
  var updated = false;
  var Client = http.Client();
  try {
    var res =
        await Client.put('http://localhost:3000/finished/' + id.toString());
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
