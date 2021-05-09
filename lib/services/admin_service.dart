import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminService {
// The backend server
  static const SERVER_IP = 'http://192.168.43.68:3000';
// The method to get the list of secourists
  static Future<List<dynamic>> listSecourists() async {
    var res = await http.get("$SERVER_IP/users/list");
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

// The method to get the list of interventions
  static Future<List<dynamic>> listinterventions() async {
    var res = await http.get("$SERVER_IP/accident/inprogress");
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }
}
