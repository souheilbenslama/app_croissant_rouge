import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/user_model.dart';
import 'package:app_croissant_rouge/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sentMessage;
  final _textController = TextEditingController();
  //socket
  /*void initState() {
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      'http://192.168.43.68:3000',
      '/',
    );
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      this.setState(() => messages.add(data['message']));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
  }*/

  //Message
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.09,
      margin: isMe
          ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0),
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
            Expanded(
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
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Message message = messages[index];

                          final bool isMe = message.sender.id == currentUser.id;
                          return _buildMessage(message, isMe);
                        }),
                  )),
            ),
            _buildMessageComposer(() {
              setState(() {
                messages = [
                  Message(sender: yui, text: sentMessage),
                  ...messages,
                ];
                _textController.clear();
              });
            })
          ],
        ),
      ),
    );
  }
}
