import 'dart:convert';

import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/services/login_service.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  String token;
  ResetPassword(this.token);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String errormessage;
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmpasswordController =
        TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent[700],
        title: Text("réinitialiser le mot de passe"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(
                builder: (BuildContext context) => new PageAlerte(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (errormessage == null)
                ? SizedBox(height: size.height / 10)
                : Container(
                    height: size.height / 10,
                    child: Center(
                      child: Text(errormessage,
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                right: 20.0,
                left: 20.0,
                top: 30.0,
              ),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                // focusNode: myFocusNode,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 0.9)),
                  border: OutlineInputBorder(),
                  labelText: 'Ecrire votre mot de passe',
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                right: 20.0,
                left: 20.0,
                top: 30.0,
              ),
              child: TextField(
                obscureText: true,
                // focusNode: myFocusNode2,
                controller: _confirmpasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 0.9),
                  ),
                  labelText: 'Confirmer votre mot de passe',
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                var res = await LoginServiceImp().resetPassword(
                    _passwordController.text,
                    _confirmpasswordController.text,
                    this.widget.token);
                if (res.statusCode == 200) {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => PageAlerte()));
                } else {
                  setState(() {
                    errormessage = jsonDecode(res.body)["errors"][0]["msg"];
                  });
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    " réinitialiser ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /* Row(
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
      ),*/
    );
  }
}
