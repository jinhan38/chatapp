import 'package:app/customUI/ButtonCard.dart';
import 'package:app/customUI/ContactCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:app/screens/CreateGroup.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
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
    List<ChatModel> contacts = [
      ChatModel("jinhan", "assets/person.svg", false, "2022-09-29",
          "App developer", "App developer"),
      ChatModel("jinhan1", "assets/person.svg", false, "2022-09-29",
          "App developer", "App developer1"),
      ChatModel("jinhan2", "assets/person.svg", false, "2022-09-29",
          "App developer", "App developer2"),
      ChatModel("jinhan3", "assets/person.svg", false, "2022-09-29",
          "App developer", "App developer3"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "255Contacts",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('value : $value');
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CreateGroup();
                    },
                  ));
                },
                child: ButtonCard(name: "New group", icon: Icons.group));
          } else if (index == 1) {
            return ButtonCard(name: "New Contact", icon: Icons.person_add);
          }
          return ContactCard(chatModel: contacts[index - 2]);
        },
      ),
    );
  }
}
