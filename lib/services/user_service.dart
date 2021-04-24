import 'package:http/http.dart' as http;

class UserService {
// The Server to the backend
  static final SERVER_IP = 'http://192.168.1.7:3000';
// The method to register the user
  static Future<String> attemptLogInUser(String userId) async {
    var res = await http
        .post("$SERVER_IP/users/normalUser", body: {"userid": userId});
    if (res.statusCode == 200) return res.body;
    return null;
  }
}
