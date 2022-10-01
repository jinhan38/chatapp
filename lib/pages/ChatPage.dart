import 'package:app/customUI/CustomCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:app/screens/SelectContact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  ChatPage({
    required this.chatModels,
    required this.sourceChat,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SelectContact();
            },
          ));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (context, index) {
          return CustomCard(
            chatModel: widget.chatModels[index],
            sourceChat: widget.sourceChat,
          );
        },
      ),
    );
  }
}
