import 'package:app/model/CountryModel.dart';
import 'package:app/newScreen/CountryPage.dart';
import 'package:app/newScreen/OtpScreen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "USA";
  String countryCode = "+82";
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              wordSpacing: 1),
        ),
        actions: [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Text(
              "WhatsApp will send an sms message to verify your number",
              style: TextStyle(fontSize: 13.5),
            ),
            SizedBox(height: 5),
            Text(
              "What's my number?",
              style: TextStyle(fontSize: 12.8, color: Colors.cyan.shade800),
            ),
            SizedBox(height: 15),
            countryCard(),
            SizedBox(height: 15),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_controller.text.isEmpty) {
                  showMyDialog1();
                } else {
                  showMyDialog();
                }
              },
              child: Container(
                width: 70,
                height: 40,
                color: Colors.tealAccent.shade400,
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget countryCard() {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CountryPage(
              setCountryData: setCountryData,
            );
          },
        ));
      },
      child: Container(
        width: screenWidth / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.teal, width: 1.8),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(countryName, style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
              size: 28,
            )
          ],
        ),
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Widget number() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth / 1.5,
      padding: EdgeInsets.symmetric(vertical: 5),
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "+",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            width: screenWidth / 1.5 - 100,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: "phone number"),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We Will be veryfying your phone Numnber",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  countryCode + " " + _controller.text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "Is this Ok, or would you like edit the number",
                  style: TextStyle(fontSize: 13.5),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Edit")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return OtpScreen(
                          countryCode: countryCode, number: _controller.text);
                    },
                  ));
                },
                child: Text("ok")),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog1() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "There is no number you entered",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok")),
          ],
        );
      },
    );
  }
}
