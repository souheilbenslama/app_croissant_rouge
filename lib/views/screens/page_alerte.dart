import 'package:app_croissant_rouge/services/accident.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/Protection.dart';
import 'package:app_croissant_rouge/views/screens/activate_account.dart';
import 'package:app_croissant_rouge/views/widgets/customized_dialog.dart';
import 'package:app_croissant_rouge/views/widgets/notification_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/pdf_viewer_from_asset.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

// The Server to the backend
const SERVER_IP = 'http://192.168.1.8:3000';
// The method to register the user
Future<String> attemptLogInUser(String userId) async {
  var res =
      await http.post("$SERVER_IP/users/normalUser", body: {"userid": userId});
  if (res.statusCode == 200) return res.body;
  return null;
}

class PageAlerte extends StatefulWidget {
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
  _PageAlerteState createState() => _PageAlerteState();
}

class _PageAlerteState extends State<PageAlerte> {
  Map decodedToken;
  String token;
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
            onPressed: null,
            child: Text(
              "Langue",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /* var prefs;
    Future<void> initState() async {
      super.initState();
      prefs = await SharedPreferences.getInstance();
    }

    bool isAdmin() {
      token = prefs.getString("token");
      if (token != null) {
        decodedToken = JwtDecoder.decode(token);
        if (decodedToken["isAdmin"]) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }*/
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    return FutureBuilder(
        future: prefs,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          bool isAdmin() {
            if (snapshot.hasData) {
              token = snapshot.data.getString("jwt");
              if (token != null) {
                decodedToken = JwtDecoder.decode(token);
                if (decodedToken["isAdmin"]) {
                  return true;
                } else
                  return false;
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent[700],
              actions: [
                // Used the actions to have the icons of the "App Bar" aligned in the same line
                IconButton(
                  // When the icon pressed it'll take as to the map page
                  iconSize: 35,
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/publicmap',
                        arguments: getInProgressInterventions());
                  },
                ),
                Container(
                  // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
                  width: 360,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (isAdmin())
                        IconButton(
                          // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                          onPressed: () {
                            Navigator.of(context).pushNamed('/dashboard');
                          },
                          iconSize: 35,
                          icon: Icon(
                            Icons.dashboard,
                            color: Colors.white70,
                          ),
                        ),
                      IconButton(
                        // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                        onPressed: () {
                          if (snapshot.hasData) {
                            token = snapshot.data.getString("jwt");
                            if (token != null) {
                              decodedToken = JwtDecoder.decode(token);
                              if (decodedToken["isActivated"]) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(decodedToken['Secouriste'])),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ActivateAccount(
                                          decodedToken['verificationCode'])),
                                );
                              }
                            }
                          }
                          //Navigator.of(context).pushNamed('/signIn');
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
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween, // space between to keep a certain space between the children of the Column
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Image.asset(
                    'assets/logo.jpg',
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                Container(
                  height: 70.0,
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () async {
                      var details = await PageAlerte.getDeviceDetails();
                      var userId = details[2];
                      //var res = await attemptLogInUser(userId);
                      Navigator.of(context).pushNamed('/options');
                      //print(res);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Alerter",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 120.0,
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () async {
                      var details = await PageAlerte.getDeviceDetails();
                      var userId = details[2];
                      //var res = await attemptLogInUser(userId);
                      Navigator.of(context).pushNamed('/options');
                      //print(res);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Contacter nous",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 120.0,
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    onPressed: () async {
                      var details = await PageAlerte.getDeviceDetails();
                      var userId = details[2];
                      //var res = await attemptLogInUser(userId);
                      Navigator.of(context).pushNamed('/options');
                      //print(res);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Documentation",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 410,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomizedDialog(
                                  'Contacter nous sur 25789369');
                            },
                          );
                        },
                        child: Text(
                          'Contacter-nous',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          // To see if the notification widget works or not
                          /*showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NotificationDialog();
                      },
                    );*/

                          // This Method will show the pdf without creating a widget => a simple pdf transition
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                appBar: AppBar(
                                  title: const Text('Documentation'),
                                  backgroundColor: Colors.redAccent[700],
                                ),
                                body: PDF().fromAsset('assets/file/dummy.pdf'),
                              ),
                            ),
                          );
                          /* Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (_) => PDFViewerFromAsset(
                          pdfAssetPath: 'assets/file/dummy.pdf',
                        ),
                      ),
                    );*/
                        },
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
        });
  }
}
