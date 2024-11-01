import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:before_after/before_after.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                'About Us',
                style: TextStyle(fontSize: 35),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'What is ReFresh Kicks?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Refresh Kicks is a premium sneaker cleaning and restoration service based in New York City providing quality cleaning to full restorations. We started back in 2019 when we partnered with Lucky Laced Sneaker Boutique, a consignment shop located in Williamsburg, Brooklyn. There, we were able to display our services attracting many customers.',
                style: TextStyle(color: Color(0xff727272)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset('assets/images/home_1.png'),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'Our Values',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),

            // Using RichText
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    // bullet 1
                    TextSpan(
                      text: 'We are professionals: ',
                      style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'OC-Regular',
                      ),
                    ),
                    TextSpan(
                      text:
                          'Our team has 10+ years of cleaning and restoring kicks and other shoes.',
                      style: TextStyle(
                        color: Color(0xff727272),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),

                    // bullet 2
                    TextSpan(
                      text: '\n\nWe are dedicated: ',
                      style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'OC-Regular',
                      ),
                    ),
                    TextSpan(
                      text:
                          'Our love and passion for the kicks brings out our best work ethics.',
                      style: TextStyle(
                        color: Color(0xff727272),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),

                    // bullet 3
                    TextSpan(
                      text: '\n\nWe are complete: ',
                      style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'OC-Regular',
                      ),
                    ),
                    TextSpan(
                      text:
                          'Our professionalism will put all of your worries to ease.',
                      style: TextStyle(
                        color: Color(0xff727272),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),

                    // bullet 4
                    TextSpan(
                      text: '\n\nSafety: ',
                      style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'OC-Regular',
                      ),
                    ),
                    TextSpan(
                      text:
                          'All of our products are safe for all type of shoe materials as well as the environment.',
                      style: TextStyle(
                        color: Color(0xff727272),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/home_2.png'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
