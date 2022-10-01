import 'package:app/customUI/ButtonCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:app/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;

  List<ChatModel> chats = [
    ChatModel("김진한", "person.svg", false, "5:00", "hello android", "", id: 1),
    ChatModel("함혜원", "person.svg", true, "6:00", "hello ios", "", id: 2),
    ChatModel("김보윤", "person.svg", false, "7:00", "hello flutter", "", id: 3),
    ChatModel("황인준", "person.svg", true, "8:00", "hello node", "", id: 4),
    ChatModel("이지용", "person.svg", false, "9:00", "hello spring", "", id: 5),
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
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              sourceChat = chats.removeAt(index);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(
                    chatModels: chats,
                    sourceChat: sourceChat,
                  );
                },
              ));
            },
            child: ButtonCard(name: chats[index].name, icon: Icons.person),
          );
        },
      ),
    );
  }
}
