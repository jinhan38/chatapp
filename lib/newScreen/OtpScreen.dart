import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({
    required this.countryCode,
    required this.number,
    Key? key,
  }) : super(key: key);
  final String countryCode;
  final String number;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Verify ${widget.countryCode} ${widget.number}",
          style: TextStyle(color: Colors.teal[800], fontSize: 16.5),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent an SMS with a code to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: "+" + widget.countryCode + " " + widget.number,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Wrong number?",
                    style: TextStyle(
                      color: Colors.cyan.shade800,
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(height: 20),
            Text(
              "Enter 6-digit code",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.5),
            ),
            SizedBox(height: 30),
            bottomButton("Resend SMS", Icons.message),
            SizedBox(height: 12),
            Divider(thickness: 1.5),
            SizedBox(height: 12),
            bottomButton("Call Me", Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(
    String text,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal, size: 24),
        SizedBox(width: 25),
        Text(
          text,
          style: TextStyle(color: Colors.teal, fontSize: 14.5),
        ),
      ],
    );
  }
}
