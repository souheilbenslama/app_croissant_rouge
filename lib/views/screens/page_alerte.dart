import 'package:app_croissant_rouge/views/widgets/customized_dialog.dart';
import 'package:app_croissant_rouge/views/widgets/notification_dialog.dart';
import '../widgets/pdf_viewer_from_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;

// The Server to the backend
const SERVER_IP = 'http://192.168.1.8:3000';
// The method to register the user
Future<String> attemptLogInUser(String userId) async {
  var res =
      await http.post("$SERVER_IP/users/normalUser", body: {"userid": userId});
  if (res.statusCode == 200) return res.body;
  return null;
}

class PageAlerte extends StatelessWidget {
  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      //PopMenuButton because we need a menu for the settings
      icon: Icon(
        Icons.settings,
        color: Colors.black,
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
            // When the icon pressed it'll take as to the map page
            iconSize: 35,
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/map');
            },
          ),
          Container(
            // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
            width: 360,
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
                    color: Colors.black,
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
            // Don't like the design : needs changing
            // Alerter when pressed will take us to the questions page
            color: Colors.redAccent[700],
            onPressed: () async {
              var details = await getDeviceDetails();
              var userId = details[2];
              var res = await attemptLogInUser(userId);
              Navigator.of(context).pushNamed('/options');
              print(res);
            },
            child: Text(
              'Alerter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 80,
              ),
            ),
            // we used the option shape here so the button cand have a rounded shape
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomizedDialog('Contacter nous sur 25789369');
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
  }
}
