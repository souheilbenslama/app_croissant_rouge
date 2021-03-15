import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class Socket {
  // Dart client

  void connect() {
    IO.Socket socket = IO.io('http://192.168.43.68:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect().onConnect((data) => print("connected"));
    socket.on('message', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }
}
