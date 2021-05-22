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
              height: 0.055 * height,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Image.asset(
                'assets/logo.jpg',
                width: 0.205 * height,
                height: 0.205 * height,
              ),
            ),
            SizedBox(
              height: 0.055 * height,
            ),
            Text(
              "casPoss".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 30,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 0.041 * height,
            ),
            Container(
              height: 0.068 * height,
              width: 0.560 * width,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Malaise");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Malaise(),
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
                  "malaise".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.014 * height,
            ),
            Container(
              height: 0.068 * height,
              width: 0.560 * width,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Hemorragie Externe");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HemorragieExterne(),
                    ),
                  );
                },
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(horizontal: width * 0.121),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "hemoExt".tr,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.014 * height,
            ),
            Container(
              height: 0.068 * height,
              width: 0.560 * width,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Plaies");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Plaies(),
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
                  "Plaies".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.014 * height,
            ),
            Container(
              height: 0.068 * height,
              width: 0.560 * width,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Brulure");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Brulure(),
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
                  "brulure".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.014 * height,
            ),
            Container(
              height: 0.068 * height,
              width: 0.560 * width,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Fracture");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListeCas(),
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
                  "Fractures".tr,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2.2,
                    color: Colors.white,
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
