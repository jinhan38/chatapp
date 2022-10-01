import 'package:app/model/ChatModel.dart';
import 'package:app/pages/CameraPage.dart';
import 'package:app/pages/ChatPage.dart';
import 'package:app/pages/StatusPage.dart';
import 'package:app/screens/CameraScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  HomeScreen({required this.chatModels, required this.sourceChat, Key? key})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);

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
        title: const Text("Whatsapp Clone"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('value : $value');
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "New Group",
                  child: Text("New Group"),
                ),
                const PopupMenuItem(
                  value: "New broadcast",
                  child: Text("New broadcast"),
                ),
                const PopupMenuItem(
                  value: "Whatsapp web",
                  child: Text("Whatsapp web"),
                ),
                const PopupMenuItem(
                  value: "Starred messages",
                  child: Text("Starred messages"),
                ),
                const PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraScreen(),
          ChatPage(
              chatModels: widget.chatModels, sourceChat: widget.sourceChat),
          StatusPage(),
          Text("aaa"),
        ],
      ),
    );
  }
}
