import 'package:http/http.dart' as http;

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
