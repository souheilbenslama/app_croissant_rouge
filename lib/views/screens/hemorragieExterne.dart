import 'package:app_croissant_rouge/views/screens/listeDesCas.dart';
import 'package:app_croissant_rouge/views/screens/hemorex_oui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';
import 'package:get/get.dart';

class HemorragieExterne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            height: 0.041 * height,
          ),
          /* Text("hemExt".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 30,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.2,
              )),*/
          Text(
            "hemExt".tr,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.068,
                width: width * 0.364,
                child: RaisedButton(
                  onPressed: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("Saignement abondant visible.\n");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HemorexOui(),
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
                    "oui".tr,
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.073,
              ),
              Container(
                height: height * 0.068,
                width: width * 0.364,
                child: RaisedButton(
                  onPressed: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("Pas de saignement abondant visible.\n");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListeCas(),
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
                    "non".tr,
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
          Container(
            height: height * 0.274,
            width: height * 0.274,
            child: Image.asset(
              'assets/images/hemorragie.png',
            ),
          ),
        ],
      ),
    );
  }
}
