import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/perte_connaissance_etapes.dart';
import 'package:app_croissant_rouge/views/screens/question_etouffement.dart';

import 'package:device_info/device_info.dart';
import 'package:app_croissant_rouge/views/screens/listeDesCas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';
import 'package:get/get.dart';

class Respire extends StatelessWidget {
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
    LocationData _locationData;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.05 * height,
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Image.asset(
              'assets/profil.png',
              width: height * 0.205,
              height: height * 0.205,
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Text("respQuest".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.2)),
          SizedBox(
            height: 0.05 * height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.07,
                width: width * 0.364,
                child: RaisedButton(
                  onPressed: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    bool conscient = doc.conscient;
                    doc.setRespire(true);
                    if (conscient) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListeCas()),
                      );
                    } else {
                      doc.setCas("Perte de connaissance");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StepList()),
                      );
                    }
                  },
                  color: Colors.redAccent[700],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "oui".tr,
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.073,
              ),
              Container(
                height: height * 0.068,
                width: width * 0.364,
                child: RaisedButton(
                  onPressed: () async {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);

                    bool conscient = doc.conscient;
                    doc.setRespire(false);
                    if (conscient) {
                      doc.setCas("Etouffement");

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Etouffement()),
                      );
                    } else {
                      const number = '198';

                      FlutterPhoneDirectCaller.callNumber(number);
                      print("here here");

                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);

                      doc.setCas("Arrêt cardiaque");

                      if (doc.getCurrentLocation() != null) {
                        _locationData = doc.currentLocation;
                        String latitude = _locationData.latitude.toString();
                        String longitude = _locationData.longitude.toString();
                        doc.setLatitude(latitude);
                        doc.setLongitude(longitude);
                        var localite;
                        var address;
                        try {
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  _locationData.latitude,
                                  _locationData.latitude);

                          localite = placemarks[0].subAdministrativeArea;

                          address = placemarks[0].administrativeArea +
                              "  " +
                              placemarks[0].subAdministrativeArea +
                              " " +
                              placemarks[0].locality +
                              " " +
                              placemarks[0].street +
                              " " +
                              placemarks[0].postalCode;
                        } catch (e) {}

                        var jsondoc = doc.getInfo();
                        String userId;
                        if (doc.gettoken() != null) {
                          final decodedToken =
                              JwtDecoder.decode(doc.gettoken());
                          userId = decodedToken["id"];
                        } else {
                          var details = await getDeviceDetails();
                          String deviceId = details[2];
                          userId = jsonDecode(await UserService.attemptgetUser(
                              deviceId))["_id"];
                        }

                        AccidentService.createAccident(
                            userId,
                            jsondoc["longitude"],
                            jsondoc["latitude"],
                            jsondoc["cas"],
                            jsondoc["description"],
                            jsondoc["need_secouriste"],
                            address,
                            localite);
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PageAlerte()),
                      );
                      doc.clear();
                    }
                  },
                  color: Colors.redAccent[700],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "non".tr,
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: height * 0.274,
            width: height * 0.274,
            child: Image.asset('assets/images/uncons1g.png'), //respire1.png'),
          ),
        ],
      ),
    );
  }
}
