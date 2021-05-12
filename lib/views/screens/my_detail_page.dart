import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';

class Details extends StatelessWidget {
  final Instruction instruction;
  Details({@required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent[700],
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              ClipRRect(
                  child: Hero(
                tag: 'case-img-${instruction.img}',
                child: Image.asset(
                  'assets/images/${instruction.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              )),
              SizedBox(height: 30),
              ListTile(
                title: Text(instruction.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey[800])),
              ),
              Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('${instruction.steps}',
                      style: TextStyle(
                          color: Colors.grey[600], height: 1.4, fontSize: 18))),
            ],
          ),
        ));
  }
}
