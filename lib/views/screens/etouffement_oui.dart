import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/widgets/app_rating_box.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class EtoufOui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationData _locationData;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent[700],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Center(
              child: Text(
                'Etouffement',
              ),
            ),
            elevation: 0,
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '-Ne pas toucher \nla victime, \n ni la frapper.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[600])),
                              SizedBox(
                                height: 24,
                              ),
                              Text('-Encourager \nla victime\nà tousser.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[600])),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                  '-Faire asseoir \nla victime \ntête penchée \nen avant.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[600])),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                  '-Surveiller \nla victime  \net parler \navec elle \nrégulièrement.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[600])),
                              SizedBox(
                                height: 24,
                              ),
                              Text('                    .',
                                  style: TextStyle(fontSize: 20)),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image.asset('assets/images/chokingga2.png',
                                  height: height * 0.15, width: width * 0.3),
                              SizedBox(
                                height: 55,
                              ),
                              Image.asset('assets/images/chokingga11.png',
                                  height: height * 0.15, width: width * 0.3),
                              SizedBox(height: 55),
                              Image.asset('assets/images/chokingga3.png',
                                  height: height * 0.15, width: width * 0.3),
                              SizedBox(height: 55),
                            ])
                      ]),
                ),
                RaisedButton(
                  onPressed: () async {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);

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
                      String userId;
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AppRatingBox(userId);
                          });
                    }
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
                        "endButton".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2.2),
                      ),
                    ),
                  ),
                )
              ])),
    );
  }
}
