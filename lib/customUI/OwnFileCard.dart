import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  OwnFileCard({
    required this.path,
    required this.message,
    required this.time,
    Key? key,
  }) : super(key: key);
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green[300]),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 2.3,
                  width: screenWidth / 1.8,
                  child: Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
