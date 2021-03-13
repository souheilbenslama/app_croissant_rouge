import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;

// The Server to the backend
const SERVER_IP = 'http://192.168.1.8:3000';
// The method to register the user
Future<String> attemptLogInUser(String userId) async {
  var res =
      await http.post("$SERVER_IP/users/normalUser", body: {"phone": userId});
  if (res.statusCode == 200) return res.body;
  return null;
}

class PageAlerte extends StatelessWidget {
// To get Device Details
  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build = await deviceInfoPlugin.androidInfo;
    deviceName = build.model;
    deviceVersion = build.version.toString();
    identifier = build.androidId; //UUID for Android
//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        actions: [
          // Used the actions to have the icons of the "App Bar" aligned in the same line
          IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          Container(
            // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
            width: 360,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // space between to keep a certain space between the children of the Column
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Image.asset(
              'assets/logo.jpg',
              width: 150,
              height: 150,
            ),
          ),
          RaisedButton(
            color: Colors.redAccent[700],
            onPressed: () async {
              var details = await getDeviceDetails();
              var userId = details[2];
              var res = await attemptLogInUser(userId);
              print(res);
            },
            child: Text(
              'Alerter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 80,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.black),
            ),
          ),
          Container(
            width: 410,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Contacter-nous',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Documentation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
