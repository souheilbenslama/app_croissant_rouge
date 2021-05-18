import 'package:app_croissant_rouge/views/screens/brulure.dart';
import 'package:app_croissant_rouge/views/screens/hemorragieExterne.dart';
import 'package:app_croissant_rouge/views/screens/malaise.dart';
import 'package:app_croissant_rouge/views/screens/plaies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class ListeCas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent[700]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Image.asset(
                'assets/logo.jpg',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("casPoss".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 65.0,
                  width: 180.0,
                  margin: EdgeInsets.only(),
                  child: RaisedButton(
                    onPressed: () {
                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);
                      doc.setCas("Malaise");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Malaise()),
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
                          "malaise".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 65.0,
                  width: 180.0,
                  margin: EdgeInsets.only(),
                  child: RaisedButton(
                    onPressed: () {
                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);
                      doc.setCas("Hemorragie Externe");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HemorragieExterne()),
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
                          "hemoExt".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 65.0,
                  width: 180.0,
                  margin: EdgeInsets.only(),
                  child: RaisedButton(
                    onPressed: () {
                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);
                      doc.setCas("Plaies");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Plaies()),
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
                          "Plaies".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 65.0,
                  width: 180.0,
                  margin: EdgeInsets.only(),
                  child: RaisedButton(
                    onPressed: () {
                      final doc =
                          Provider.of<AccidentProvider>(context, listen: false);
                      doc.setCas("Brulure");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Brulure()),
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
                          "brulure".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 65.0,
              width: 180.0,
              margin: EdgeInsets.only(),
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Fractures");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListeCas()),
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
                      "Fractures".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
