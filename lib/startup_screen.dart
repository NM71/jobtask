import 'package:flutter/material.dart';
import 'package:jobtask/screens/admin/admin_login_screen.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_buttons/my_button_outlined.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      image: AssetImage('assets/images/startup_screen.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/rfkicks_logo.png',
                            height: 77,
                            width: 77,
                          ),
                          MyButtonOutlined(
                              text: 'Admin Access',
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminLoginScreen()),
                                );
                              }),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => AdminLoginScreen()),
                          //     );
                          //   },
                          //   child: Text(
                          //     'Admin Access',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/header2-2-1.png',
                            height: 77,
                            width: 77,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Delivering top-notch shoe repair, cleaning, and inspiration for footwear lovers.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: MyButton(
                                    height: 51,
                                    width: 157,
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
                                  height: 51,
                                  width: 157,
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  text: "Sign In",
                                  onTap: () {
                                    // showDialog(
                                    showAdaptiveDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog.adaptive(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "\"RFK\" Wants to Use",
                                                style: TextStyle(fontSize: 17),
                                                textAlign: TextAlign.center,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Uri url = Uri.parse(
                                                          'https://rfkicks.com');
                                                      if (await canLaunchUrl(
                                                          url)) {
                                                        await launchUrl(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text('\"',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            )),
                                                        const Text(
                                                          "Rfkicks.com",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                        Text('\"',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  const Text(
                                                    " to Sign In",
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "This allows the app and website to share information about you",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ],
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
                                                        fontSize: 17,
                                                        color:
                                                            Color(0xff007AFF)),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
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
                                                        fontSize: 17,
                                                        color:
                                                            Color(0xff007aff)),
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
                          SizedBox(
                            height: 20,
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
      ),
    );
  }
}
