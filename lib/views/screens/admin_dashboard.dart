import 'package:app_croissant_rouge/services/admin_service.dart';
import 'package:app_croissant_rouge/views/screens/liste_interventions.dart';
import 'package:app_croissant_rouge/views/screens/liste_secouristes.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.redAccent[700],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Image.asset(
                  "assets/profil.png",
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        final arraySecouristes =
                            await AdminService.listSecourists();
                        var secouristes = [];
                        for (var i = 0; i < arraySecouristes.length; i++) {
                          print("it is " + arraySecouristes.length.toString());

                          secouristes.add(arraySecouristes[i]["name"]);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ListeSecouristes(
                              secouristes: secouristes,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: Card(
                          elevation: 8,
                          color: Colors.white70,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/group.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Liste des secouristes",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final arrayintervention =
                            await AdminService.listinterventions();
                        var interventions = [];
                        for (var i = 0; i < arrayintervention.length; i++) {
                          print("it is " + arrayintervention.length.toString());

                          interventions.add(arrayintervention[i]["id_temoin"]);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ListeInterventions(
                              interventions: interventions,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: Card(
                          elevation: 8,
                          color: Colors.white70,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/emergency2.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Liste des interventions",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*GestureDetector(
                      onTap: null,
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: Card(
                          elevation: 8,
                          color: Colors.white70,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/location.png',
                                  width: 64.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Liste des interventions par localité",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
