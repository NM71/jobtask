// lib/main.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobtask/screens/account%20setup/onboarding.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/screens/auth/signin_conformation_screen.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:jobtask/screens/splash_screen.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//       DevicePreview(builder: (BuildContext context) => MyApp()));
// }

// void main() {
//   runApp(MyApp());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RFK Member Registration',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Sofia-Pro'),
      home: SplashScreen(),
      routes: {
        '/email': (context) => EmailInputScreen(),
        'sign in': (context) => SignInScreen(),
        'register': (context) => EmailInputScreen(),
        '/confirm': (context) => SigninConformationScreen(),
        '/onboarding': (context) => OnboardingScreen(userName: '',),
        '/shop': (context) => ServicePage(),
      },
    );
  }
}
