import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';

import 'dart:convert';
import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:app_croissant_rouge/views/screens/my_detail_page.dart';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class StepList extends StatefulWidget {
  @override
  _StepListState createState() => _StepListState();
}

class _StepListState extends State<StepList> {
  List<Widget> _instructionTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addInstructions();
  }

  void _addInstructions() {
    List<Instruction> _instructions = [
      Instruction(
          title: 'etape1'.tr,
          img: 'e1.PNG',
          steps: "etape1Inst".tr,
          needButton: false),
      Instruction(
          title: 'etape2'.tr,
          img: 'e2.PNG',
          steps: "etape2Inst".tr,
          needButton: false),
      Instruction(
          title: 'etape3'.tr,
          img: 'e3.PNG',
          steps: "etape3Inst".tr,
          needButton: false),
      Instruction(
          title: 'etape4'.tr,
          img: 'e4.PNG',
          steps: "etape4Inst".tr,
          needButton: false),
      Instruction(
          title: 'etape5'.tr,
          img: 'e5.PNG',
          steps: "etape5Inst".tr,
          needButton: false),
    ];

    _instructions.forEach((Instruction instruction) {
      _instructionTiles.add(_buildTile(instruction));
    });
  }

  Widget _buildTile(Instruction instruction) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(instruction: instruction)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(instruction.title,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'case-img-${instruction.img}',
          child: Image.asset(
            'assets/images/${instruction.img}',
            height: 50.0,
            width: 50.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationData _locationData;
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: Center(
            child: Text('pos'.tr,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20))),
        backgroundColor: Colors.redAccent[700],
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  key: _listKey,
                  shrinkWrap: true,
                  itemCount: _instructionTiles.length,
                  itemBuilder: (context, index) {
                    return _instructionTiles[index];
                  }),
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
                    doc.setDescription("no description");

                    var localite;
                    var address;
                    try {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _locationData.latitude, _locationData.latitude);

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
                    } catch (e) {
                      //  print(e);
                    }

                    var jsondoc = doc.getInfo();
                    String userId;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PageAlerte()));
                    if (doc.gettoken() != null) {
                      print("yesyesyes");
                      final decodedToken = JwtDecoder.decode(doc.gettoken());
                      userId = decodedToken["id"];
                    } else {
                      var details = await getDeviceDetails();
                      print("yesyesyes2");
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
                  }

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
              ), //CONTACTER NOUS
            ]),
      ),
    );
  }
}
