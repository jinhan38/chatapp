import 'package:app/newScreen/LoginPage.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 29,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: screenHeight / 9),
            Image.asset(
              "assets/bee.png",
              // color: Colors.greenAccent.shade700,
              width: 250,
              height: 250,
            ),
            SizedBox(height: screenHeight / 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    children: [
                      TextSpan(
                          text: "Agree and Continue to accept the ",
                          style: TextStyle(color: Colors.grey.shade600)),
                      TextSpan(
                          text: "WhatsApp Terms of Service and Privacy Policy",
                          style: TextStyle(color: Colors.cyan)),
                    ]),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              child: Container(
                height: 50,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  elevation: 8,
                  color: Colors.greenAccent.shade700,
                  child: Center(
                    child: Text(
                      "AGREE AND CONTINUE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
