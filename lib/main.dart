import 'package:app/newScreen/LandingScreen.dart';
import 'package:app/screens/CameraScreen.dart';
import 'package:app/screens/HomeScreen.dart';
import 'package:app/screens/LoginScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}