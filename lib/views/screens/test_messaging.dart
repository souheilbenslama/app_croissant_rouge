import 'package:app_croissant_rouge/services/socket_service.dart';
import 'package:flutter/material.dart';

class MessageTest extends StatefulWidget {
  @override
  _MessageTestState createState() => _MessageTestState();
}

class _MessageTestState extends State<MessageTest> {
  TextEditingController message = TextEditingController(text: "message");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(controller: TextEditingController(text: "chatId")),
        TextField(controller: message),
        RaisedButton(
          color: Color.fromRGBO(226, 56, 50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            SocketService.connect();
          },
          child: Text("connect"),
        ),
        RaisedButton(
          color: Color.fromRGBO(226, 56, 50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            SocketService.sendMessage("AZE", message.text, "");
          },
          child: Text("send"),
        ),
        RaisedButton(
          color: Color.fromRGBO(226, 56, 50, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          onPressed: () {
            SocketService.disconnect();
          },
          child: Text("disConnect"),
        )
      ],
    ));
  }
}
