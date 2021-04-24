import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:app_croissant_rouge/views/screens/protection.dart';
import 'package:app_croissant_rouge/views/screens/admin_dashboard.dart';
import 'package:app_croissant_rouge/views/widgets/customized_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// The Server to the backend
const SERVER_IP = 'http://192.168.43.68:3000';
// The method to register the user
Future<String> attemptLogInUser(String userId) async {
  var res =
      await http.post("$SERVER_IP/users/normalUser", body: {"userid": userId});
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
    final doc = Provider.of<AccidentProvider>(context, listen: false);
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
                    IconButton(
                      // When the icon pressed it'll take as to the map page
                      iconSize: 35,
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        var arguments = doc.getInterventions();
                        print(arguments);
                        Navigator.of(context)
                            .pushNamed('/publicmap', arguments: arguments);
                        /*[
                              new Accident(
                                  id: "AZE", localisation: LatLng(35.34, 34.34))
                            ]); */
                      },
                    ),

                    // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signIn');
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
                        IconButton(
                          // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminDashboard()));
                          },
                          iconSize: 35,
                          icon: Icon(
                            Icons.admin_panel_settings,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    )),
                  ]))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment
            .center, // space between to keep a certain space between the children of the Column
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
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Alerter",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ),
            ),
          )),
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
                    return CustomizedDialog('Contacter nous sur 25789369');
                  },
                );
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
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Contacter nous",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
                      body: PDF().fromAsset('assets/file/dummy.pdf'),
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
                      colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Documentation",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
