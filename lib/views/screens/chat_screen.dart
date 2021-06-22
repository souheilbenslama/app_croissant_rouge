import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/services/socket_service.dart';
import 'package:app_croissant_rouge/models/message_model.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String accidentId;
  ChatScreen(this.userId, this.accidentId);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sentMessage;

  final _textController = TextEditingController();

  //Message
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.09,
      margin: isMe
          ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: isMe
          ? //the UI if you are the sender
          BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            )
          : //the UI if you are the receiver
          BoxDecoration(
              color: Color(0xFFe4f1fe),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8.0,
          ),
          Text(message.text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return msg;
  }

  _buildMessageComposer(Function f) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                sentMessage = value;
              },
              decoration: InputDecoration(hintText: 'message..'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.red.shade400,
            onPressed: f,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Consumer<AccidentProvider>(builder: (context, value, child) {
              return Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.only(top: 14.0),
                          itemCount: value.messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Message message = value.messages[index];

                            final bool isMe = value.messages[index].senderId ==
                                this.widget.userId;
                            return _buildMessage(message, isMe);
                          }),
                    )),
              );
            }),
            _buildMessageComposer(() {
              if (sentMessage != null) {
                Message mess = Message(
                    senderId: this.widget.userId,
                    text: sentMessage,
                    time: DateTime.now().toString());
                var prov =
                    Provider.of<AccidentProvider>(context, listen: false);
                prov.addMessage(mess);
                SocketService.sendMessage(prov.currentAccident.id, mess);
                sentMessage = null;
              }
              setState(() {
                _textController.clear();
              });
            })
          ],
        ),
      ),
    );
  }
}
