import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_screen.dart';
import 'socket_connection.dart';

class CreateRoomChatScreen extends StatefulWidget {
  const CreateRoomChatScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomChatScreen> createState() => _CreateRoomChatScreenState();
}

class _CreateRoomChatScreenState extends State<CreateRoomChatScreen> {
  TextEditingController joinIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Room"),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text("Enter room id"),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: joinIdController,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,
                        //make hint text
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        //create lable
                        labelText: 'Enter room id',
                        //lable style
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          IO.Socket? socket = SocketService.instance.socket;
                          String roomId = joinIdController.text.trim();
                          if (socket != null && roomId.isNotEmpty) {
                            socket!.emit('createRoom', roomId);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        roomId: roomId,
                                      )),
                            );
                            joinIdController.clear();
                          } else {
                            debugPrint("socket find null or empty room id");
                          }
                        },
                        child: const Text("Create Room"))),
              ],
            )));
  }
}
