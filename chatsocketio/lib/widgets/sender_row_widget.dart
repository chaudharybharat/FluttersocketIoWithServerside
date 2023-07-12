import 'package:flutter/material.dart';
import '../main.dart';
import '../model/chat_model.dart';

class SenderRowWidget extends StatelessWidget {
  const SenderRowWidget({Key? key, required this.chatModel}) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
      ),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffD11C2D),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            chatModel.message ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: const Padding(
        padding: EdgeInsets.only(right: 8, top: 4),
        child: Text(
          '10:03 AM',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 10),
        ),
      ),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
      ),
    );
  }
}
