import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/models/accident.dart';

class AdminService {
// The backend server
  static const SERVER_IP = 'http://192.168.1.118:3000';
// The method to get the list of secourists
  static Future<List<dynamic>> listSecourists() async {
    var res = await http.get("$SERVER_IP/users/list");

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      List<dynamic> result =
          body.map((item) => Secouriste.fromJson(item)).toList();
      return result;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> secouristelistInter(id) async {
    print("okok");
    var res = await http
        .post("$SERVER_IP/accident/Secouristeinter/", body: {'id': id});
    final body = jsonDecode(res.body);
    print(body);
    if (res.statusCode == 200) {
      //print();

      var result = body.map((element) => Accident.fromJson(body[0])).toList();
      print('oazeazeo');
      print(result);
      return result;
    } else {
      return null;
    }
  }

// The method to get the list of interventions
  static Future<List<dynamic>> listinterventions() async {
    var res = await http.get("$SERVER_IP/accident/all");
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      print(body);
      var liste = body.map((element) => Accident.fromJson(element)).toList();
      return liste;
    } else {
      return null;
    }
  }
}
