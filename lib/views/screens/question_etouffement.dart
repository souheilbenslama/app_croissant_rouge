import 'package:app_croissant_rouge/views/screens/etouffement_oui.dart';
import 'package:app_croissant_rouge/views/screens/etouffement_non.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../accidentProvider.dart';
import 'package:get/get.dart';

class Etouffement extends StatelessWidget {
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
          SizedBox(height: height * 0.05),
          Padding(
            padding: const EdgeInsets.only(),
            child: Image.asset(
              'assets/profil.png',
              width: height * 0.205,
              height: height * 0.205,
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "etouffQuest".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 30,
                //fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 2.2),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 150,
                child: RaisedButton(
                  onPressed: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("La victime tousse ou émet un son.\n");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EtoufOui()));
                  },
                  color: Colors.redAccent[700],
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "oui".tr,
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 50,
                width: 150,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EtoufNon()),
                    );
                  },
                  color: Colors.redAccent[700],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "non".tr,
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: height * 0.274,
            width: height * 0.274,
            child: Image.asset('assets/images/sneez1g.png'),
          ),
        ],
      ),
    );
  }
}
