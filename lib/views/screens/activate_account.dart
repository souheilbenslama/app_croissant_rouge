import 'package:flutter/material.dart';

class ActivateAccount extends StatelessWidget {
  String verifCode;
  ActivateAccount(this.verifCode);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("Liste des Interventions"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Center(
          child: Row(
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ecrire votre Code',
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
