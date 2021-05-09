import 'dart:convert';

import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/lang/localization_service.dart';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/login_service.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/activate_account.dart';
import 'package:app_croissant_rouge/views/widgets/customized_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// The Server to the backend
const SERVER_IP = 'http://192.168.43.68:3000';
// The method to register the user
Future<String> attemptLogInUser(String userId) async {
  var res =
      await http.post("$SERVER_IP/users/normalUser", body: {"userid": userId});
  if (res.statusCode == 200) return res.body;
  return null;
}

class PageAlerte extends StatefulWidget {
  @override
  _PageAlerteState createState() => _PageAlerteState();
}

class _PageAlerteState extends State<PageAlerte> {
  Map decodedToken;
  Object token;
  String jwt;
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

  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      //PopMenuButton because we need a menu for the settings
      icon: Icon(
        Icons.settings,
        color: Colors.white70,
        size: 35,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          child: FlatButton(
            onPressed: () {
              setState(() {
                LocalizationService().changeLocale('Francais');
              });
            },
            child: Text(
              "Français",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          child: FlatButton(
            onPressed: () {
              setState(() {
                LocalizationService().changeLocale('Arabe');
              });
            },
            child: Text(
              "Arabe",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final doc = Provider.of<AccidentProvider>(context, listen: true);
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    return new WillPopScope(
        onWillPop: () async => false,
        child: FutureBuilder(
            future: prefs,
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              bool isAdmin() {
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  jwt = snapshot.data.getString("jwt");
                  print("hell");
                  if ((jwt != null)) {
                    token = jsonDecode(jwt)["token"];
                    decodedToken = JwtDecoder.decode(token);
                    //  print(decodedToken);
                    if (decodedToken["isAdmin"]) {
                      return true;
                    } else
                      return false;
                  }
                  return false;
                } else
                  return false;
              }

              bool isActivated() {
                if (snapshot.hasData) {
                  //  print(snapshot.data);
                  jwt = snapshot.data.getString("jwt");

                  if ((jwt != null)) {
                    token = jsonDecode(jwt)["token"];
                    decodedToken = JwtDecoder.decode(token);
                    // print(decodedToken);
                    if (decodedToken["isActivated"]) {
                      return true;
                    } else
                      return false;
                  }
                  return false;
                } else
                  return false;
              }

              bool isSecouriste() {
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  jwt = snapshot.data.getString("jwt");

                  if ((jwt != null)) {
                    token = jsonDecode(jwt)["token"];
                    decodedToken = JwtDecoder.decode(token);
                    // print(decodedToken);
                    if (!decodedToken["isNormalUser"]) {
                      return true;
                    } else
                      return false;
                  }
                  return false;
                } else
                  return false;
              }

              return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.redAccent[700],
                    actions: [
                      // Used the actions to have the icons of the "App Bar" aligned in the same line
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isSecouriste() && isActivated()
                                    ? SizedBox()
                                    : IconButton(
                                        // When the icon pressed it'll take as to the map page
                                        iconSize: 35,
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.white70,
                                        ),
                                        onPressed: () async {
                                          var arguments =
                                              await doc.getInterventions();
                                          print(
                                              "tttttttttttttttttttttttttttttttttttt");
                                          print(arguments);
                                          print(
                                              "tttttttttttttttttttttttttttttttttttt");
                                          // Navigator.of(context).pushNamed(
                                          //   '/publicmap',
                                          //   arguments: arguments);
                                        },
                                      ),
                                // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                      if (isAdmin() &&
                                          isSecouriste() &&
                                          isActivated())
                                        IconButton(
                                          // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('/dashboard');
                                          },
                                          iconSize: 35,
                                          icon: Icon(
                                            Icons.dashboard,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      IconButton(
                                        // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                                        onPressed: () async {
                                          if (snapshot.hasData) {
                                            jwt =
                                                snapshot.data.getString("jwt");
                                            if (jwt != null) {
                                              final decodedjwt =
                                                  jsonDecode(jwt);
                                              //print(decodedjwt);
                                              token = jsonDecode(jwt)["token"];
                                              decodedToken =
                                                  JwtDecoder.decode(token);
                                              // print(decodedToken);
                                              if (!decodedToken[
                                                      "isNormalUser"] &
                                                  decodedToken["isActivated"]) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                            Secouriste.fromJson(
                                                                decodedjwt)),
                                                  ),
                                                );
                                              } else if (!decodedToken[
                                                      "isNormalUser"] &
                                                  !decodedToken[
                                                      "isActivated"]) {
                                                var jwt =
                                                    await LoginServiceImp()
                                                        .attempttogetProfile();
                                                if (jwt != null) {
                                                  var ss = Secouriste.fromJson(
                                                      jsonDecode(jwt));
                                                  if (ss.isActivated) {
                                                    final prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString("jwt", jwt);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Profile(
                                                                        ss)));
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ActivateAccount(),
                                                      ),
                                                    );
                                                  }
                                                }
                                              } else if (decodedToken[
                                                  "isNormalUser"]) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                            Secouriste.fromJson(
                                                                decodedjwt)),
                                                  ),
                                                );
                                              }
                                            } else {
                                              Navigator.of(context)
                                                  .pushNamed('/signIn');
                                            }
                                          }
                                        },
                                        iconSize: 35,
                                        icon: Icon(
                                          Icons.account_circle,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Padding(
                                        // The padding contains the the settings icon and its functions : PopUpMenuButton
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                          bottom: 4.0,
                                        ),
                                        child: popupMenuButton(),
                                      ),
                                    ])),
                              ]))
                    ],
                  ),
                  backgroundColor: Colors.white,
                  body: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // space between to keep a certain space between the children of the Column
                        children: <Widget>[
                          //LOGO
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Image.asset(
                              'assets/logo.jpg',
                              width: 150,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          isSecouriste() && isActivated()
                              ? Container(
                                  height: 50.0,
                                  width: 140.0,
                                  margin: EdgeInsets.all(20),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      var arguments =
                                          await doc.getInterventions();
                                      Navigator.of(context)
                                          .pushReplacementNamed('/publicmap',
                                              arguments: arguments);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFe84f4c),
                                              Color(0xFFe2231e)
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 250.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Voir Map",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              :
                              //ALERTER
                              Center(
                                  child: Container(
                                  height: 110.0,
                                  margin: EdgeInsets.only(),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      //var details = await getDeviceDetails();
                                      //var userId = details[2];
                                      //var res = await attemptLogInUser(userId);
                                      Navigator.of(context)
                                          .pushNamed('/options');
                                      //print(res);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFe84f4c),
                                              Color(0xFFe2231e)
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 250.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "alerter".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 50),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          if (isSecouriste() && isActivated())
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: LiteRollingSwitch(
                                value: true,
                                textOn: 'Available',
                                textOff: 'Not Available',
                                colorOn: Colors.green,
                                colorOff: Colors.red[700],
                                iconOn: Icons.done,
                                iconOff: Icons.alarm_off,
                                textSize: 13.0,
                                onChanged: (bool state) {
                                  print('turned ${(state) ? 'on' : 'off'}');
                                },
                              ),
                            ),
                          //CONTACTER NOUS
                          Container(
                            margin: EdgeInsets.only(),
                            height: 55.0,
                            width: 150.0,
                            //margin: EdgeInsets.all(20),
                            child: RaisedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomizedDialog(
                                        'Contacter nous sur 25789369'.tr);
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFe84f4c),
                                        Color(0xFFe2231e)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 250.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "contacter".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //DOCUMENTATION
                          Container(
                            height: 55.0,
                            width: 150.0,
                            margin: EdgeInsets.only(),
                            child: RaisedButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Documentation'),
                                        backgroundColor: Colors.redAccent[700],
                                      ),
                                      body: PDF()
                                          .fromAsset('assets/file/dummy.pdf'),
                                    ),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFe84f4c),
                                        Color(0xFFe2231e)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 250.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "documentation".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )));
            }));
  }
}
