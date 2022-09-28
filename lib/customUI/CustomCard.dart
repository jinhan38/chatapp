import 'package:app/model/ChatModel.dart';
import 'package:app/screens/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  CustomCard({required this.chatModel, Key? key}) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => IndividualPage(chatModel: chatModel)),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(chatModel.name),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 3),
                Text(chatModel.currentMessage),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
              padding: EdgeInsets.only(right: 20, left: 80),
              child: Divider(thickness: 1))
        ],
      ),
    );
  }
}
