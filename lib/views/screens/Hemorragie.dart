//KHALIL
import 'package:app_croissant_rouge/models/ChoixHemorragie.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';

import 'package:app_croissant_rouge/views/screens/Conscience.dart';
import 'package:app_croissant_rouge/views/screens/Protection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hemorragie extends StatefulWidget {
  @override
  _HemorragieState createState() => _HemorragieState();
}

class _HemorragieState extends State<Hemorragie> {
  final choix = [
    ChoixHemorragie(title: "Reponse1"),
    ChoixHemorragie(title: "Reponse2"),
    ChoixHemorragie(title: "Reponse3"),
    ChoixHemorragie(title: "Reponse4"),
    ChoixHemorragie(title: "Reponse5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Hemorragie')),
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
                      value: 0.5,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
                    ),
                  ),
                  Align(
                    child: Text("2/4"),
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
                    Text("     Question 2",
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
                        MaterialPageRoute(builder: (context) => Protection()),
                      );
                    },
                    child: Text("Previous"),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(226, 56, 50, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      choix.forEach((element) {
                        if (element.value) {
                          Provider.of<AccidentProvider>(context, listen: false)
                              .addHemorragie(element);
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Conscience()),
                      );
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildSingleCheckbox(ChoixHemorragie choix) => buildCheckbox(
      choix: choix,
      onClicked: () {
        setState(() {
          final newValue = !choix.value;
          choix.value = newValue;
        });
      });

  Widget buildCheckbox(
          {ChoixHemorragie choix, VoidCallback onClicked}) =>
      ListTile(
          onTap: onClicked,
          title: Text(choix.title),
          leading:
              Checkbox(value: choix.value, onChanged: (value) => onClicked()));
}
