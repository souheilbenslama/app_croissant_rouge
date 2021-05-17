import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class PlaiesSimples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChatScreen();
                  })
            },
            tooltip: 'Increment',
            backgroundColor: Colors.red,
            child: Icon(Icons.messenger),
          ),
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
                'Plaies simples',
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Text('-Se laver les mains \nà l’eau et au savon.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text('-Nettoyer la plaie \navec de l’eau.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '-Désinfecter la plaie \navec un antiseptique.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text('-Protéger par un \npansement adhésif.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '-Vérifier l’existence \nd’une vaccination \nantitétanique \nen cours de validité.',
                                style: TextStyle(fontSize: 20)),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/wash.png',
                              height: 80,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Image.asset(
                              'assets/images/clean.png',
                              height: 100,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Image.asset(
                              'assets/images/anticeptic.png',
                              height: 100,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/compress.png',
                              height: 90,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Image.asset(
                              'assets/images/vacc.png',
                              height: 100,
                              width: 200,
                            ),
                          ])
                    ]),
              )),
        ));
  }
}
