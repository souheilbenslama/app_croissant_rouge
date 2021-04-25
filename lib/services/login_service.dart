import 'package:http/http.dart' as http;

// The Server to the backend
const SERVER_IP = 'http://192.168.56.17:3000';

// The service class
abstract class LoginService {
  Future<String> attemptLogIn(String username, String password);
  Future<int> attemptSignUp(String email, String password, String name,
      String cin, String phone, String address);
}

class LoginServiceImp extends LoginService {
// The method used to log in
  @override
  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post("$SERVER_IP/users/login",
        body: {"email": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  @override
// The method used to sign up
  Future<int> attemptSignUp(String email, String password, String name,
      String cin, String phone, String address) async {
    var res = await http.post('$SERVER_IP/users/signup', body: {
      "email": email,
      "password": password,
      "name": name,
      "cin": cin,
      "address": address,
      "phone": phone
    });
    print(res.body);
    return res.statusCode;
  }
}
