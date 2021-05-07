import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// The package used to get the location
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// this function  Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Secouriste secourite;

  Profile(this.secourite);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
          onWillPop: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.remove('jwt');
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new SignIn(),
                      ),
                    );
                  },
                ),
              ],
              backgroundColor: Colors.redAccent[700],
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text("profil".tr),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage(
                        "assets/profil.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 95),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          this.secourite.name,
                                          style:
                                              Theme.of(context).textTheme.title,
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.all(10),
                                          title: LiteRollingSwitch(
                                            value: true,
                                            textOn: 'dispo'.tr,
                                            textOff: 'indispo'.tr,
                                            colorOn: Colors.green[700],
                                            colorOff: Colors.red[700],
                                            iconOn: Icons.notifications_active,
                                            iconOff: Icons.notifications_off,
                                            textSize: 18.0,
                                            onChanged: (bool position) async {
                                              if (position == true) {
                                                Position pos =
                                                    await _determinePosition();
                                                var res = await updateLocation(
                                                    pos.longitude,
                                                    pos.latitude);
                                                print(res);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.15),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/profil.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("apropos".tr),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("num".tr),
                                subtitle: Text(this.secourite.phone.toString()),
                                leading: Icon(Icons.call),
                              ),
                              ListTile(
                                title: Text("email".tr),
                                subtitle: Text(this.secourite.email),
                                leading: Icon(Icons.email_outlined),
                              ),
                              ListTile(
                                title: Text("age".tr),
                                subtitle: (this.secourite.age != null)
                                    ? Text(this.secourite.age.toString())
                                    : Text("22"),
                                leading: Icon(Icons.format_align_center),
                              ),
                              ListTile(
                                title: Text("gouvernorat".tr),
                                subtitle:
                                    Text(this.secourite.address.toString()),
                                leading: Icon(Icons.place),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
