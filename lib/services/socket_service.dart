import 'dart:convert';
import 'package:app_croissant_rouge/locator.dart';
import 'package:app_croissant_rouge/services/navigation_service.dart';
import 'package:app_croissant_rouge/services/notificationManager.dart';
import 'package:app_croissant_rouge/views/widgets/notification_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/secouriste.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static bool status = true;
  static IO.Socket socket =
      IO.io('http://192.168.43.68:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  // Dart client
  static void connect() {
    print("done");
    socket.connect().onConnect((data) async {
      print(socket.id);
      updateRescuerSocketId(socket.id);

      socket.on('chat', (data) {
        String message = jsonDecode(jsonEncode(data))["message"];
        print(message);
      });

      socket.on('alerte', (data) async {
        print("good job souheil ***********************************");

        BotToast.showCustomNotification(
            enableSlideOff: true,
            duration: Duration(seconds: 30),
            toastBuilder: (_) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/emergency.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Emergency Alert',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Localisation : Cite Olympique MG',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hemorragie: ........',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Conscience: ........',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Respiration: ........',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                BotToast.cleanAll();
                              },
                              child: Text('Decline'),
                              color: Colors.redAccent[700],
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              onPressed: () {
                                BotToast.cleanAll();
                                final NavigationService _navigationService =
                                    locator<NavigationService>();
                                _navigationService.navigateTo("/map");
                              },
                              child: Text('Accept'),
                              color: Colors.green,
                              textColor: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            });
        if (!status) {
          await notificationManager.showNotification();
        }
        /*BotToast.showAttachedWidget(
            attachedBuilder: (_) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
            duration: Duration(seconds: 2),
            target: Offset(520, 520));*/
      });
    });

    socket.onDisconnect((_) async {
      print("disconnected" + socket.id);
      await updateRescuerSocketId("");
    });

    socket.on('fromServer', (_) => print(_));
  }

  static void alerter() {
    socket.emit("alerte", {"messsage": "hello"});
  }

  static void disconnect() {
    print("disconnected");
    socket.disconnect().onDisconnect((data) async {
      updateRescuerSocketId("AAA");
    });
  }

  static void acceptIntervention(secouristeId, accidentId) {
    socket.emit(
        "accept", {"secouristeId": secouristeId, "accidentId": accidentId});
  }

  static void sendMessage(accidentId, message, userId) {
    socket.emit("chat", {
      "messsage": message,
      "senderId": "608c65ad52b1a01bf0ddb9fb",
      "chatId": "6048839aa564a24a5c72df5c"
    });
  }
}
