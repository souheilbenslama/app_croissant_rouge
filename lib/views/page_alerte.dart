import 'package:flutter/material.dart';

class PageAlerte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text('Alert Page'),
      ),
      backgroundColor: Colors.redAccent[700],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/logo1.png',
                    width: 130,
                    height: 65,
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    onPressed: null,
                  ),
                  Container(
                    width: 230,
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
            ),
          ),
          RaisedButton(
              color: Colors.red[50],
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
                  side: BorderSide(color: Colors.black))),
          Container(
            width: 410,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Contacter-nous',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Documentation',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
