import 'dart:convert';

import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/secouriste.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
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

      socket.on(
          'alerte',
          (data) =>
              print("good job souheil ***********************************"));
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
