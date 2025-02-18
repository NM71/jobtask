import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/startup_screen.dart';
import 'package:jobtask/utils/transitions/custom_slide_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    if (kDebugMode) {
      print('Stored token: $token');
    }

    await Future.delayed(const Duration(seconds: 3));

    if (token != null) {
      try {
        final isValidFromApi = await ApiService.validateToken(token);
        if (kDebugMode) {
          print('API Validation result: $isValidFromApi');
        }

        if (isValidFromApi) {
          navigateWithSlideTransition(context, DashboardScreen(token: token));
          return;
        }

        // Move JWT validation here, outside the catch block
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = json.decode(
              utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
          final expirationDate =
              DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

          if (expirationDate.isAfter(DateTime.now())) {
            navigateWithSlideTransition(context, DashboardScreen(token: token));
            return;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Token validation error: $e');
        }
      }
    }

    navigateWithSlideTransition(context, const StartupScreen());
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
              height: 154,
              width: 154,
            ),
            const SizedBox(height: 20),
            const Text(
              'WELCOME!',
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Color(0xffffffff)),
          ],
        ),
      ),
    );
  }
}
