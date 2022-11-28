import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rigel_application/firebase_options.dart';
import 'package:rigel_application/screens/home_screen.dart';

import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    firstCamera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  const MyApp({Key? key, required this.firstCamera}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen.wCameraUsage(passCamara: firstCamera),
    );
  }
}
