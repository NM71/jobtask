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

import 'package:flutter/material.dart';
import 'package:jobtask/sample_check.dart';
import 'package:jobtask/screens/about_screen.dart';
import 'package:jobtask/screens/cart/cart_screen.dart';
import 'package:jobtask/screens/profile/user_profile.dart';
import 'package:jobtask/screens/search_screen.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
              onTap: () {
                showModalBottomSheet(context: context, builder: (BuildContext contex){
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("You can find us here.", style: TextStyle(fontSize: 35),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final url = 'https://www.facebook.com/refreshkicksnyc/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Icon(Icons.facebook, color: Colors.blue, size: 40),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final url = 'https://www.instagram.com/refresh.kicks/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Image.asset('assets/icons/instagram_icon.png', height: 30, width: 30),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final url = 'https://x.com/refreshkicks/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Image.asset('assets/icons/twitter_icon.png', height: 30, width: 30),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final url = 'https://www.tiktok.com/@refreshkicks';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Image.asset('assets/icons/tiktok_icon.png', height: 30, width: 30),
                            ),
                            // Icon(Icons.facebook, color: Colors.blue,size: 50,),
                            // Image.asset('assets/icons/instagram_icon.png', height: 30, width: 30,),
                            // Image.asset('assets/icons/twitter_icon.png', height: 30, width: 30,),
                            // Image.asset('assets/icons/tiktok_icon.png', height: 30, width: 30,),
                          ],
                        ),
                      ],
                    ),
                  );
                });
              }, child: Image.asset('assets/images/header2-2-1.png')),
        ),
        backgroundColor: const Color(0xffffffff),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: navigateToSearchScreen,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/icons/search_icon.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/icons/home_icon.png',
              height: 30,
              width: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/icons/shop_icon.png',
              height: 30,
              width: 30,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/icons/cart_icon.png',
              height: 30,
              width: 30,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/icons/profile_icon.png',
              height: 30,
              width: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}


