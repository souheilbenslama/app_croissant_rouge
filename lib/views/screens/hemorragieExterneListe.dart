// Khalil
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../accidentProvider.dart';

class HemorragieExterneListe extends StatefulWidget {
  @override
  _HemorragieExterneListeState createState() => _HemorragieExterneListeState();
}

class _HemorragieExterneListeState extends State<HemorragieExterneListe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //APPBAR
        appBar: AppBar(
          title: Center(child: Text("Liste des cas")),
          backgroundColor: Colors.redAccent[700],
        ),
        //BODY
        body: Container(
            child: Container(
          child: new StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: <Widget>[
              Card(color: Colors.white, child: Image.asset("assets/logo.jpg")),
              //FIRST CARD
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("Hémorragie au travers d'un plaie.\n");
                  },
                  child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Image.asset("assets/saigne.png")),
                          Text(
                            "\nHémorragie au travers d’un plaie",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
              ),
              //2ND CARD
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("La victime vomit ou crache du sang.\n");
                  },
                  child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Image.asset("assets/vomit.png")),
                          Text(
                            "\nLa victime vomit ou crache du sang",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
              ),
              //3rd CARD
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription("La victime saigne du nez.\n");
                  },
                  child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Image.asset("assets/saigneNez.jpg")),
                          Text(
                            "\nLa victime saigne du nez",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
              ),
              //4th CARD
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    final doc =
                        Provider.of<AccidentProvider>(context, listen: false);
                    doc.setDescription(
                        "La victime perd du sang d'un orifice naturel.\n");
                  },
                  child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Image.asset(
                                "assets/orifice.jpg",
                              )),
                          Text(
                            "\nLa victime perd du sang d’un orifice naturel",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
              ),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 130),
              StaggeredTile.extent(1, 300.0),
              StaggeredTile.extent(1, 300.0),
              StaggeredTile.extent(1, 300.0),
              StaggeredTile.extent(1, 300.0),
            ],
          ),
        )));
  }
}
