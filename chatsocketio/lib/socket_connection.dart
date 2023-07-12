import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService instance = SocketService._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory SocketService() {
    return instance;
  }
  SocketService._internal() {
    // initialization logic
    debugPrint("======initialization=socket======");
    if (socket == null) {
      debugPrint("======find===null===socket======");
      createSocketConnection();
    }
  }
  IO.Socket? socket;

  createSocketConnection() {
    socket = IO.io(
        'http://192.168.1.33:8080',
        OptionBuilder()
            .disableAutoConnect()
            .enableForceNew()
            .setTransports(['websocket', 'polling'])
            //.setTimeout(200000)
            .build());
    socket!.connect();
    socket!.onConnectError((error) {
      debugPrint('onConnectError ' + error.toString());
    });
    socket!.onConnect((data) {
      debugPrint('connect' + data.toString());
    });
  }
}
