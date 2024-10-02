// lib/main.dart
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/signin_conformation_screen.dart';
import 'screens/email_input_screen.dart';
import 'screens/code_verification_screen.dart';
import 'screens/registration_form_screen.dart';

void main() {
  runApp(
      DevicePreview(builder: (BuildContext context) => MyApp()));
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
      home: SigninConformationScreen(),
      routes: {
        '/email': (context) => EmailInputScreen(),
        '/verify': (context) => CodeVerificationScreen(email: ''),
        '/register': (context) => RegistrationFormScreen(),
        '/confirm': (context) => SigninConformationScreen(),
      },
    );
  }
}