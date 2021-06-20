import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:app_croissant_rouge/globals.dart' as globals;

// The Server to the backend

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
    var res = await http.post("http://${globals.Server}/users/login",
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
      "http://${globals.Server}/users/profile",
      headers: {
        'Authorization': '$token',
      },
    );
    if (res.statusCode == 200) print(res.body);
    return res.body;
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
    var res = await http.post('http://${globals.Server}/users/signup', body: {
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

  @override
// The method used when password is forget
  forget(
    String email,
  ) async {
    var res = await http
        .post('http://${globals.Server}/users/forget', body: {"email": email});

    return res;
  }

  verifycode(
    String code,
  ) async {
    var res = await http.post('http://${globals.Server}/users/verification',
        body: {"code": code});
    print(res.body);
    return res;
  }

  resetPassword(String password, String confirmPassword, String token) async {
    var res = await http.post('http://${globals.Server}/users/reset', headers: {
      'Authorization': '$token',
    }, body: {
      "password": password,
      "confirmPassword": confirmPassword
    });

    return res;
  }

  attempttoupdate(String email, String name, String cin, String phone,
      String address, String age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    var jwtDecoded = jsonDecode(jwt);
    var token = jwtDecoded["token"];

    var res =
        await http.post('http://${globals.Server}/users/update', headers: {
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

  attemptToUpdate(String email, String name, String cin, String phone,
      String address, String age, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    var jwtDecoded = jsonDecode(jwt);
    var token = jwtDecoded["token"];

    var stream;
    var length;
    var image2;
    if (image != null) {
      image2 = File(image.path);
      stream = new http.ByteStream(DelegatingStream.typed(image2.openRead()));
      length = await image2.length();
    }
    var uri = Uri.parse("http://${globals.Server}/users/update");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile;

    if (image != null) {
      multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(image2.path));
    }

    //contentType: new MediaType('image', 'png'));
    request.headers['Authorization'] = token;
    if (image != null) {
      request.files.add(multipartFile);
    }
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["cin"] = cin;
    request.fields["gouvernorat"] = address;
    request.fields["phone"] = phone;
    request.fields["age"] = age;
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return response;
    }
  }
}
