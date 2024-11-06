// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jobtask/screens/auth/sign_in_screen.dart';
// import 'package:jobtask/screens/about_screen.dart';
// import 'package:jobtask/screens/profile/user_profile.dart';
// import 'package:jobtask/screens/shop/shop_screen.dart';
// import 'package:jobtask/startup_screen.dart';
//
// class DashboardScreen extends StatefulWidget {
//   final String token;
//
//   const DashboardScreen({Key? key, required this.token}) : super(key: key);
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     ServicePage(),
//     Center(child: Text('Cart Screen')),
//     UserProfile(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff000000),
//       appBar: AppBar(
//         leading: Image.asset('assets/images/header2-2-1.png'),
//         backgroundColor: const Color(0xffffffff),
//         actions: [
//           GestureDetector(
//             onTap: () async {
//               final storage = FlutterSecureStorage();
//               await storage.delete(key: 'auth_token'); // Clear the stored token
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => StartupScreen()),
//                 (route) => false,
//               );
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: Icon(
//                 Icons.logout,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: _widgetOptions[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/home_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/shop_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Shop',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/cart_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/profile_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// working code
// import 'package:flutter/material.dart';
// import 'package:jobtask/sample_check.dart';
// import 'package:jobtask/screens/about_screen.dart';
// import 'package:jobtask/screens/cart/cart_screen.dart';
// import 'package:jobtask/screens/profile/user_profile.dart';
// import 'package:jobtask/screens/search_screen.dart';
// import 'package:jobtask/screens/shop/shop_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DashboardScreen extends StatefulWidget {
//   final String token;
//
//   const DashboardScreen({Key? key, required this.token}) : super(key: key);
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _widgetOptions = <Widget>[
//     AboutScreen(),
//     ServicePage(),
//     CartScreen(),
//     UserProfile(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void navigateToSearchScreen() {
//     Navigator.push(
//         context,
//         PageTransition(
//           child: SearchScreen(),
//           type: PageTransitionType.fade,
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff000000),
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(context: context, builder: (BuildContext contex){
//                   return Container(
//                     color: Colors.white,
//                     width: double.infinity,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Text("You can find us here.", style: TextStyle(fontSize: 35),),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             GestureDetector(
//                               onTap: () async {
//                                 final url = 'https://www.facebook.com/refreshkicksnyc/';
//                                 if (await canLaunch(url)) {
//                                   await launch(url);
//                                 } else {
//                                   throw 'Could not launch $url';
//                                 }
//                               },
//                               child: Icon(Icons.facebook, color: Colors.blue, size: 40),
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 final url = 'https://www.instagram.com/refresh.kicks/';
//                                 if (await canLaunch(url)) {
//                                   await launch(url);
//                                 } else {
//                                   throw 'Could not launch $url';
//                                 }
//                               },
//                               child: Image.asset('assets/icons/instagram_icon.png', height: 30, width: 30),
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 final url = 'https://x.com/refreshkicks/';
//                                 if (await canLaunch(url)) {
//                                   await launch(url);
//                                 } else {
//                                   throw 'Could not launch $url';
//                                 }
//                               },
//                               child: Image.asset('assets/icons/twitter_icon.png', height: 30, width: 30),
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 final url = 'https://www.tiktok.com/@refreshkicks';
//                                 if (await canLaunch(url)) {
//                                   await launch(url);
//                                 } else {
//                                   throw 'Could not launch $url';
//                                 }
//                               },
//                               child: Image.asset('assets/icons/tiktok_icon.png', height: 30, width: 30),
//                             ),
//                             // Icon(Icons.facebook, color: Colors.blue,size: 50,),
//                             // Image.asset('assets/icons/instagram_icon.png', height: 30, width: 30,),
//                             // Image.asset('assets/icons/twitter_icon.png', height: 30, width: 30,),
//                             // Image.asset('assets/icons/tiktok_icon.png', height: 30, width: 30,),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 });
//               }, child: Image.asset('assets/images/header2-2-1.png')),
//         ),
//         backgroundColor: const Color(0xffffffff),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: GestureDetector(
//               onTap: navigateToSearchScreen,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: Image.asset(
//                   'assets/icons/search_icon.png',
//                   height: 30,
//                   width: 30,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: _widgetOptions[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/home_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/shop_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Shop',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/cart_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Image.asset(
//               'assets/icons/profile_icon.png',
//               height: 30,
//               width: 30,
//             ),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// implemented with willPopScope
import 'package:flutter/material.dart';
import 'package:jobtask/sample_check.dart';
import 'package:jobtask/screens/about/about_screen.dart';
import 'package:jobtask/screens/cart/cart_screen.dart';
import 'package:jobtask/screens/profile/user_profile.dart';
import 'package:jobtask/screens/search_screen.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  final String token;

  const DashboardScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  DateTime? _lastBackPressTime;

  final List<Widget> _widgetOptions = <Widget>[
    AboutScreen(),
    ServicePage(),
    CartScreen(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      // First press or more than 2 seconds since last press
      _lastBackPressTime = now;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Press back again to exit'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      CustomSnackbar.show(
        context: context,
        message: 'Press back again to exit',
        duration: Duration(seconds: 2),
      );
      return false;
    }
    return true; // Allow app to exit
  }

  void navigateToSearchScreen() {
    Navigator.push(
        context,
        PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.fade,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 8.0),
          //   child: GestureDetector(
          //       onTap: () {
          //         showModalBottomSheet(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return Container(
          //                 color: Colors.white,
          //                 width: double.infinity,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Image.asset(
          //                         "assets/images/satisfied_icon.png",
          //                         color: Color(0xff3c76ad),
          //                         width: MediaQuery.of(context).size.width * 0.15,
          //                         height: MediaQuery.of(context).size.height * 0.1,
          //                       ),
          //                       Text(
          //                         "Satisfaction Guaranteed!",
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       SizedBox(height: 15,),
          //                       Text("Your satisfaction is a 100% guaranteed at ReFresh Kicks. We we take our time with each and every pair of shoes that are delivered to us. We thoroughly inspect the kicks  after each job to make sure we thoroughly completed our services. If by any chance we are not satisfied with the service we start it over until it meets our requirements. We do this so that once your kicks are back in your hands there are no complaints just a huge smile on your face just like a kid in a candy store. "),
          //                       SizedBox(height: 20),
          //                       Padding(
          //                         padding: const EdgeInsets.all(20.0),
          //                         child: Text(
          //                           "You can also find us here.",
          //                           style: TextStyle(fontSize: 20),
          //                         ),
          //                       ),
          //                       Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceEvenly,
          //                         children: [
          //                           GestureDetector(
          //                             onTap: () async {
          //                               final url =
          //                                   'https://www.facebook.com/refreshkicksnyc/';
          //                               if (await canLaunch(url)) {
          //                                 await launch(url);
          //                               } else {
          //                                 throw 'Could not launch $url';
          //                               }
          //                             },
          //                             child: Icon(Icons.facebook,
          //                                 color: Colors.blue, size: 30),
          //                           ),
          //                           GestureDetector(
          //                             onTap: () async {
          //                               final url =
          //                                   'https://www.instagram.com/refresh.kicks/';
          //                               if (await canLaunch(url)) {
          //                                 await launch(url);
          //                               } else {
          //                                 throw 'Could not launch $url';
          //                               }
          //                             },
          //                             child: Image.asset(
          //                                 'assets/icons/instagram_icon.png',
          //                                 height: 30,
          //                                 width: 30),
          //                           ),
          //                           GestureDetector(
          //                             onTap: () async {
          //                               final url = 'https://x.com/refreshkicks/';
          //                               if (await canLaunch(url)) {
          //                                 await launch(url);
          //                               } else {
          //                                 throw 'Could not launch $url';
          //                               }
          //                             },
          //                             child: Image.asset(
          //                                 'assets/icons/twitter_icon.png',
          //                                 height: 30,
          //                                 width: 30),
          //                           ),
          //                           GestureDetector(
          //                             onTap: () async {
          //                               final url =
          //                                   'https://www.tiktok.com/@refreshkicks';
          //                               if (await canLaunch(url)) {
          //                                 await launch(url);
          //                               } else {
          //                                 throw 'Could not launch $url';
          //                               }
          //                             },
          //                             child: Image.asset(
          //                                 'assets/icons/tiktok_icon.png',
          //                                 height: 30,
          //                                 width: 30),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             });
          //       },
          //       child: Image.asset('assets/images/header2-2-1.png')),
          // ),

            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/satisfied_icon.png",
                              color: Color(0xff3c76ad),
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Satisfaction Guaranteed!",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Flexible(
                              child: Text(
                                "Your satisfaction is 100% guaranteed at ReFresh Kicks. We take our time with each and every pair of shoes delivered to us. We thoroughly inspect the kicks after each job to ensure completion. If by any chance we are not satisfied with the service, we redo it until it meets our standards. This ensures that once your kicks are back in your hands, there are no complaints, just a huge smile.",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                            Text(
                              "You can also find us here.",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Facebook
                                _buildSocialIcon(
                                  context,
                                  icon: Icons.facebook,
                                  color: Colors.blue,
                                  url: 'https://www.facebook.com/refreshkicksnyc/',
                                ),
                                // Instagram
                                _buildImageIcon(
                                  context,
                                  asset: 'assets/icons/instagram_icon.png',
                                  url: 'https://www.instagram.com/refresh.kicks/',
                                ),
                                // Twitter (X)
                                _buildImageIcon(
                                  context,
                                  asset: 'assets/icons/twitter_icon.png',
                                  url: 'https://x.com/refreshkicks/',
                                ),
                                // TikTok
                                _buildImageIcon(
                                  context,
                                  asset: 'assets/icons/tiktok_icon.png',
                                  url: 'https://www.tiktok.com/@refreshkicks',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Image.asset('assets/images/header2-2-1.png'),
              ),
            ),
          backgroundColor: const Color(0xffffffff),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: navigateToSearchScreen,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    'assets/icons/search_icon.png',
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: _widgetOptions[_selectedIndex],
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 0,
        //   type: BottomNavigationBarType.fixed,
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.white,
        //       icon: Image.asset(
        //         'assets/icons/home_icon.png',
        //         height: 30,
        //         width: 30,
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.white,
        //       icon: Image.asset(
        //         'assets/images/quickSearch_icon.png',
        //         height: 30,
        //         width: 30,
        //       ),
        //       label: 'Shop',
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.white,
        //       icon: Image.asset(
        //         'assets/icons/cart_icon.png',
        //         height: 30,
        //         width: 30,
        //       ),
        //       label: 'Cart',
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.white,
        //       icon: Image.asset(
        //         'assets/icons/profile_icon.png',
        //         height: 30,
        //         width: 30,
        //       ),
        //       label: 'Profile',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.grey,
        //   backgroundColor: Colors.white,
        //   onTap: _onItemTapped,
        // ),

        // bottom Nav bar
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/home_icon.png', 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/images/quickSearch_icon.png', 1),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/cart_icon.png', 2),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/profile_icon1.png', 3),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xff767676),
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  Widget _buildIcon(String assetPath, int index) {
    return Image.asset(
      assetPath,
      height: 30,
      width: 30,
      color: _selectedIndex == index ? Colors.black : Color(0xff767676),
    );
  }
}


// Widget for building social icon buttons
Widget _buildSocialIcon(BuildContext context,
    {required IconData icon, required Color color, required String url}) {
  return GestureDetector(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    },
    child: Icon(
      icon,
      color: color,
      size: MediaQuery.of(context).size.width * 0.08,
    ),
  );
}

// Widget for building image-based social icons
Widget _buildImageIcon(BuildContext context,
    {required String asset, required String url}) {
  return GestureDetector(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    },
    child: Image.asset(
      asset,
      height: MediaQuery.of(context).size.width * 0.08,
      width: MediaQuery.of(context).size.width * 0.08,
    ),
  );
}