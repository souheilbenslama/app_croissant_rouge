import 'package:flutter/material.dart';

class PageAlerte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        actions: [
          // Used the actions to have the icons of the "App Bar" aligned in the same line
          IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          Container(
            // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
            width: 360,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // space between to keep a certain space between the children of the Column
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Image.asset(
              'assets/logo.jpg',
              width: 150,
              height: 150,
            ),
          ),
          RaisedButton(
            color: Colors.redAccent[700],
            onPressed: () {},
            child: Text(
              'Alerter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 80,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.black),
            ),
          ),
          Container(
            width: 410,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Contacter-nous',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Documentation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
