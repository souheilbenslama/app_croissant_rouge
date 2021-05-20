import 'package:app_croissant_rouge/services/user_service.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/widgets/rating.dart';
import 'package:flutter/material.dart';

class AppRatingBox extends StatefulWidget {
  String userId;
  AppRatingBox(this.userId);
  @override
  _AppRatingBoxState createState() => _AppRatingBoxState();
}

class _AppRatingBoxState extends State<AppRatingBox> {
  int _rating;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: EdgeInsets.all(40.0),
        margin: EdgeInsets.all(20.0),
        height: 200,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo croissant rouge
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/profil.png',
                  height: 80,
                  width: 100,
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.redAccent[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Column(children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'NOTER APP',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Rating((rating) {
                    setState(() {
                      _rating = rating;
                    });
                  }, 5),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      UserService.attemptRateApp(this.widget.userId, _rating);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageAlerte()));
                    },
                    child: Text('Soumettre'),
                    color: Colors.white,
                    textColor: Colors.redAccent[100],
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ]))
          ],
        ));
  }
}
