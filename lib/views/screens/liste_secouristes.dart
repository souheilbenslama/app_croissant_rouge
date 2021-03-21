import 'package:flutter/material.dart';

class ListeSecouristes extends StatefulWidget {
  @override
  _ListeSecouristesState createState() => _ListeSecouristesState();
}

class _ListeSecouristesState extends State<ListeSecouristes> {
  final secouristes = [
    "Polly Blair",
    "Eleanor Leonard",
    "Sydney Ramos",
    "Georgia Miller",
    "Austin Miller",
    "Paul Mayor",
    "John Doe",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Liste des Secouristes"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: secouristes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/interventionParSecouriste');
              },
              child: Card(
                color: Colors.white,
                elevation: 3,
                child: ListTile(
                  title: Text(
                    secouristes[index],
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
