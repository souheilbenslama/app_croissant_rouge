import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class BrulureSimple extends StatelessWidget {
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
                'Brûlure simple',
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
                              height: MediaQuery.of(context).size.height * 0.18,
                            ),
                            Text(
                                '-Poursuivre le \nrefroidissement \navec de l’eau, \njusqu’à \ndisparition \nde la douleur.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '- Protéger la brûlure \npar un pansement \nstérile.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.18,
                            ),
                            Image.asset(
                              'assets/images/clean.png',
                              height: 150,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Image.asset(
                              'assets/images/compress.png',
                              height: 150,
                              width: 200,
                            ),
                          ])
                    ]),
              )),
        ));
  }
}
