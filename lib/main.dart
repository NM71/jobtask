import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jobtask/env.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/screens/auth/signin_conformation_screen.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/cart/navigation_provider.dart';
import 'package:jobtask/screens/profile/country_provider.dart';
import 'package:jobtask/screens/profile/order_history_screen.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:jobtask/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await Environment.initialize();

  // Initialize Stripe
  Stripe.publishableKey = Environment.stripeKey;
  await Stripe.instance.applySettings();

  // Initialize providers
  final countryProvider = CountryProvider();
  await countryProvider.initialize();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        // ChangeNotifierProvider(create: (context) => CountryProvider()),
        ChangeNotifierProvider.value(value: countryProvider),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Internet connectivity check
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final Connectivity _connectivity = Connectivity();
  bool _isSnackbarActive = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _initConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    _updateConnectionStatus(result.first);
  }

  Future<void> _initConnectivity() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results.first);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (!mounted) return;

    if (result == ConnectivityResult.none) {
      if (!_isSnackbarActive) {
        _isSnackbarActive = true;
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Please check your connection',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF323232),
            behavior: SnackBarBehavior.fixed,
            duration: const Duration(days: 365),
            animation: CurvedAnimation(
              parent: const AlwaysStoppedAnimation(1),
              curve: Curves.easeOutCirc,
            ),
          ),
        );
      }
    } else {
      if (_isSnackbarActive) {
        _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
        _isSnackbarActive = false;
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.wifi_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Back Online',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF2E7D32),
            behavior: SnackBarBehavior.fixed,
            duration: const Duration(seconds: 3),
            animation: CurvedAnimation(
              parent: const AlwaysStoppedAnimation(1),
              curve: Curves.easeOutCirc,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'RFKicks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Outfit', // Default font
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleColor: Color(0xff3c76ad),
        ),
      ),
      home: SplashScreen(),

      // Named Routes
      routes: {
        '/email': (context) => EmailInputScreen(),
        'sign in': (context) => SignInScreen(),
        'register': (context) => EmailInputScreen(),
        '/confirm': (context) => SigninConformationScreen(),
        '/shop': (context) => ServicePage(),
        '/order-history': (context) => OrderHistoryScreen(),
      },
    );
  }
}
