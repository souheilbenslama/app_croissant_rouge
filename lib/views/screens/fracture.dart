import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class Fracture extends StatelessWidget {
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
                'Fracture',
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            '-Immobilisation \ndu membre \nsupérieur \npar une écharpe',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)),
                        SizedBox(
                          height: 24,
                        ),
                        Image.asset('assets/images/memsup1.png',
                            height: 200, width: 200),
                      ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Material(child: Text('--------------------')),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            '-Immobilisation \nimprovisée du \nmembre inférieur',
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)),
                        SizedBox(
                          height: 24,
                        ),
                        Image.asset('assets/images/meminf1.png',
                            height: 200, width: 200),
                      ])
                ]),
          )),
        ));
  }
}
