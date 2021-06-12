import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'dart:convert';
import 'package:app_croissant_rouge/views/widgets/app_rating_box.dart';
import 'package:app_croissant_rouge/views/widgets/rating_box.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:app_croissant_rouge/views/screens/saignementArreteQuestion.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/hemorragie_Instruction.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../accidentProvider.dart';

class HemorragieDetails extends StatelessWidget {
  final HemorragieInstruction instruction;
  bool alerteSecour;
  bool needSecouriste;
  HemorragieDetails({@required this.instruction});

  @override
  Widget build(BuildContext context) {
    LocationData _locationData;
    String userId;
    int duration = 3000; //3600*1000;
    Function finish_callback = (data) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black12)),
                          child: Text(
                            "non".tr,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 50, left: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                final doc = Provider.of<AccidentProvider>(
                                    context,
                                    listen: false);
                                print(doc.getCurrentAccident().id);

                                AccidentService.updateToFinished(
                                    doc.currentAccident.id);

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AppRatingBox(userId);
                                    });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              child: Text(
                                "oui".tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ],
                    ))
              ],
              title: Text("est-ce que les secours sont arrivée ?"),
            );
          });
      return;
    };

    Function finish_callback_nez = (data) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SaignementArreteQuestion()));

      return;
    };

    if ((this.instruction.needSecouriste)) {
      var future = new Future.delayed(const Duration(milliseconds: 3000));
      var subscription = future.asStream().listen(finish_callback);
    }

    if ((this.instruction.img == "b3.png")) {
      var future = new Future.delayed(const Duration(milliseconds: 3000));
      var subscription = future.asStream().listen(finish_callback_nez);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          elevation: 0,
        ),
        floatingActionButton: (this.instruction.needSecouriste)
            ? FloatingActionButton(
                onPressed: () async {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  if (doc.gettoken() != null) {
                    final decodedToken = JwtDecoder.decode(doc.gettoken());
                    userId = decodedToken["id"];
                  } else {
                    var details = await getDeviceDetails();
                    String deviceId = details[2];
                    userId = jsonDecode(
                        await UserService.attemptgetUser(deviceId))["_id"];
                  }

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ChatScreen(doc.getCurrentAccident().id, userId);
                      });
                },
                tooltip: 'Increment',
                backgroundColor: Colors.red,
                child: Icon(Icons.messenger),
              )
            : SizedBox(),
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
              (this.instruction.needSecouriste)
                  ? Container(
                      // height: 0.068 * height,
                      //width: 0.560 * width,
                      child: RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AppRatingBox(userId);
                              });

                          final doc = Provider.of<AccidentProvider>(context,
                              listen: false);
                          print(doc.getCurrentAccident().id);

                          AccidentService.updateToFinished(
                              doc.currentAccident.id);
                        },
                        color: Colors.redAccent[700],
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.121),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "secours arrivé",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              (this.instruction.needSecouriste)
                  ? Container(
                      // height: 0.068 * height,
                      //width: 0.560 * width,
                      child: RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AppRatingBox(userId);
                              });

                          showDialog(
                              context: context,
                              builder: (context) {
                                return RatingBox();
                              });
                          final doc = Provider.of<AccidentProvider>(context,
                              listen: false);
                          print(doc.getCurrentAccident().id);

                          AccidentService.updateToFinished(
                              doc.currentAccident.id);
                        },
                        color: Colors.redAccent[700],
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.121),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "secouriste arrivé",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              (this.instruction.needButton && !this.instruction.needSecouriste)
                  ? Align(
                      child: ButtonTheme(
                          child: RaisedButton(
                      onPressed: () async {
                        if (!this.instruction.needSecouriste) {
                          final doc = Provider.of<AccidentProvider>(context,
                              listen: false);

                          doc.setDescription(" " + instruction.title);

                          if (doc.getCurrentLocation() != null) {
                            _locationData = doc.currentLocation;
                            String latitude = _locationData.latitude.toString();
                            String longitude =
                                _locationData.longitude.toString();
                            doc.setLatitude(latitude);
                            doc.setLongitude(longitude);
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    _locationData.latitude,
                                    _locationData.latitude);

                            final localite =
                                placemarks[0].subAdministrativeArea;

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
                              final decodedToken =
                                  JwtDecoder.decode(doc.gettoken());
                              userId = decodedToken["id"];
                            } else {
                              var details = await getDeviceDetails();
                              String deviceId = details[2];
                              userId = jsonDecode(
                                  await UserService.attemptgetUser(
                                      deviceId))["_id"];
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
