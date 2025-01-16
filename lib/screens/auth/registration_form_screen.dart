// Notifications and Terms and Conditions remaining

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/animations/rfkicks_animation.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/utils/custom_border.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationFormScreen extends StatefulWidget {
  final String email;

  RegistrationFormScreen({required this.email});

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  bool _getUpdates = false;

  DateTime? _dateOfBirth;
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isResendAvailable = true;
  int _timerDuration = 30;
  late final Timer _timer;
  bool _isCodeVerified = false;
  bool _isLengthValid = false;
  bool _isComplexityValid = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _codeController.addListener(_verifyCode); // Listen for code input changes
  }

  void _startTimer() {
    _isResendAvailable = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration > 0) {
        setState(() {
          _timerDuration--;
        });
      } else {
        _timer.cancel();
        setState(() {
          _isResendAvailable = true;
          _timerDuration = 30; // Reset to 30 seconds
        });
      }
    });
  }

  // User Registration Function
  Future<void> _register() async {
    // DOB Validation
    if (_dateOfBirth == null) {
      CustomSnackbar.show(
        context: context,
        message: 'Please select your date of birth',
      );
      return;
    }

    if (!_termsAccepted) {
      CustomSnackbar.show(
        context: context,
        message: 'Please accept the Terms and Privacy Policy to continue',
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userData = {
          'email': widget.email.trim(),
          'firstName': _firstNameController.text,
          'surname': _surnameController.text,
          'password': _passwordController.text.trim(),
          'dateOfBirth': _dateOfBirth!.toIso8601String(),
        };
        final token = await ApiService.registerUser(userData);

        const storage = FlutterSecureStorage();
        await storage.write(key: 'auth_token', value: token);

        Navigator.of(context).pushReplacement(
          PageTransition(
              child: RfkicksAnimation(targetScreen: SignInScreen()),
              type: PageTransitionType.rightToLeft),
        );
      } catch (e) {
        CustomSnackbar.show(
          context: context,
          message: e.toString().contains('already registered')
              ? 'This email is already registered'
              : 'Registration failed: ${e.toString()}',
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Future<void> _register() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     try {
  //       final userData = {
  //         'email': widget.email.trim(),
  //         'firstName': _firstNameController.text,
  //         'surname': _surnameController.text,
  //         'password': _passwordController.text.trim(),
  //         'dateOfBirth': _dateOfBirth!.toIso8601String(),
  //       };
  //       final token = await ApiService.registerUser(userData);

  //       const storage = FlutterSecureStorage();
  //       await storage.write(key: 'auth_token', value: token);

  //       Navigator.of(context).pushReplacement(
  //         // MaterialPageRoute(builder: (context) => SignInScreen()),
  //         PageTransition(
  //             child: RfkicksAnimation(targetScreen: SignInScreen()),
  //             type: PageTransitionType.rightToLeft),
  //       );
  //     } catch (e) {
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   SnackBar(content: Text('Error: ${e.toString()}')),
  //       // );
  //       CustomSnackbar.show(
  //         context: context,
  //         message: 'Error: ${e.toString()}',
  //       );
  //     } finally {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _verifyCode() async {
    if (_codeController.text.length == 6 && !_isCodeVerified) {
      try {
        final verifiedEmail = await ApiService.verifyCode(_codeController.text);
        if (verifiedEmail == widget.email) {
          setState(() {
            _isCodeVerified = true;
          });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Verification successful!')),
          // );
          CustomSnackbar.show(
            context: context,
            message: 'Verification successful!',
          );
          // Proceed to register user
          _register();
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Verification failed: Email mismatch')),
          // );
          CustomSnackbar.show(
            context: context,
            message: 'Verification failed: Email mismatch',
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${e.toString()}')),
        // );
        CustomSnackbar.show(
          context: context,
          message: 'Error: ${e.toString()}',
        );
      }
    }
  }

  Future<void> _resendCode() async {
    if (_isResendAvailable) {
      try {
        await ApiService.submitEmail(
            widget.email); // Resend using the same method
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Verification code resent!')),
        // );
        CustomSnackbar.show(
          context: context,
          message: 'Verification code resent!',
        );
        _startTimer();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resending code: ${e.toString()}')),
        );
        // CustomSnackbar.show(
        //   context: context,
        //   message: 'Error resending code: ${e.toString()}',
        // );
      }
    }
  }

  // DOB Validation
  bool _isValidDOB(DateTime date) {
    final now = DateTime.now();
    final minAge = 13; // Minimum age requirement
    final maxAge = 120; // Maximum reasonable age

    final minDate = DateTime(now.year - maxAge);
    final maxDate = DateTime(now.year - minAge);

    return date.isAfter(minDate) && date.isBefore(maxDate);
  }

  @override
  void dispose() {
    _timer.cancel();
    _codeController.removeListener(_verifyCode);
    _codeController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 36),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/header2-2-1.png',
                height: 37,
                width: 55,
              ),
              const SizedBox(height: 15),
              const Text("Now let's make you a RFK Member.",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
              const SizedBox(height: 15),

              // Verification code RichText
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'We’ve sent a code to\n',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Outfit'),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.email}  ',
                      style: TextStyle(color: Color(0xff767676)),
                    ),

                    // edit registering email
                    TextSpan(
                        text: 'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          })
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Verification Code Field
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Code',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: _isResendAvailable ? _resendCode : null,
                      child: Opacity(
                        opacity: _isResendAvailable ? 1.0 : 0.5,
                        child: Image.asset(
                          "assets/icons/ArrowsClockwise.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                enabled: !_isCodeVerified,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  if (value.length != 6) {
                    return 'The code should be 6 digits long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _isResendAvailable
                        ? 'Resend Code'
                        : 'Resend in $_timerDuration',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Name Fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First name',
                        labelStyle: TextStyle(color: Color(0xff767676)),
                        border: customBorder(),
                        enabledBorder: customBorder(),
                        focusedBorder: customBorder(),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(8),
                        //     gapPadding: 5
                        // ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        labelStyle: TextStyle(color: Color(0xff767676)),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(8),
                        //     gapPadding: 5
                        // ),
                        border: customBorder(),
                        enabledBorder: customBorder(),
                        focusedBorder: customBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                obscuringCharacter: '●',
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isLengthValid = value.length >= 8;
                    _isComplexityValid = value.contains(RegExp(r'[A-Z]')) &&
                        value.contains(RegExp(r'[a-z]')) &&
                        value.contains(RegExp(r'[0-9]'));
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!value.contains(RegExp(r'[A-Z]')) ||
                      !value.contains(RegExp(r'[a-z]')) ||
                      !value.contains(RegExp(r'[0-9]'))) {
                    return 'Password must contain uppercase, lowercase, and number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _isLengthValid
                      ? '✓ Minimum of 8 characters'
                      : 'X Minimum of 8 characters',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _isLengthValid
                          ? Color(0xff32862B)
                          : Color(0xff767676)),
                ),
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  _isComplexityValid
                      ? '✓ Uppercase, lowercase letters and one number'
                      : 'X Uppercase, lowercase letters and one number',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _isComplexityValid
                          ? Color(0xff32862B)
                          : Color(0xff767676)),
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                obscuringCharacter: '●',
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Date of Birth Picker
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now().subtract(Duration(days: 365 * 13)),
                    firstDate:
                        DateTime.now().subtract(Duration(days: 365 * 120)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xff3c76ad),
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black,
                          ),
                          dialogBackgroundColor: Colors.white,
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xff3c76ad),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    if (_isValidDOB(picked)) {
                      setState(() => _dateOfBirth = picked);
                    } else {
                      // CustomSnackbar.show(
                      //   context: context,
                      //   message:
                      //       'Please enter a valid date of birth (age 13-120)',
                      // );
                      CustomSnackbar.show(
                          context: context,
                          message:
                              'You must be at least 13 years old to create an account');
                    }
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Color(0xff767676)),
                    border: customBorder(),
                    enabledBorder: customBorder(),
                    focusedBorder: customBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateOfBirth == null
                            ? 'Date of Birth'
                            : '${_dateOfBirth!.day} ${_getMonthName(_dateOfBirth!.month)} ${_dateOfBirth!.year}',
                        style: TextStyle(
                          color: _dateOfBirth == null
                              ? Color(0xff767676)
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/CalendarBlank.png',
                        color: Colors.black,
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
              ),

              // InkWell(
              //   onTap: () async {
              //     final DateTime? picked = await showDatePicker(
              //       context: context,
              //       // initialDate: _dateOfBirth ?? DateTime.now(),
              //       // firstDate: DateTime(1900),
              //       // lastDate: DateTime.now(),
              //       initialDate:
              //           DateTime.now().subtract(Duration(days: 365 * 13)),
              //       firstDate:
              //           DateTime.now().subtract(Duration(days: 365 * 120)),
              //       lastDate: DateTime.now(),
              //     );
              //     // if (picked != null && picked != _dateOfBirth) {
              //     //   setState(() {
              //     //     _dateOfBirth = picked;
              //     //   });
              //     // }
              //     if (picked != null) {
              //       if (_isValidDOB(picked)) {
              //         setState(() => _dateOfBirth = picked);
              //       } else {
              //         CustomSnackbar.show(
              //           context: context,
              //           message:
              //               'Please enter a valid date of birth (age 13-120)',
              //         );
              //       }
              //     }
              //   },
              //   child: InputDecorator(
              //     decoration: InputDecoration(
              //       labelText: 'Date of Birth',
              //       labelStyle: TextStyle(color: Color(0xff767676)),
              //       border: customBorder(),
              //       enabledBorder: customBorder(),
              //       focusedBorder: customBorder(),
              //       // border: OutlineInputBorder(
              //       //     borderRadius: BorderRadius.circular(8),
              //       //     gapPadding: 5
              //       // ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(_dateOfBirth == null
              //             ? 'Date of Birth'
              //             : '${_dateOfBirth!.day} ${_getMonthName(_dateOfBirth!.month)} ${_dateOfBirth!.year}'),
              //         Image.asset('assets/icons/CalendarBlank.png'),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              const Text('Get a RFK Member Reward on your birthday.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),

              // Agreements
              const SizedBox(height: 40),

              // Get Updates Checkbox
              // terms and conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: _getUpdates,
                    onChanged: (value) {
                      setState(() {
                        _getUpdates = value ?? false;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                        'Sign up for emails to get updates from RFK on products, offers and your Member benefits.'),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // terms and conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value ?? false;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Expanded(
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'I agree to RFK\'s ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontFamily: 'Outfit',
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Launch privacy policy URL
                                launchUrl(Uri.parse(
                                    'https://rfkicks.com/privacy-policy'));
                              },
                          ),
                          const TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontFamily: 'Outfit',
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Launch terms of use URL
                                launchUrl(Uri.parse(
                                    'https://rfkicks.com/terms-of-use'));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // Register Button
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _isCodeVerified ? _register : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xff3c76ad),
                        foregroundColor: const Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Create Account'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }
}
