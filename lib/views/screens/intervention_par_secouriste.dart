import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class InterventionParSecouriste extends StatefulWidget {
  @override
  _InterventionParSecouristeState createState() =>
      _InterventionParSecouristeState();
}

class _InterventionParSecouristeState extends State<InterventionParSecouriste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeInter".tr),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 3,
              child: ListTile(
                title: Column(
                  children: [
                    Text(
                      "ariana".tr,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
