import 'package:app/customUI/AvatarCard.dart';
import 'package:app/customUI/ButtonCard.dart';
import 'package:app/customUI/ContactCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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

  List<ChatModel> groups = [];

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
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
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
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 10,
                );
              }
              return InkWell(
                  onTap: () {
                    setState(() {
                      if (!contacts[index - 1].selected) {
                        contacts[index - 1].selected = true;
                        groups.add(contacts[index - 1]);
                      } else {
                        contacts[index - 1].selected = false;
                        groups.remove(contacts[index - 1]);
                      }
                    });
                  },
                  child: ContactCard(chatModel: contacts[index - 1]));
            },
          ),
          groups.length == 0
              ? Container()
              : Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].selected == true) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    groups.remove(contacts[index]);
                                    contacts[index].selected = false;
                                  });
                                },
                                child: AvatarCard(chatModel: contacts[index]));
                          }
                          return Container();
                        },
                      ),
                    ),
                    Divider(thickness: 1)
                  ],
                ),
        ],
      ),
    );
  }
}
