import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import '../../accidentProvider.dart';

class CriseNerfs extends StatelessWidget {
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
              )),
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
                                    MediaQuery.of(context).size.height * 0.09,
                              ),
                              Text('-Isoler la victime.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Text('-Allonger la victime.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Text('-Rafraichissez \nla victime.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Text(
                                  '-Recueillir des \ninformations \nsur l’état de santé; \n°As-tu des \ntraitements? \n°De quand date \nvotre dernier repas ? \n°Depuis quand est \napparu ce malaise?',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/iso.png',
                                height: 130,
                                width: 200,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Image.asset(
                                'assets/images/allongez.png',
                                height: 150,
                                width: 200,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Image.asset(
                                'assets/images/tal.png',
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
                          userId = details[2];
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
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageAlerte()));
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
