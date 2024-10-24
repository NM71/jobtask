import 'package:flutter/material.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_buttons/my_button_outlined.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                  text: "Join Us",
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return EmailInputScreen();
                                        });
                                  }),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: MyButtonOutlined(
                                text: "Sign In",
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color(0xffc2c2c2),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "\"RFK\" Wants to Use",
                                                style: TextStyle(fontSize: 24),
                                                textAlign: TextAlign.center,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      const url =
                                                          'https://rfkicks.com';
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: const Text(
                                                      "\"Rfkicks.com\"",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ),
                                                  const Text(
                                                    " to Sign In",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "This allows the app and website to share information about you",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xff007aff)),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return SignInScreen();
                                                      });

                                                  // old approach
                                                  // Navigator.of(context).pop();
                                                  // Navigator.pushNamed(
                                                  //     context, 'sign in');
                                                },
                                                child: const Text(
                                                  "Continue",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Color(0xff007aff)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
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
