import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/reset_password.dart';
import 'package:app_croissant_rouge/services/login_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ResetCode extends StatefulWidget {
  @override
  _ResetCodeState createState() => _ResetCodeState();
}

class _ResetCodeState extends State<ResetCode> {
  String errormessage;
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _codeController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent[700],
        title: Text("code de réinitialisation"),
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
                controller: _codeController,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 0.9),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Ecrire votre code',
                  labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: myFocusNode.hasFocus ? Colors.red : Colors.grey),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                var res =
                    await LoginServiceImp().verifycode(_codeController.text);
                if (res.statusCode == 200) {
                  var token = jsonDecode(res.body)['token'];

                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => ResetPassword(token)));
                } else {
                  setState(() {
                    errormessage = res.body;
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
                    "Verifier Code ",
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
