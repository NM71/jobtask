import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobtask/screens/about/about_screen.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/cart/cart_screen.dart';
import 'package:jobtask/screens/profile/user_profile.dart';
import 'package:jobtask/screens/search_screen.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  final String token;

  const DashboardScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _widgetOptions = <Widget>[
    AboutScreen(),
    ServicePage(),
    CartScreen(),
    UserProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // This makes it instant
    });
  }
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     _pageController.animateToPage(
  //       index,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
      return false;
    }

    bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        // icon: Icon(Icons.exit_to_app_outlined, color: Colors.red, size: 30),
        title: Text('Exit ReFresh Kicks?'),
        content: Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: TextStyle(fontSize: 17, color: Color(0xff000000)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Yes',
              style: TextStyle(fontSize: 17, color: Color(0xff007AFF)),
            ),
          ),
        ],
      ),
    );

    if (shouldExit ?? false) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                // icon: Icon(Icons.search, color: Color(0xff3c76ad)),
                icon: Image.asset(
                  'assets/icons/MagnifyingGlass.png',
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: SearchScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            "Satisfaction Guaranteed!",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Flexible(
                            child: Text(
                              "Your satisfaction is 100% guaranteed at ReFresh Kicks. We take our time with each and every pair of shoes delivered to us. We thoroughly inspect the kicks after each job to ensure completion. If by any chance we are not satisfied with the service, we redo it until it meets our standards. This ensures that once your kicks are back in your hands, there are no complaints, just a huge smile.",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                color: Color(0xff767676),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                          Text(
                            "You can also find us here.",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialIcon(
                                context,
                                icon: Icons.facebook,
                                color: Colors.blue,
                                url:
                                    'https://www.facebook.com/refreshkicksnyc/',
                              ),
                              _buildImageIcon(
                                context,
                                asset: 'assets/icons/instagram_icon.png',
                                url: 'https://www.instagram.com/refresh.kicks/',
                              ),
                              _buildImageIcon(
                                context,
                                asset: 'assets/icons/twitter_icon.png',
                                url: 'https://x.com/refreshkicks/',
                              ),
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
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/HouseSimple.png', 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/ListMagnifyingGlass.png', 1),
              label: 'Shop',
            ),
            // Inside bottomNavigationBar
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Stack(
                children: [
                  Image.asset(
                    'assets/icons/cart.png',
                    height: 30,
                    width: 30,
                    color:
                        _selectedIndex == 2 ? Colors.black : Color(0xff767676),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      if (cart.cartItems.isEmpty) return SizedBox();
                      return Positioned(
                        right: 0,
                        top: -3,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xff3c76ad),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cart.cartItems.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              label: 'Cart',
            ),

            // BottomNavigationBarItem(
            //   backgroundColor: Colors.white,
            //   icon: _buildIcon('assets/icons/cart.png', 2),
            //   label: 'Cart',
            // ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: _buildIcon('assets/icons/User.png', 3),
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
