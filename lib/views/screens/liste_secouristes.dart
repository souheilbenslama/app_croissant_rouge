import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/views/screens/intervention_par_secouriste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ListeSecouristes extends StatefulWidget {
  final secouristes;
  ListeSecouristes({Key key, @required this.secouristes}) : super(key: key);
  @override
  _ListeSecouristesState createState() => _ListeSecouristesState();
}

class _ListeSecouristesState extends State<ListeSecouristes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeSec".tr),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: widget.secouristes.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InterventionParSecouriste(
                        secouriste: widget.secouristes[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Text(
                    widget.secouristes[index].name.toString(),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        letterSpacing: 0.3,
                        height: 1.3),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
