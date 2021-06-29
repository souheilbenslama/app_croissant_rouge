import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import '../../accidentProvider.dart';

class BrulureGrave extends StatelessWidget {
  LocationData _locationData;
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
            ),
            title: Center(
              child: Text(
                'Brûlure grave',
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                  child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                              ),
                              Text('-Refroidir avec \nde l’eau.',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Text('-Allonger \nla victime .',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              Image.asset(
                                'assets/images/clean.png',
                                height: 130,
                                width: 200,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Image.asset(
                                'assets/images/allongez.png',
                                height: 150,
                                width: 200,
                              ),
                            ])
                      ]),
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

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageAlerte()));
                      doc.clear();
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
                ],
              ))),
        ));
  }
}
