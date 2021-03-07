import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Profil"),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image(
                  image: AssetImage(
                    "assets/profil.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 95),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Nom et prénom",
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(10),
                                      title: LiteRollingSwitch(
                                        value: true,
                                        textOn: 'disponible',
                                        textOff: 'indisponible',
                                        colorOn: Colors.green[700],
                                        colorOff: Colors.red[700],
                                        iconOn: Icons.notifications_active,
                                        iconOff: Icons.notifications_off,
                                        textSize: 18.0,
                                        onChanged: (bool position) {
                                          print("the button is $position");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/profil.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("À propos"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Numéro"),
                            subtitle: Text("99822080"),
                            leading: Icon(Icons.call),
                          ),
                          ListTile(
                            title: Text("Sexe"),
                            subtitle: Text("femme"),
                            leading: Icon(Icons.person_sharp),
                          ),
                          ListTile(
                            title: Text("Age"),
                            subtitle: Text("22"),
                            leading: Icon(Icons.format_align_center),
                          ),
                          ListTile(
                            title: Text("Gouvernorat"),
                            subtitle: Text("Ariana"),
                            leading: Icon(Icons.place),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
