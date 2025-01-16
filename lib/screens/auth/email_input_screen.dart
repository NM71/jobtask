import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/registration_form_screen.dart';
import 'package:jobtask/screens/custom_webview_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

import '../../utils/custom_border.dart';

class EmailInputScreen extends StatefulWidget {
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Track loading state

  // Regular expression for email validation
  String? validateEmail(String value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return "Required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 36),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/header2-2-1.png',
                      height: 37,
                      width: 55,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Enter your email to join us or sign in.',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xff767676)),
                    border: customBorder(),
                    enabledBorder: customBorder(),
                    focusedBorder: customBorder(),
                    // border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value ?? ''),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xff3c76ad),
                    foregroundColor: const Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true; // Start loading
                          });

                          if (_formKey.currentState!.validate()) {
                            try {
                              final success = await ApiService.submitEmail(
                                  _emailController.text);
                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationFormScreen(
                                            email: _emailController.text),
                                  ),
                                );
                              }
                            } catch (e) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(content: Text('Error: ${e.toString()}')),
                              // );
                              CustomSnackbar.show(
                                  context: context,
                                  // message:
                                  //     'Please check your email and try again');
                                  message:
                                      'Unable to send email, please check your internet and try again');

                              // CustomSnackbar.show(
                              //   context: context,
                              //   message: 'Error: ${e.toString()}',
                              // );
                            } finally {
                              setState(() {
                                _isLoading = false; // Stop loading
                              });
                            }
                          } else {
                            setState(() {
                              _isLoading =
                                  false; // Stop loading if validation fails
                            });
                          }
                        },
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2.0,
                          ),
                        )
                      : const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
