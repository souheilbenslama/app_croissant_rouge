import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/widgets/rating.dart';
import 'package:flutter/material.dart';

class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: EdgeInsets.all(40.0),
            margin: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 1.3,
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
                        'NOTE DE SECOURISTE',
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text('Soumettre'),
                              color: Colors.white,
                              textColor: Colors.redAccent[100],
                            ),
                            RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text('Annuler'),
                              color: Colors.white,
                              textColor: Colors.redAccent[100],
                            )
                          ]),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                    ]))
              ],
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.width * 0.8,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: ClipRRect(
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
