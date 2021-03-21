import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListeInterventions extends StatefulWidget {
  @override
  _ListeInterventionsState createState() => _ListeInterventionsState();
}

class _ListeInterventionsState extends State<ListeInterventions> {
  final secouristes = [
    "Polly Blair",
    "Eleanor Leonard",
    "Sydney Ramos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Liste des Interventions"),
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
                      "Intervention de " + secouristes[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Ariana",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[800],
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
