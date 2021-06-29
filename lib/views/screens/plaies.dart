import 'package:app_croissant_rouge/views/screens/plaies_grave.dart';
import 'package:app_croissant_rouge/views/screens/plaies_simples.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class Plaies extends StatelessWidget {
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
                'assets/profil.png',
                width: height * 0.205,
                height: height * 0.205,
              ),
            ),
            SizedBox(
              height: height * 0.109,
            ),
            Text(
              "plaieQuest".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 30,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(
              height: 0.055 * height,
            ),
            Container(
              height: height * 0.068,
              width: width * 0.657,
              child: RaisedButton(
                onPressed: () {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Plaie simple.\n");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaiesSimples(),
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
                  "plaieSimple".tr,
                  style: TextStyle(
                      fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.021,
            ),
            Container(
              height: height * 0.068,
              width: width * 0.657,
              child: RaisedButton(
                onPressed: () async {
                  final doc =
                      Provider.of<AccidentProvider>(context, listen: false);
                  doc.setCas("Plaie grave.\n");

                  const number = '198';

                  FlutterPhoneDirectCaller.callNumber(number);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaiesGraves(),
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
                  "plaieGrave".tr,
                  style: TextStyle(
                      fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: height * 0.246,
              width: height * 0.246,
              child: Image.asset(
                'assets/images/plaie.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
