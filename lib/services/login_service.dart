import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:http/http.dart' as http;

// The Server to the backend
const SERVER_IP = 'http://192.168.43.68:3000';

// The service class
abstract class LoginService {
  Future<String> attemptLogIn(String username, String password);
  Future<int> attemptSignUp(String email, String password, String name,
      String cin, String phone, String address, String age, bool secouriste);
  attempttoupdate(String email, String name, String cin, String phone,
      String address, String age);
}

class LoginServiceImp extends LoginService {
// The method used to log in
  @override
  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post("$SERVER_IP/users/login",
        body: {"email": username, "password": password});
    if (res.statusCode == 200) return res.body;
    print(res.body);
    return null;
  }

  Future<String> attempttogetProfile() async {
    var jwt = await getToken();
    var jwtDecoded = jsonDecode(jwt);
    var token = jwtDecoded["token"];

    var res = await http.get(
      "$SERVER_IP/users/profile",
      headers: {
        'Authorization': '$token',
      },
    );
    if (res.statusCode == 200) return res.body;
    return null;
  }

  @override
// The method used to sign up
  Future<int> attemptSignUp(
      String email,
      String password,
      String name,
      String cin,
      String phone,
      String address,
      String age,
      bool secouriste) async {
    var res = await http.post('$SERVER_IP/users/signup', body: {
      "email": email,
      "password": password,
      "name": name,
      "cin": cin,
      "gouvernorat": address,
      "phone": phone,
      "age": age,
      "isNormalUser": (!secouriste).toString()
    });
    print(res.body);
    return res.statusCode;
  }

  attempttoupdate(String email, String name, String cin, String phone,
      String address, String age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    var jwtDecoded = jsonDecode(jwt);
    var token = jwtDecoded["token"];

    var res = await http.post('$SERVER_IP/users/update', headers: {
      'Authorization': '$token'
    }, body: {
      "email": email,
      "name": name,
      "cin": cin,
      "gouvernorat": address,
      "phone": phone,
      "age": age
    });

    if (res.statusCode == 200) {
      return res;
    }
  }
}
