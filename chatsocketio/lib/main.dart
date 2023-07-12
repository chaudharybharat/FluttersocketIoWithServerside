import 'package:flutter/material.dart';
import 'create_room_chat_screen.dart';
import 'socket_connection.dart';

void main() async {
  //init socket connection
  SocketService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket IO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateRoomChatScreen(),
    );
  }
}
