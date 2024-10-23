// lib/main.dart
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/screens/auth/signin_conformation_screen.dart';
import 'package:jobtask/screens/splash_screen.dart';
import 'package:jobtask/startup_screen.dart';


// void main() {
//   runApp(
//       DevicePreview(builder: (BuildContext context) => MyApp()));
// }


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RFK Member Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OC-Regular'
      ),
      home: SplashScreen(),
      routes: {
        '/email': (context) => EmailInputScreen(),
        'sign in': (context) => SignInScreen(),
        'register': (context) => EmailInputScreen(),
        '/confirm': (context) => SigninConformationScreen(),
      },
    );
  }
}