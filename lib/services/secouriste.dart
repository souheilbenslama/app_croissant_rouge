import 'dart:convert';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:http/http.dart' as http;

Future<bool> updateDisponibility(String id, bool isFree) async {
  var client = http.Client();
  var updated = false;
  try {
    var response = await client.put(
      "http://localhost:3000" + "disponibility/:" + id.toString(),
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
