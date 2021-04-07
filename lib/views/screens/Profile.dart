import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// The package used to get the location
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// this function  Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// The function to update the lcation
// The Server to the backend
const SERVER_IP = 'http://192.168.1.8:3000';
// The function to get the token from shared preferences
Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

// The method that will try to attempt to login
Future<String> location(double longitude, double latitude) async {
  var jwt = await getToken();
  var jwtDecoded = jsonDecode(jwt);
  var token = jwtDecoded["token"];
  var res = await http.put("$SERVER_IP/secouriste/location",
      //headers: {HttpHeaders.authorizationHeader: token},
      headers: {
        'Authorization': '$token',
      }, body: {
    "longitude": longitude.toString(),
    "latitude": latitude.toString()
  });
  print(res.statusCode);
  print(res);
  print("token = " + token);
  if (res.statusCode == 200) return res.body;
  return null;
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Profil"),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image(
                  image: AssetImage(
                    "assets/profil.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 95),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Nom et prénom",
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(10),
                                      title: LiteRollingSwitch(
                                        value: true,
                                        textOn: 'disponible',
                                        textOff: 'indisponible',
                                        colorOn: Colors.green[700],
                                        colorOff: Colors.red[700],
                                        iconOn: Icons.notifications_active,
                                        iconOff: Icons.notifications_off,
                                        textSize: 18.0,
                                        onChanged: (bool position) async {
                                          if (position == true) {
                                            Position pos =
                                                await _determinePosition();
                                            var res = await location(
                                                pos.longitude, pos.latitude);
                                            print(res);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/profil.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("À propos"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Numéro"),
                            subtitle: Text("99822080"),
                            leading: Icon(Icons.call),
                          ),
                          ListTile(
                            title: Text("Sexe"),
                            subtitle: Text("femme"),
                            leading: Icon(Icons.person_sharp),
                          ),
                          ListTile(
                            title: Text("Age"),
                            subtitle: Text("22"),
                            leading: Icon(Icons.format_align_center),
                          ),
                          ListTile(
                            title: Text("Gouvernorat"),
                            subtitle: Text("Ariana"),
                            leading: Icon(Icons.place),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
