import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/animations/rfkicks_animation.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/auth/forgot_password_screen.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/custom_webview_screen.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/screens/onboarding/onboarding_screens.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/utils/custom_border.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Saved User
  final storage = const FlutterSecureStorage();
  String? savedUserEmail;
  String? savedUserName;
  String? savedPassword;
  bool _isContinueAsLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    savedUserEmail = await storage.read(key: 'saved_user_email');
    savedUserName = await storage.read(key: 'saved_user_name');
    savedPassword = await storage.read(key: 'saved_password');
    if (mounted) setState(() {});
  }

  // Continue as Login
  Future<void> _continueAsLogin() async {
    setState(() => _isContinueAsLoading = true);

    try {
      final token = await ApiService.signIn(savedUserEmail!, savedPassword!);
      final storage = FlutterSecureStorage();
      await storage.write(key: 'auth_token', value: token);

      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'].toString();
      Provider.of<CartProvider>(context, listen: false).setUserId(userId);

      final onboardingCompleted = await ApiService.checkOnboardingStatus(token);

      if (!onboardingCompleted && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingFlow(
              userName: userProfile['display_name'] ?? 'User',
            ),
          ),
        );
      } else if (mounted) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: RfkicksAnimation(
              targetScreen: DashboardScreen(token: token),
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.show(
          context: context,
          message: 'Login failed. Please try again',
        );
      }
    } finally {
      if (mounted) setState(() => _isContinueAsLoading = false);
    }
  }

  // Sign In Method
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final token = await ApiService.signIn(email, password);
        final storage = FlutterSecureStorage();
        await storage.write(key: 'auth_token', value: token);

        // Get user profile and set cart user ID
        final userProfile = await ApiService.getUserProfile(token);
        final userId = userProfile['ID'].toString();
        Provider.of<CartProvider>(context, listen: false).setUserId(userId);

        await storage.write(key: 'saved_password', value: password);

        // Check onboarding status
        final onboardingCompleted =
            await ApiService.checkOnboardingStatus(token);

        if (!onboardingCompleted) {
          // Get user profile to get the name
          final userProfile = await ApiService.getUserProfile(token);

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingFlow(
                  userName: userProfile['display_name'] ?? 'User',
                ),
              ),
            );
          }
        } else {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: RfkicksAnimation(
                  targetScreen: DashboardScreen(token: token),
                ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          CustomSnackbar.show(
            context: context,
            message:
                'Please check your email/password or internet and try again',
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/header2-2-1.png',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 15),
              const Text("Sign In to ReFresh Kicks",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
              const SizedBox(height: 20),
              if (savedUserEmail != null && savedUserName != null)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isContinueAsLoading ? null : _continueAsLogin,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xff3c76ad),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Color(0xff3c76ad)),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff3c76ad),
                          radius: 16,
                          child: Text(
                            savedUserName![0].toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        _isContinueAsLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Color(0xff3c76ad),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('Continue as $savedUserName'),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  // border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                obscuringCharacter: '●',
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  // border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: ForgotPasswordScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                        // MaterialPageRoute(
                        //     builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xff3c76ad)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'By continuing, I agree to RFK\'s \n',
                      style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'Outfit',
                          fontSize: 16),
                    ),
                    TextSpan(
                      text: 'Privacy Policy ',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff767676),
                        fontFamily: 'Outfit',
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomWebViewScreen(
                                url: 'https://rfkicks.com/privacy-policy/',
                                title: 'Privacy Policy',
                              ),
                            ),
                          );
                        },
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'Outfit',
                          fontSize: 16),
                    ),
                    TextSpan(
                      text: 'Terms of Use. ',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff767676),
                        fontFamily: 'Outfit',
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomWebViewScreen(
                                url: 'https://rfkicks.com/terms-conditions/',
                                title: 'Terms of Use',
                              ),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff3c76ad),
                  foregroundColor: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Sign In'),
              ),
              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Haven\'t joined us? ',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'Outfit',
                        ),
                      ),
                      TextSpan(
                        text: 'Join now',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                PageTransition(
                                    child: (EmailInputScreen()),
                                    type: PageTransitionType.leftToRight));
                          },
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
