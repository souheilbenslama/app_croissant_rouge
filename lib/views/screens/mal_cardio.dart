import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class MalCardio extends StatelessWidget {
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
                'Malaises cardiaques',
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
                                '-Mettez la victime \nimmédiatement \nau repos absolu \n(assise, semi-assise).',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text('-Lui faire \nprendre son \ntraitement.',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Text('-Alertez et \nsurveillez la victime.',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Image.asset(
                              'assets/images/sit.png',
                              height: 120,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Image.asset(
                              'assets/images/drugs.png',
                              height: 100,
                              width: 200,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Image.asset(
                              'assets/images/surv.png',
                              height: 140,
                              width: 200,
                            ),
                          ])
                    ]),
              )),
        ));
  }
}
