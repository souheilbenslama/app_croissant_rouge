import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/views/screens/brulure_simple.dart';
import 'package:app_croissant_rouge/views/screens/brulure_grave.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class Brulure extends StatelessWidget {
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
      appBar: AppBar(backgroundColor: Colors.redAccent[700]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.055 * height,
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
              height: height * 0.055,
            ),
            Text('brulureQuest'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )),
            SizedBox(
              height: 0.055 * height,
            ),
            Container(
              height: height * 0.068,
              width: width * 0.681,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Brûlure simple.\n");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrulureSimple()),
                  );
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "brulureSimple".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.021,
            ),
            Container(
              height: height * 0.068,
              width: width * 0.681,
              child: RaisedButton(
                onPressed: () async {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Brûlure grave");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrulureGrave()),
                  );
                  const number = '198';

                  FlutterPhoneDirectCaller.callNumber(number);
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "brulureGrave".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.246,
              width: height * 0.246,
              child: Image.asset(
                'assets/images/burn1g.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
