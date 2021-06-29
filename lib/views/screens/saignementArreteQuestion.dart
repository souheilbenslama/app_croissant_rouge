import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:app_croissant_rouge/views/widgets/app_rating_box.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../accidentProvider.dart';
import 'package:location/location.dart';

class SaignementArreteQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId;
    LocationData _locationData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(),
            child: Image.asset(
              'assets/logo.jpg',
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "saignQuest".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 30,
              //fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 130.0,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: () async {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription(" La victime saigne du nez ");
                    if (doc.getCurrentLocation() != null) {
                      _locationData = doc.currentLocation;
                      String latitude = _locationData.latitude.toString();
                      String longitude = _locationData.longitude.toString();
                      doc.setLatitude(latitude);
                      doc.setLongitude(longitude);
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _locationData.latitude, _locationData.latitude);

                      final localite = placemarks[0].subAdministrativeArea;

                      final address = placemarks[0].administrativeArea +
                          "  " +
                          placemarks[0].subAdministrativeArea +
                          " " +
                          placemarks[0].locality +
                          " " +
                          placemarks[0].street +
                          " " +
                          placemarks[0].postalCode;

                      var jsondoc = doc.getInfo();

                      if (doc.gettoken() != null) {
                        final decodedToken = JwtDecoder.decode(doc.gettoken());
                        userId = decodedToken["id"];
                      } else {
                        var details = await getDeviceDetails();
                        String deviceId = details[2];
                        userId = jsonDecode(
                            await UserService.attemptgetUser(deviceId))["_id"];
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

                      doc.clear();
                    }

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AppRatingBox(userId);
                        });
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
                        "oui".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 60.0,
                width: 130.0,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: () async {
                    const number = '198';
                    FlutterPhoneDirectCaller.callNumber(number);

                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription(" La victime saigne du nez ");
                    if (doc.getCurrentLocation() != null) {
                      _locationData = doc.currentLocation;
                      String latitude = _locationData.latitude.toString();
                      String longitude = _locationData.longitude.toString();
                      doc.setLatitude(latitude);
                      doc.setLongitude(longitude);
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _locationData.latitude, _locationData.latitude);

                      final localite = placemarks[0].subAdministrativeArea;

                      final address = placemarks[0].administrativeArea +
                          "  " +
                          placemarks[0].subAdministrativeArea +
                          " " +
                          placemarks[0].locality +
                          " " +
                          placemarks[0].street +
                          " " +
                          placemarks[0].postalCode;

                      var jsondoc = doc.getInfo();

                      if (doc.gettoken() != null) {
                        final decodedToken = JwtDecoder.decode(doc.gettoken());
                        userId = decodedToken["id"];
                      } else {
                        var details = await getDeviceDetails();
                        String deviceId = details[2];
                        userId = jsonDecode(
                            await UserService.attemptgetUser(deviceId))["_id"];
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

                      doc.clear();
                    }

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AppRatingBox(userId);
                        });
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
                        "non".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
