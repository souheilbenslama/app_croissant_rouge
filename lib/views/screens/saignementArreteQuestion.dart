import 'package:app_croissant_rouge/views/screens/listeDesCas.dart';
import 'package:app_croissant_rouge/views/screens/respiration2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';

class SaignementArreteQuestion extends StatelessWidget {
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
          Text(
            "Le saignement s'est-il arrêté?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 30,
              //fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 130.0,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: null,
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
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 60.0,
                width: 130.0,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: null,
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
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
