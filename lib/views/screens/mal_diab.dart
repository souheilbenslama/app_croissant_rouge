import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class MalDiab extends StatelessWidget {
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
                'Malaises diabétiques',
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
                            Text(
                                '-Donner du sucre\nou de préférence \nune boisson sucrée.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '-Aider la victime \nà s’assoir ou\nà s’allonger.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '-Recueillir \ndes informations \nsur l’état de santé.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text(
                                '-Demandez un \navis médical \n(appeler le 190).',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/sugar.png',
                              height: 120,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Image.asset(
                              'assets/images/allongez.png',
                              height: 120,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Image.asset(
                              'assets/images/tal.png',
                              height: 120,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Image.asset(
                              'assets/images/phone.png',
                              height: 120,
                              width: 200,
                            ),
                          ])
                    ]),
              )),
        ));
  }
}
