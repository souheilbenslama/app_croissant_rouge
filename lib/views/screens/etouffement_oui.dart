import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class EtoufOui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent[700],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            title: Center(
              child: Text(
                'Etouffement',
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('-Ne pas toucher \nla victime, \n ni la frapper.',
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[600])),
                    SizedBox(
                      height: 24,
                    ),
                    Text('-Encourager \nla victime\nà tousser.',
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[600])),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                        '-Faire asseoir \nla victime \ntête penchée \nen avant.',
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[600])),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                        '-Surveiller \nla victime  \net parler \navec elle \nrégulièrement.',
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[600])),
                    SizedBox(
                      height: 24,
                    ),
                    Text('                    .',
                        style: TextStyle(fontSize: 20)),
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/chokingga2.png',
                        height: 170, width: 200),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'assets/images/chokingga11.png',
                      height: 170,
                      width: 200,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'assets/images/chokingga3.png',
                      height: 170,
                      width: 200,
                    ),
                  ])
            ]),
          )),
    );
  }
}
