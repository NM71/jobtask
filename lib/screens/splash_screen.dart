import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/startup_screen.dart';
import 'package:jobtask/utils/transitions/custom_slide_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  // Future<void> _checkToken() async {
  //   final storage = FlutterSecureStorage();
  //   final token = await storage.read(key: 'auth_token');
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   if (token != null) {
  //     try {
  //       final isValid = await ApiService.validateToken(token);
  //       if (isValid) {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
  //         );
  //         return;
  //       }
  //     } catch (e) {
  //       print('Error validating token: $e');
  //     }
  //   }
  //
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(builder: (context) => StartupScreen()),
  //   );
  // }

  Future<void> _checkToken() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    await Future.delayed(const Duration(seconds: 3));

    if (token != null) {
      try {
        final isValid = await ApiService.validateToken(token);
        if (isValid) {
          navigateWithSlideTransition(context, DashboardScreen(token: token));

          // Navigator.of(context).pushReplacement(
          //   _createSlideTransition(DashboardScreen(token: token)),
          // );
          return;
        }
      } catch (e) {
        print('Error validating token: $e');
      }
    }

    navigateWithSlideTransition(context, const StartupScreen());
    // Navigator.of(context).pushReplacement(
    //   _createSlideTransition(StartupScreen()),
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/rfk_preview.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text('WELCOME', style: TextStyle(fontSize: 30,color: Color(0xffffffff), fontWeight: FontWeight.bold),),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Color(0xff3c76ad),
            ),
          ],
        ),
      ),
    );
  }
}