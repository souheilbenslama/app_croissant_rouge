import '../../models/secouriste.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class InterventionParSecouriste extends StatefulWidget {
  final Secouriste secouriste;
  InterventionParSecouriste({Key key, @required this.secouriste})
      : super(key: key);
  @override
  _InterventionParSecouristeState createState() =>
      _InterventionParSecouristeState();
}

class _InterventionParSecouristeState extends State<InterventionParSecouriste> {
  var makeAdmin = false;
  var active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeInter".tr),
      ),
      body: Column(
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
                    "Code de verification : 156325",
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
                            color: makeAdmin ? Colors.green : Colors.red,
                            icon: Icon(Icons.person),
                            onPressed: () {
                              setState(() {
                                makeAdmin = !makeAdmin;
                              });
                            },
                          ),
                          Text(
                            makeAdmin ? "Admin" : "Normal User",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: makeAdmin ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 30,
                            color: active ? Colors.green : Colors.red,
                            icon:
                                Icon(active ? Icons.alarm_on : Icons.alarm_off),
                            onPressed: () {
                              setState(() {
                                active = !active;
                              });
                            },
                          ),
                          Text(
                            active ? "Activé" : "Desactivé",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: active ? Colors.green : Colors.red,
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
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  child: ListTile(
                    title: Column(
                      children: [
                        Text(
                          "ariana".tr,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
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
          ),
        ],
      ),
    );
  }
}
