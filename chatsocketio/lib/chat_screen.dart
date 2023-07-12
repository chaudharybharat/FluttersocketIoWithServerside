import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model/chat_model.dart';
import 'socket_connection.dart';
import 'widgets/receiver_row_widget.dart';
import 'widgets/sender_row_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.roomId});
  String roomId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();
  List<ChatModel> chatModelList = [];
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';
  @override
  void initState() {
    chatModelList = [];
    socket = SocketService().socket;
    _connectSocketIO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket IO"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: chatModelList.length,
                itemBuilder: (context, index) =>
                    chatModelList[index].receiverId == "1"
                        ? SenderRowWidget(
                            chatModel: chatModelList[index],
                          )
                        : ReceiverRowWidget(chatModel: chatModelList[index]),
              )),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0, left: 8),
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Color(0xffD11C2D),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, right: 10),
                  child: Transform.rotate(
                    angle: 45,
                    child: const Icon(
                      Icons.attachment_outlined,
                      color: Color(0xffD11C2D),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    String message = controller.text.trim();
                    if (socket != null && message.isNotEmpty) {
                      String roomId = widget.roomId;
                      ChatModel chatModel = ChatModel();
                      chatModel.roomId = roomId;
                      chatModel.message = message;
                      chatModel.receiverId = "2";
                      chatModel.senderId = "1";
                      String map = jsonEncode(chatModel);
                      debugPrint("====send data===${map}======");
                      socket!.emit('chatmessage', map);
                      controller.clear();
                    }
                  },
                  onLongPress: () {
                    setState(() {
                      animateList();
                      controller.clear();
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffD11C2D),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void animateList() {
    if (chatModelList.isNotEmpty &&
        chatModelList.length > 2 &&
        scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (scrollController.offset !=
            scrollController.position.maxScrollExtent) {
          animateList();
        }
      });
    }
  }

  void _connectSocketIO() {
    try {
      /*     socket = IO.io(
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
      });*/

      socket!.on("getMessage",
          (data) => {debugPrint("=====getMessage==${data}=====")});
      socket!.on("chatmessage", (data) {
        // var detail = jsonEncode(data);
        // var encodedString = jsonEncode(data);

        Map<String, dynamic> valueMap = json.decode(data);

        ChatModel user = ChatModel.fromJson(valueMap);
        chatModelList.add(user);
        animateList();
        if (mounted) {
          setState(() {});
        }
        debugPrint("=====chatmessage==${data}=====");
      });
      //When an event recieved from server, data is added to the stream
      socket!.onDisconnect((error) => debugPrint('disconnect ' + error));
    } on SocketException catch (e) {
      print('error ${e.message}');
    } catch (error) {
      debugPrint("=error==${error}=====");
    }
  }

  @override
  void dispose() {
    if (scrollController != null) {
      scrollController.dispose();
    }
    super.dispose();
  }
}
