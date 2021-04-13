import 'package:flutter/material.dart';

import 'Instruction.dart';

class MyDetailPage extends StatefulWidget {
  Case _cas;

  MyDetailPage(Case cas) {
    _cas = cas;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_cas);
}

class _MyDetailPageState extends State<MyDetailPage> {
  Case cas;

  _MyDetailPageState(Case cas) {
    this.cas = cas;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(cas.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: cas,
            child: Transform.scale(
              scale: 2.0,
              child: Image.asset(cas.img),
            ),
          ),
          Card(
              elevation: 8,
              margin: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(cas.body),
              )),
        ],
      )),
    );
  }
}
