import 'package:app_croissant_rouge/views/screens/brulure.dart';
import 'package:app_croissant_rouge/views/screens/criseDeNerfs.dart';
import 'package:app_croissant_rouge/views/screens/hemorragieExterne.dart';
import 'package:app_croissant_rouge/views/screens/malaise.dart';
import 'package:app_croissant_rouge/views/screens/malaiseCardiaque.dart';
import 'package:app_croissant_rouge/views/screens/malaiseDiabetique.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';
import 'package:app_croissant_rouge/views/screens/plaies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'listeDesCas.dart';

class ListeMalaise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              height: 50,
            ),
            Text(
              "casPoss".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 50,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 65,
              width: 270,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Crise de nerfs");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriseDeNerfs(),
                    ),
                  );
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "crise".tr,
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            /*Container(
              height: 80.0,
              width: 170,
              margin: EdgeInsets.only(),
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Crisede nerfs");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CriseDeNerfs()),
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
                      "crise".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(
              height: 15,
            ),
            Container(
              height: 65,
              width: 270,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("MalaiseDiabetique");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MalaiseDiabetique(),
                    ),
                  );
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "malDiab".tr,
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            /*Container(
              height: 80.0,
              width: 170,
              margin: EdgeInsets.only(),
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("MalaiseDiabetique");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MalaiseDiabetique()),
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
                      "malDiab".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(
              height: 15,
            ),
            Container(
              height: 65,
              width: 270,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MalaiseCardiaque()),
                  );
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "malCard".tr,
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            /*Container(
              height: 80.0,
              width: 170,
              margin: EdgeInsets.only(),
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Malaise Cardiaque");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MalaiseCardiaque()),
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
                      "malCard".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
