import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth - 45),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Stack(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
                  child: Text(
                    "aaaaaaaaaaasdf asdfa  asfmp asaw asfaesf rgb sthsrth",
                    style: TextStyle(fontSize: 16),
                  )),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text("20:05",
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[600])),
                    SizedBox(width: 5),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
