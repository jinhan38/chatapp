import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Stack(
            children: [
              Padding(
                  padding:
                  EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
                  child: Text(
                    "답장 메세이지이요. 무슨말이지요? ",
                    style: TextStyle(fontSize: 16),
                  )),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text("20:05",
                    style:
                    TextStyle(fontSize: 13, color: Colors.grey[600])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
