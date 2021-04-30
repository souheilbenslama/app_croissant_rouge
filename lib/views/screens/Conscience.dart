//KHALIL

import 'package:app_croissant_rouge/models/choix_conscience.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/views/screens/Hemorragie.dart';
import 'package:app_croissant_rouge/views/screens/respiration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Conscience extends StatefulWidget {
  @override
  _ConscienceState createState() => _ConscienceState();
}

class _ConscienceState extends State<Conscience> {
  final choix = [
    ChoixConscience(title: "Reponse1"),
    ChoixConscience(title: "Reponse2"),
    ChoixConscience(title: "Reponse3"),
    ChoixConscience(title: "Reponse4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('conscience'.tr)),
          backgroundColor: Colors.redAccent[700],
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
                    ),
                  ),
                  Align(
                    child: Text("3/4"),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          'https://media-exp1.licdn.com/dms/image/C4D0BAQEeQQyHaoMmrg/company-logo_200_200/0/1519889981767?e=2159024400&v=beta&t=tkf0F4V2T0xlxp0mWnLsdsaHhnWGIyiIyHkr9aMBD44'),
                    ),
                    Text("     Question 3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))
                  ],
                )),
            Divider(),
            ...choix.map(buildSingleCheckbox).toList(),
            Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Color.fromRGBO(226, 56, 50, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Hemorragie()),
                      );
                    },
                    child: Text("previousButton".tr),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(226, 56, 50, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      choix.forEach((element) {
                        if (element.value) {
                          Provider.of<AccidentProvider>(context, listen: false)
                              .addConscience(element);
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Respiration()),
                      );
                    },
                    child: Text("nextButton".tr),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildSingleCheckbox(ChoixConscience choix) => buildCheckbox(
      choix: choix,
      onClicked: () {
        setState(() {
          final newValue = !choix.value;
          choix.value = newValue;
        });
      });

  Widget buildCheckbox(
          {ChoixConscience choix, VoidCallback onClicked}) =>
      ListTile(
          onTap: onClicked,
          title: Text(choix.title),
          leading:
              Checkbox(value: choix.value, onChanged: (value) => onClicked()));
}
