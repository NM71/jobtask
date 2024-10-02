import 'package:flutter/material.dart';

class SigninConformationScreen extends StatelessWidget {
  const SigninConformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/header2-2-1.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You have been signed in successfully.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(26),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff3c76ad),
                foregroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: ()  {
                },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
