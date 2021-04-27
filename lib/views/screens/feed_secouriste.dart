import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../services/accident.dart';
import 'package:flutter/material.dart';

class FeedSecouriste extends StatefulWidget {
  @override
  _FeedSecouristeState createState() => _FeedSecouristeState();
}

class _FeedSecouristeState extends State<FeedSecouriste> {
  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      //PopMenuButton because we need a menu for the settings
      icon: Icon(
        Icons.settings,
        color: Colors.white70,
        size: 35,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          child: FlatButton(
            onPressed: null,
            child: Text(
              "Langue",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        actions: [
          // Used the actions to have the icons of the "App Bar" aligned in the same line
          Container(
            // Used the container because i want the other 2 icons in the end and since i used .start for previous row i'll be applied automatically to the others
            width: 360,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /* if (isAdmin())
                        IconButton(
                          // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                          onPressed: () {
                            Navigator.of(context).pushNamed('/dashboard');
                          },
                          iconSize: 35,
                          icon: Icon(
                            Icons.dashboard,
                            color: Colors.white70,
                          ),
                        ),*/
                IconButton(
                  // This icon button when pressed it'll take as to the signin or to the profile page if the secouriste is connected
                  onPressed: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );*/
                  },
                  iconSize: 35,
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  // The padding contains the the settings icon and its functions : PopUpMenuButton
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    bottom: 4.0,
                  ),
                  child: popupMenuButton(),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween, // space between to keep a certain space between the children of the Column
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Image.asset(
                'assets/logo.jpg',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            Container(
              height: 50.0,
              width: 140.0,
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/publicmap',
                      arguments: AccidentService.getInProgressInterventions());
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Voir Map",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 180.0,
              margin: EdgeInsets.all(20),
              child: LiteRollingSwitch(
                value: true,
                textOn: "Disponible",
                textOff: "Non Disponible",
                colorOn: Colors.green,
                colorOff: Colors.redAccent[700],
                iconOn: Icons.done,
                iconOff: Icons.alarm_off,
                textSize: 18.0,
                onChanged: (bool position) {
                  print("The button is $position");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
