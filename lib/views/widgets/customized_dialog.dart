import 'package:flutter/material.dart';

class CustomizedDialog extends StatelessWidget {
  final title;
  CustomizedDialog(this.title);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        // to have a rounded Dialog box
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        // Container to specify the height of the dialog
        height: 225,
        child: Column(
          children: <Widget>[
            Expanded(
              // Call Icon
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
                  //a box that will become as large as its parent allows: the container.
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      // Column to contain our Text and our Button
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
                            // To have a rounded button
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          onPressed: () {
                            // When pressed on the button okay you'll go back to the last page => alert page
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
