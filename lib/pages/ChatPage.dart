import 'package:app/customUI/CustomCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel("jinhan", "person.svg", false, "5:00", "hello android"),
    ChatModel("jinhan1", "person.svg", true, "6:00", "hello ios"),
    ChatModel("jinhan2", "person.svg", false, "7:00", "hello flutter"),
    ChatModel("jinhan3", "person.svg", true, "8:00", "hello node"),
    ChatModel("jinhan4", "person.svg", false, "9:00", "hello spring"),
  ];

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
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CustomCard(chatModel: chats[index]);
        },
      ),
    );
  }
}
