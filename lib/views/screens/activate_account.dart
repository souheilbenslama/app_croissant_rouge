import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("herehere123");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent[700],
        title: Text('activerCompte'.tr),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(
                builder: (BuildContext context) => new PageAlerte(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
              right: 20.0,
              left: 20.0,
              top: 30.0,
            ),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ecrireCode'.tr,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "valider".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      /* Row(
        children: <Widget>[
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ecrire votre Code',
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Valider'),
          ),
        ],
      ),*/
    );
  }
}
