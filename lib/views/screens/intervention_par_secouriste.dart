import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:app_croissant_rouge/services/admin_service.dart';

import '../../models/secouriste.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class InterventionParSecouriste extends StatefulWidget {
  final Secouriste secouriste;
  bool makeAdmin = false;
  bool active = false;
  Future<List> interventions;
  InterventionParSecouriste({Key key, @required this.secouriste})
      : super(key: key);
  @override
  _InterventionParSecouristeState createState() =>
      _InterventionParSecouristeState();
}

class _InterventionParSecouristeState extends State<InterventionParSecouriste> {
  @override
  void initState() {
    super.initState();
    this.widget.makeAdmin = this.widget.secouriste.isAdmin;
    this.widget.active = this.widget.secouriste.isActivated;
  }

  @override
  Widget build(BuildContext context) {
    this.widget.interventions =
        AdminService.secouristelistInter(this.widget.secouriste.id);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.redAccent[700],
          title: Text("listeInter".tr),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nom et prenom : ${widget.secouriste.name.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Age : ${widget.secouriste.age.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "E-mail : ${widget.secouriste.email.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Numero : ${widget.secouriste.phone.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Adresse : ${widget.secouriste.gouvernorat.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Code de verification : ${widget.secouriste.verificationCode.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                iconSize: 30,
                                color: this.widget.makeAdmin
                                    ? Colors.green
                                    : Colors.red,
                                icon: Icon(Icons.person),
                                onPressed: () {
                                  setState(() {
                                    this.widget.makeAdmin =
                                        !this.widget.makeAdmin;
                                    this.widget.secouriste.isAdmin =
                                        !this.widget.secouriste.isAdmin;
                                    changeUsertype(this.widget.secouriste.id,
                                        this.widget.makeAdmin);
                                  });
                                },
                              ),
                              Text(
                                this.widget.makeAdmin ? "Admin" : "Normal User",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: this.widget.makeAdmin
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                iconSize: 30,
                                color: this.widget.active
                                    ? Colors.green
                                    : Colors.red,
                                icon: Icon(this.widget.active
                                    ? Icons.alarm_on
                                    : Icons.alarm_off),
                                onPressed: () {
                                  setState(() {
                                    this.widget.active = !this.widget.active;
                                    this.widget.secouriste.isActivated =
                                        this.widget.secouriste.isActivated;

                                    changeUserActivation(
                                        this.widget.secouriste.id,
                                        this.widget.active);
                                  });
                                },
                              ),
                              Text(
                                this.widget.active ? "Activé" : "Desactivé",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: this.widget.active
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: this.widget.interventions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            child: ListTile(
                              title: Column(
                                children: [
                                  Text(
                                    data[index].address,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data[index].cas,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMMEEEEd()
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container(
                        color: Colors.white,
                        child: Align(
                            alignment: Alignment.center,
                            child: Center(
                                child: SpinKitFadingCircle(
                              color: Colors.grey[800],
                              size: 80,
                            ))));
                  }
                },
              )
            ],
          ),
        ));
  }
}
