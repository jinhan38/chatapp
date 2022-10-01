import 'package:app/customUI/statusPage/HeadOwnStatus.dart';
import 'package:app/customUI/statusPage/OtherStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              onPressed: () {},
              elevation: 8,
              backgroundColor: Colors.blueGrey[100],
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(height: 13),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            HeadOwnStatus(),
            label("Recent updates"),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/pig.png",
              isSeen: true,
              statusNum: 1,
            ),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/sheep.png",
              isSeen: true,
              statusNum: 2,
            ),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/crab.png",
              isSeen: true,
              statusNum: 3,
            ),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/butterfly.png",
              isSeen: true,
              statusNum: 4,
            ),
            SizedBox(height: 10),
            label("Viewed updates"),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/rabbit.png",
              isSeen: false,
              statusNum: 1,
            ),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/crab.png",
              isSeen: true,
              statusNum: 2,
            ),
            OtherStatus(
              name: "asdfasdf",
              time: DateTime.now().toString(),
              imageName: "assets/butterfly.png",
              isSeen: false,
              statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      child: Text(
        labelName,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}
