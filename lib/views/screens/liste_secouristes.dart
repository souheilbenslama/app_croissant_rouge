import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ListeSecouristes extends StatefulWidget {
  final secouristes;
  ListeSecouristes({Key key, @required this.secouristes}) : super(key: key);
  @override
  _ListeSecouristesState createState() => _ListeSecouristesState();
}

class _ListeSecouristesState extends State<ListeSecouristes> {
  var secouristes = [
    "Polly Blair",
    "Eleanor Leonard",
    "Sydney Ramos",
    "Georgia Miller",
    "Austin Miller",
    "Paul Mayor",
    "John Doe",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeSec".tr),
      ),
      body: ListView.builder(
        itemCount: widget.secouristes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/interventionParSecouriste');
            },
            child: Card(
              color: Colors.white,
              elevation: 3,
              child: Row(
                children: [
                  ListTile(
                    title: Text(
                      widget.secouristes[index] != null
                          ? widget.secouristes[index]
                          : "none",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: LiteRollingSwitch(
                          value: true,
                          textOn: 'Activer',
                          textOff: 'Desactiver',
                          colorOn: Colors.green,
                          colorOff: Colors.red[700],
                          iconOn: Icons.done,
                          iconOff: Icons.alarm_off,
                          textSize: 13.0,
                          onChanged: (bool state) {
                            print('turned ${(state) ? 'on' : 'off'}');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: LiteRollingSwitch(
                          value: true,
                          textOn: 'Admin',
                          textOff: 'Normal',
                          colorOn: Colors.green,
                          colorOff: Colors.red[700],
                          iconOn: Icons.done,
                          iconOff: Icons.alarm_off,
                          textSize: 13.0,
                          onChanged: (bool state) {
                            print('turned ${(state) ? 'on' : 'off'}');
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
