import 'package:flutter/material.dart';
import 'package:jobtask/components/my_button.dart';
import 'package:jobtask/components/my_button_outlined.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // Background image
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage('assets/images/rfkicks_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/rfkicks_logo.png',
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivering top-notch shoe\nrepair, cleaning, and\ninspiration for footwear\nlovers',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                                child: MyButton(text: "Join Us", onTap: () {
                                  Navigator.pushNamed(context, 'register');
                                })),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: MyButtonOutlined(
                                    text: "Sign In", onTap: () {
                                      Navigator.pushNamed(context, 'sign in');
                                })),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
