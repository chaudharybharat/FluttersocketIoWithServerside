import 'package:flutter/material.dart';
import '../main.dart';
import '../model/chat_model.dart';

class ReceiverRowWidget extends StatelessWidget {
  const ReceiverRowWidget({Key? key, required this.chatModel})
      : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage("https://picsum.photos/200/300"),
        ),
      ),
      title: Wrap(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            chatModel!.message ?? "",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
      trailing: Container(
        width: 50,
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(left: 8, top: 4),
        child: Text('8:04 AM', style: TextStyle(fontSize: 10)),
      ),
    );
  }
}
