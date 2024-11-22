// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:jobtask/sample_check.dart';
// import 'package:jobtask/utils/FAB_animated.dart';
// import 'package:page_transition/page_transition.dart';
//
// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
//               child: Text(
//                 'About Us',
//                 style: TextStyle(fontSize: 35),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//               child: Text(
//                 'What is ReFresh Kicks?',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 'Refresh Kicks is a premium sneaker cleaning and restoration service based in New York City providing quality cleaning to full restorations. We started back in 2019 when we partnered with Lucky Laced Sneaker Boutique, a consignment shop located in Williamsburg, Brooklyn. There, we were able to display our services attracting many customers.',
//                 style: TextStyle(color: Color(0xff727272)),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Image.asset('assets/images/home_1.png'),
//             const SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//               child: Text(
//                 'Our Values',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//               ),
//             ),
//
//             // Using RichText
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: RichText(
//                 text: const TextSpan(
//                   children: <TextSpan>[
//                     // bullet 1
//                     TextSpan(
//                       text: 'We are professionals: ',
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           'Our team has 10+ years of cleaning and restoring kicks and other shoes.',
//                       style: TextStyle(
//                         color: Color(0xff727272),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//
//                     // bullet 2
//                     TextSpan(
//                       text: '\n\nWe are dedicated: ',
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           'Our love and passion for the kicks brings out our best work ethics.',
//                       style: TextStyle(
//                         color: Color(0xff727272),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//
//                     // bullet 3
//                     TextSpan(
//                       text: '\n\nWe are complete: ',
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           'Our professionalism will put all of your worries to ease.',
//                       style: TextStyle(
//                         color: Color(0xff727272),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//
//                     // bullet 4
//                     TextSpan(
//                       text: '\n\nSafety: ',
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text:
//                           'All of our products are safe for all type of shoe materials as well as the environment.',
//                       style: TextStyle(
//                         color: Color(0xff727272),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Image.asset('assets/images/home_2.png'),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionAnimation(),
//     );
//   }
// }
//
//

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jobtask/sample_check.dart';
import 'package:jobtask/utils/FAB_animated.dart';
import 'package:jobtask/utils/custom_image_carousel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ticker_text/ticker_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding and font sizes based on screen width
    double horizontalPadding = screenWidth * 0.05;
    double titleFontSize = screenWidth * 0.08; // About Us title
    double subTitleFontSize = screenWidth * 0.06; // Other titles
    double bodyFontSize = screenWidth * 0.04; // Body text

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff3c76ad),
                ),
                child: TickerText(
                  scrollDirection: Axis.horizontal,
                  speed: 20,
                  startPauseDuration: const Duration(seconds: 10),
                  endPauseDuration: const Duration(seconds: 10),
                  // returnDuration: const Duration(milliseconds: 700),
                  primaryCurve: Curves.linear,
                  returnCurve: Curves.linear,
                  child: Text(
                    "👟👟👟 Expedited fee: \$20 (for qualifying services). This will reduce the turnaround time to one business day if shoes are delivered or dropped off by 5 PM EST. 📮📮📮",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ImageCarousel(
                assetImagePaths: [
                  'assets/images/carousel_images/Rfkicks-Carousel 1.png',
                  'assets/images/carousel_images/Rfkicks-Carousel 3.png',
                  'assets/images/carousel_images/Rfkicks-Carousel 2.png',
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 15),
                child: Text(
                  'About Us',
                  style: TextStyle(
                      fontSize: titleFontSize,
                      color: Color(0xff3c76ad),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 10),
                child: Text(
                  'What is ReFresh Kicks?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: subTitleFontSize,
                      color: Color(0xff3c76ad)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  'Refresh Kicks is a premium sneaker cleaning and restoration service based in New York City providing quality cleaning to full restorations. We started back in 2019 when we partnered with Lucky Laced Sneaker Boutique, a consignment shop located in Williamsburg, Brooklyn. There, we were able to display our services attracting many customers.',
                  style: TextStyle(
                      color: Color(0xff727272), fontSize: bodyFontSize),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Image.asset(
                  'assets/images/home_1.png',
                  width: screenWidth * 0.9, // 90% of screen width
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 10),
                child: Text(
                  'Our Values',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: subTitleFontSize),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      // bullet 1
                      TextSpan(
                        text: 'We are professionals: ',
                        style: TextStyle(
                          color: Color(0xff3c76ad),
                          fontWeight: FontWeight.bold,
                          fontSize: bodyFontSize * 1.1, // slightly larger
                        ),
                      ),
                      TextSpan(
                        text:
                            'Our team has 10+ years of cleaning and restoring kicks and other shoes.',
                        style: TextStyle(
                          color: Color(0xff727272),
                          fontSize: bodyFontSize,
                        ),
                      ),
                      // bullet 2
                      TextSpan(
                        text: '\n\nWe are dedicated: ',
                        style: TextStyle(
                          color: Color(0xff3c76ad),
                          fontWeight: FontWeight.bold,
                          fontSize: bodyFontSize * 1.1,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Our love and passion for the kicks brings out our best work ethics.',
                        style: TextStyle(
                          color: Color(0xff727272),
                          fontSize: bodyFontSize,
                        ),
                      ),
                      // bullet 3
                      TextSpan(
                        text: '\n\nWe are complete: ',
                        style: TextStyle(
                          color: Color(0xff3c76ad),
                          fontWeight: FontWeight.bold,
                          fontSize: bodyFontSize * 1.1,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Our professionalism will put all of your worries to ease.',
                        style: TextStyle(
                          color: Color(0xff727272),
                          fontSize: bodyFontSize,
                        ),
                      ),
                      // bullet 4
                      TextSpan(
                        text: '\n\nSafety: ',
                        style: TextStyle(
                          color: Color(0xff3c76ad),
                          fontWeight: FontWeight.bold,
                          fontSize: bodyFontSize * 1.1,
                        ),
                      ),
                      TextSpan(
                        text:
                            'All of our products are safe for all types of shoe materials as well as the environment.',
                        style: TextStyle(
                          color: Color(0xff727272),
                          fontSize: bodyFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Image.asset(
                  'assets/images/home_2.png',
                  width: screenWidth * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionAnimation(),
    );
  }
}
