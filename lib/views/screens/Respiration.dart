//KHALIL

import 'package:app_croissant_rouge/models/choix_respiration.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/screens/Conscience.dart';
import 'package:app_croissant_rouge/views/screens/Instruction.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

class Respiration extends StatefulWidget {
  @override
  _RespirationState createState() => _RespirationState();
}

class _RespirationState extends State<Respiration> {
  final choix = [
    ChoixRespiration(title: "Reponse1"),
    ChoixRespiration(title: "Reponse2"),
    ChoixRespiration(title: "Reponse3"),
    ChoixRespiration(title: "Reponse4"),
  ];
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
          title: Center(child: Text('Respiration')),
          backgroundColor: Colors.redAccent[700],
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: LinearProgressIndicator(
                      value: 1.0,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
                    ),
                  ),
                  Align(
                    child: Text("4/4"),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          'https://media-exp1.licdn.com/dms/image/C4D0BAQEeQQyHaoMmrg/company-logo_200_200/0/1519889981767?e=2159024400&v=beta&t=tkf0F4V2T0xlxp0mWnLsdsaHhnWGIyiIyHkr9aMBD44'),
                    ),
                    Text("     Question 4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))
                  ],
                )),
            Divider(),
            ...choix.map(buildSingleCheckbox).toList(),
            Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Color.fromRGBO(226, 56, 50, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Conscience()),
                      );
                    },
                    child: Text("Previous"),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(226, 56, 50, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () async {
                      Location location = new Location();

                      bool _serviceEnabled;
                      PermissionStatus _permissionGranted;
                      LocationData _locationData;

                      _serviceEnabled = await location.serviceEnabled();
                      if (!_serviceEnabled) {
                        _serviceEnabled = await location.requestService();
                        if (!_serviceEnabled) {
                          return;
                        }
                      }

                      _permissionGranted = await location.hasPermission();
                      if (_permissionGranted == PermissionStatus.denied) {
                        _permissionGranted = await location.requestPermission();
                        if (_permissionGranted != PermissionStatus.granted) {
                          return;
                        }
                      }

                      _locationData = await location.getLocation();
                      String latitude = _locationData.latitude.toString();
                      String longitude = _locationData.longitude.toString();

                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);

                      choix.forEach((element) {
                        if (element.value) {
                          doc.addRespiration(element);
                        }
                      });

                      doc.setLatitude(latitude);
                      print('LATITUDE : ' + doc.latitude.toString());
                      doc.setLongitude(longitude);
                      print('LONGITUDE : ' + doc.longitude.toString());
                      print('CHOIX : ');
                      doc.choixRespiration.forEach((element) {
                      print(element);
                      });

                      var jsondoc = doc.getInfo();
                      var details = await getDeviceDetails();
                      var userId = details[2];
                      var res2 = await AccidentService.createAccident(
                          userId,
                          jsondoc["longitude"],
                          jsondoc["latitude"],
                          jsondoc["protection"],
                          jsondoc["hemorragie"],
                          jsondoc["respiration"],
                          jsondoc["conscience"]);
                      print("/////////////////:");
                      print(res2);
                      print("/////////////");

                      const number = '198';
                      bool res =
                          await FlutterPhoneDirectCaller.callNumber(number);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstructionList()));
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildSingleCheckbox(ChoixRespiration choix) => buildCheckbox(
      choix: choix,
      onClicked: () {
        setState(() {
          final newValue = !choix.value;
          choix.value = newValue;
        });
      });

  Widget buildCheckbox({ChoixRespiration choix, VoidCallback onClicked}) =>
      ListTile(
          onTap: onClicked,
          title: Text(choix.title),
          leading:
              Checkbox(value: choix.value, onChanged: (value) => onClicked()));
}
