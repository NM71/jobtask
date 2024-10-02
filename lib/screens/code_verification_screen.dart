// lib/screens/code_verification_screen.dart
import 'package:flutter/material.dart';
import 'package:jobtask/services/api_service.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String email;

  CodeVerificationScreen({required this.email});

  @override
  _CodeVerificationScreenState createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/header2-2-1.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("We've sent a code to ${widget.email}"),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(26),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff3c76ad),
                foregroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                if (await ApiService.verifyCode(
                    widget.email, _codeController.text)) {
                  Navigator.pushNamed(context, '/register');
                } else {
                  // Show error message
                }
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}


