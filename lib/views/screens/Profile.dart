import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:app_croissant_rouge/views/screens/profile_update.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
// The package used to get the location
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Secouriste secouriste;

  Profile(this.secouriste);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageAlerte()),
          );
        },
        child: MaterialApp(
            home: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProfileUpdate(secouriste: this.secouriste)));
                      },
                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 95),
                                        child: Text(this.secouriste.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
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
                                    title: Text("email".tr),
                                    subtitle: Text(this.secouriste.email),
                                    leading: Icon(Icons.email_outlined),
                                  ),
                                  ListTile(
                                    title: Text("cin".tr),
                                    subtitle: Text(this.secouriste.cin),
                                    leading: Icon(Icons.badge),
                                  ),
                                  ListTile(
                                    title: Text("num".tr),
                                    subtitle:
                                        Text(this.secouriste.phone.toString()),
                                    leading: Icon(Icons.call),
                                  ),
                                  ListTile(
                                    title: Text("age".tr),
                                    subtitle: (this.secouriste.age != null)
                                        ? Text(this.secouriste.age.toString())
                                        : Text("22"),
                                    leading: Icon(Icons.date_range),
                                  ),
                                  ListTile(
                                    title: Text("gouvernorat".tr),
                                    subtitle: Text(
                                        this.secouriste.gouvernorat.toString()),
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
                ))));
  }
}

/* } else {
                      return Container(
                          color: Colors.white,
                          width: 500,
                          child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                  child: SpinKitFadingCircle(
                                color: Colors.grey[800],
                                size: 140.0,
                              ))));
                    }
 */
