import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/widgets/app_rating_box.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../accidentProvider.dart';

class Details extends StatelessWidget {
  final Instruction instruction;
  Details({@required this.instruction});

  @override
  Widget build(BuildContext context) {
    LocationData _locationData;
    String userId;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              ClipRRect(
                  child: Hero(
                tag: 'case-img-${instruction.img}',
                child: Image.asset(
                  'assets/images/${instruction.img}',
                  height: 250,
                  width: 300,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(instruction.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[800])),
              ),
              Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('${instruction.steps}',
                      style: TextStyle(
                          color: Colors.black, height: 1.4, fontSize: 18))),
              SizedBox(
                height: 50,
              ),
              (this.instruction.needButton)
                  ? Align(
                      child: ButtonTheme(
                          child: RaisedButton(
                      onPressed: () async {
                        final doc = Provider.of<AccidentProvider>(context,
                            listen: false);

                        doc.setDescription(" " + instruction.title);

                        if (doc.getCurrentLocation() != null) {
                          _locationData = doc.currentLocation;
                          String latitude = _locationData.latitude.toString();
                          String longitude = _locationData.longitude.toString();
                          doc.setLatitude(latitude);
                          doc.setLongitude(longitude);
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  _locationData.latitude,
                                  _locationData.latitude);

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
                          print(jsondoc);

                          if (doc.gettoken() != null) {
                            final decodedToken =
                                JwtDecoder.decode(doc.gettoken());
                            userId = decodedToken["id"];
                          } else {
                            var details = await getDeviceDetails();
                            String deviceId = details[2];
                            userId = jsonDecode(
                                    await UserService.attemptgetUser(deviceId))[
                                "_id"];
                          }
                          var res2 = AccidentService.createAccident(
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
//                  Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => PageAlerte()));
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
                    )))
                  : SizedBox()
            ],
          ),
        )));
  }
}
