import 'package:app_croissant_rouge/views/screens/etouffement2.dart';
import 'package:app_croissant_rouge/views/screens/etouffement_oui.dart';
import 'package:app_croissant_rouge/views/screens/etouffement_non.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';
import 'package:get/get.dart';

class Etouffement extends StatelessWidget {
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
          Text("etouffQuest".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 20,
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
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("La victime tousse ou émet un son.\n");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EtoufOui()));
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
                        "oui".tr,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EtoufNon()),
                    );
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
                        "non".tr,
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
