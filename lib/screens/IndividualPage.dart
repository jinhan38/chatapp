import 'dart:convert';
import 'dart:io';

import 'package:app/customUI/OwnFileCard.dart';
import 'package:app/customUI/OwnMessageCard.dart';
import 'package:app/customUI/ReplyCard.dart';
import 'package:app/customUI/ReplyFileCard.dart';
import 'package:app/model/ChatModel.dart';
import 'package:app/model/MessageModel.dart';
import 'package:app/screens/CameraScreen.dart';
import 'package:app/screens/CameraViewPage.dart';
import 'package:camera/camera.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  IndividualPage({
    required this.chatModel,
    required this.sourceChat,
    Key? key,
  }) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  bool show = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;

  @override
  void initState() {
    connect();
    _controller = TextEditingController();
    _scrollController = ScrollController();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  void connect() {
    socket = IO.io("http://192.168.219.117:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print('socket connect success');
      socket.on("message", (msg) {
        print('msg : $msg');
        setMessage("destination", msg["message"], msg["path"]);
        if (!_scrollController.hasClients) return;
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print('소켓 : ${socket.connected}');
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    Map<String, dynamic> result = {};
    result.putIfAbsent("message", () => message);
    result.putIfAbsent("sourceId", () => sourceId);
    result.putIfAbsent("targetId", () => targetId);
    result.putIfAbsent("path", () => path);
    socket.emit(
      "message",
      result,
    );
  }

  void setMessage(String type, String message, String path) {
    var m = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        path: path);
    if (mounted) {
      setState(() {
        messages.add(m);
      });
    }
  }

  void onImageSend(String? path, String message) async {
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    popTime = 0;

    if (path == null) return;
    print('image path : $path');
    print('image message : $message');
    String url = "http://192.168.219.117:5000/routes/addimage";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print('response body decode : ${data[path]}');
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat.id,
      "targetId": widget.chatModel.id,
      "path": data[path],
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 24),
              CircleAvatar(
                child: SvgPicture.asset(
                  widget.chatModel.isGroup
                      ? "assets/groups.svg"
                      : "assets/person.svg",
                  color: Colors.white,
                  height: 36,
                  width: 36,
                ),
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatModel.name),
                Text("last seen today at 13:08")
              ],
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('value : $value');
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "View contact",
                  child: Text("View contact"),
                ),
                const PopupMenuItem(
                  value: "Media, links, and docs",
                  child: Text("Media, links, and docs"),
                ),
                const PopupMenuItem(
                  value: "Whatsapp web",
                  child: Text("Whatsapp web"),
                ),
                const PopupMenuItem(
                  value: "Search",
                  child: Text("Search"),
                ),
                const PopupMenuItem(
                  value: "Mute Notification",
                  child: Text("Mute Notification"),
                ),
                const PopupMenuItem(
                  value: "Wallpaper",
                  child: Text("Wallpaper"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: WillPopScope(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return Container(
                        height: 70,
                      );
                    }
                    if (messages[index].type == "source") {
                      if (messages[index].path != null) {
                        return OwnFileCard(
                          path: messages[index].path!,
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                      return OwnMessageCard(
                        message: messages[index].message,
                        time: messages[index].time,
                      );
                    } else {
                      if (messages[index].path != null) {
                        return ReplyFileCard(
                          path: messages[index].path!,
                          message: messages[index].message,
                          time: messages[index].time,
                        );
                      }
                      return ReplyCard(
                        message: messages[index].message,
                        time: messages[index].time,
                      );
                    }
                  },
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: width - 60,
                      child: Card(
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          controller: _controller,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value) {
                            setState(() {
                              sendButton = value.isNotEmpty;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "메세지를 입력하세요",
                              prefixIcon: IconButton(
                                onPressed: () {
                                  focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                icon: Icon(Icons.emoji_emotions),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return bottomSheet();
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.attach_file)),
                                  IconButton(
                                      onPressed: () {
                                        popTime = 2;
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return CameraScreen(
                                              onImageSend: onImageSend,
                                            );
                                          },
                                        ));
                                      },
                                      icon: Icon(Icons.camera_alt)),
                                ],
                              ),
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        right: 5,
                        left: 2,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xff128c7e),
                        child: IconButton(
                            onPressed: () {
                              sendButton = false;
                              sendMessage(
                                  _controller.text,
                                  widget.sourceChat.id,
                                  widget.chatModel.id,
                                  "");
                              _controller.clear();
                              if (!_scrollController.hasClients) return;
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                            },
                            icon: Icon(
                              sendButton ? Icons.send : Icons.mic,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Row(
              //         children: [
              //           Container(
              //             width: width - 60,
              //             child: Card(
              //               margin:
              //                   EdgeInsets.only(left: 2, right: 2, bottom: 8),
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(25)),
              //               child: TextFormField(
              //                 controller: _controller,
              //                 focusNode: focusNode,
              //                 textAlignVertical: TextAlignVertical.center,
              //                 keyboardType: TextInputType.multiline,
              //                 maxLines: 5,
              //                 minLines: 1,
              //                 onChanged: (value) {
              //                   setState(() {
              //                     sendButton = value.isNotEmpty;
              //                   });
              //                 },
              //                 decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     hintText: "메세지를 입력하세요",
              //                     prefixIcon: IconButton(
              //                       onPressed: () {
              //                         focusNode.unfocus();
              //                         focusNode.canRequestFocus = false;
              //                         setState(() {
              //                           show = !show;
              //                         });
              //                       },
              //                       icon: Icon(Icons.emoji_emotions),
              //                     ),
              //                     suffixIcon: Row(
              //                       mainAxisSize: MainAxisSize.min,
              //                       children: [
              //                         IconButton(
              //                             onPressed: () {
              //                               showModalBottomSheet(
              //                                 backgroundColor:
              //                                     Colors.transparent,
              //                                 context: context,
              //                                 builder: (context) {
              //                                   return bottomSheet();
              //                                 },
              //                               );
              //                             },
              //                             icon: Icon(Icons.attach_file)),
              //                         IconButton(
              //                             onPressed: () {},
              //                             icon: Icon(Icons.camera_alt)),
              //                       ],
              //                     ),
              //                     contentPadding: EdgeInsets.all(5)),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               bottom: 8,
              //               right: 5,
              //               left: 2,
              //             ),
              //             child: CircleAvatar(
              //               radius: 25,
              //               backgroundColor: Color(0xff128c7e),
              //               child: IconButton(
              //                   onPressed: () {
              //                     _scrollController.animateTo(
              //                         _scrollController
              //                             .position.maxScrollExtent,
              //                         duration: Duration(milliseconds: 300),
              //                         curve: Curves.easeOut);
              //                     sendMessage(
              //                         _controller.text,
              //                         widget.sourceChat.id,
              //                         widget.chatModel.id);
              //                     _controller.clear();
              //                   },
              //                   icon: Icon(
              //                     sendButton ? Icons.send : Icons.mic,
              //                     color: Colors.white,
              //                   )),
              //             ),
              //           )
              //         ],
              //       ),
              //       // show ? emojiSelect() : SizedBox(),
              //     ],
              //   ),
              // )
            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget emojiSelect() {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.35,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          print('emoji : $emoji');
          _controller.text = _controller.text += emoji.emoji;
          print('_controller.text : ${_controller.text}');
        },
        onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
        },
        textEditingController: _controller,
        // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          // progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    );
  }

  Widget bottomSheet() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 278,
      width: screenWidth,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      "Document", () {}),
                  SizedBox(width: 40),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {
                    popTime = 3;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CameraScreen(
                          onImageSend: onImageSend,
                        );
                      },
                    ));
                  }),
                  SizedBox(width: 40),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      () async {
                    popTime = 2;
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    if (file == null) return;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        popTime = 2;
                        return CameraViewPage(
                          path: file!.path,
                          onImageSend: onImageSend,
                        );
                      },
                    ));
                  }),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                  SizedBox(width: 40),
                  iconCreation(
                      Icons.location_pin, Colors.pink, "Location", () {}),
                  SizedBox(width: 40),
                  iconCreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
