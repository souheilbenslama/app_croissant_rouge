import 'package:app_croissant_rouge/views/screens/Conscience.dart';
import 'package:app_croissant_rouge/views/screens/Conscience2.dart';
import 'package:app_croissant_rouge/views/screens/Protection.dart';
import 'package:app_croissant_rouge/views/screens/Respiration.dart';
import 'package:app_croissant_rouge/views/screens/etouffement.dart';
import 'package:app_croissant_rouge/views/screens/listeDesCas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';

class Respire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(),
            child: Image.asset(
              'assets/logo.jpg',
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text("La victime respire-t-elle?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 60,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
          SizedBox(
            height: 120,
          ),
          Row(
            children: [
              Container(
                height: 100.0,
                width: 205.5,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: () {
                    dynamic doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    bool conscient = doc.conscient;
                    doc.setRespire(true);
                    if (conscient) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListeCas()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Protection()),
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
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
                        "Oui",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100.0,
                width: 205.5,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    bool conscient = doc.conscient;
                    doc.setRespire(false);
                    if (conscient) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Etouffement()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Respiration()),
                      );
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
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
                        "Non",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
