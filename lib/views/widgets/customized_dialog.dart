import 'package:flutter/material.dart';

class CustomizedDialog extends StatelessWidget {
  final title;
  CustomizedDialog(this.title);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 225,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white70,
                child: Icon(
                  Icons.call,
                  size: 60,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.redAccent[700],
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            10,
                          )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Okay',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
