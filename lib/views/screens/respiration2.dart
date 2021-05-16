import 'package:app_croissant_rouge/views/screens/Conscience.dart';
import 'package:app_croissant_rouge/views/screens/Conscience2.dart';
import 'package:app_croissant_rouge/views/screens/etapes.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
            height: 80,
          ),
          Text("La victime respire-t-elle?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.2)),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
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
                      MaterialPageRoute(builder: (context) => StepList()),
                    );
                  }
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Oui",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
              /*Container(
                height: 60.0,
                width: 130.0,
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
                        MaterialPageRoute(builder: (context) => StepList()),
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
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                onPressed: () async {
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
                    const number = '198';
                    await FlutterPhoneDirectCaller.callNumber(number);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PageAlerte()),
                    );
                  }
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Non",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
              /*Container(
                height: 60.0,
                width: 130.0,
                margin: EdgeInsets.only(),
                child: RaisedButton(
                  onPressed: () async {
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
                      const number = '198';
                      await FlutterPhoneDirectCaller.callNumber(number);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PageAlerte()),
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
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              )*/
            ],
          )
        ],
      ),
    );
  }
}
