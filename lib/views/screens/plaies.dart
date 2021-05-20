import 'package:app_croissant_rouge/views/screens/hemorragieExterne.dart';
import 'package:flutter/material.dart';

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
            Text("La gravité de la plaie est ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2.2,
                )),
            SizedBox(
              height: 0.055 * height,
            ),
            Container(
              height: height * 0.068,
              width: width * 0.608,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Plaie simple",
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
              width: width * 0.608,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.redAccent[700],
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.121,
                ),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Plaie grave",
                  style: TextStyle(
                      fontSize: 25, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
