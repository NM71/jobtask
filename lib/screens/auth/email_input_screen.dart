// // lib/screens/email_input_screen.dart
// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/code_verification_screen.dart';
// import 'package:jobtask/services/api_service.dart';
//
// class EmailInputScreen extends StatefulWidget {
//   @override
//   _EmailInputScreenState createState() => _EmailInputScreenState();
// }
//
// class _EmailInputScreenState extends State<EmailInputScreen> {
//   final _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 50),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/images/header2-2-1.png',
//                   height: 50,
//                   width: 50,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   'Enter your email to join us or sign in.',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 40),
//
//             RichText(
//               text: const TextSpan(
//                 children: <TextSpan>[
//                   TextSpan(
//                       text: 'By continuing, I agree to RFK\'s \n',
//                       style: TextStyle(color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',)),
//                   TextSpan(
//                       text: 'Privacy Policy ',
//                       style: TextStyle(
//                           decoration: TextDecoration.underline,
//                           color: Color(0xff767676),
//                           fontFamily: 'OC-Regular',
//                           fontSize: 16)),
//                   TextSpan(text: ' and ', style: TextStyle(color: Color(0xff767676), fontFamily: 'OC-Regular')),
//                   TextSpan(text: 'Terms of Use. ',
//                     style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16)),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 40),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(26),
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: const Color(0xff3c76ad),
//                 foregroundColor: const Color(0xffffffff),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               onPressed: () async {
//                 if (await ApiService.submitEmail(_emailController.text)) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           CodeVerificationScreen(email: _emailController.text),
//                     ),
//                   );
//                 } else {}
//               },
//               child: const Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//






// ------------------------------------------------------------------------
// Under is the Final Code


// lib/screens/email_input_screen.dart
// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/auth/code_verification_screen.dart';
// import 'package:jobtask/services/api_service.dart';

// class EmailInputScreen extends StatefulWidget {
//   @override
//   _EmailInputScreenState createState() => _EmailInputScreenState();
// }
//
// class _EmailInputScreenState extends State<EmailInputScreen> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   // Regular expression for email validation
//   String? validateEmail(String value) {
//     final emailRegex = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     if (value.isEmpty) {
//       return "Please enter your email";
//     } else if (!emailRegex.hasMatch(value)) {
//       return "Please enter a valid email";
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Form(
//           key: _formKey, // Adding form key for validation
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/header2-2-1.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     'Enter your email to join us or sign in.',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   contentPadding:
//                       EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => validateEmail(value ?? ''),
//               ),
//               const SizedBox(height: 40),
//               RichText(
//                 text: const TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'By continuing, I agree to RFK\'s \n',
//                       style: TextStyle(
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Privacy Policy ',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' and ',
//                       style: TextStyle(
//                           color: Color(0xff767676), fontFamily: 'OC-Regular'),
//                     ),
//                     TextSpan(
//                       text: 'Terms of Use. ',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(26),
//                   minimumSize: const Size(double.infinity, 50),
//                   backgroundColor: const Color(0xff3c76ad),
//                   foregroundColor: const Color(0xffffffff),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       final success = await ApiService.submitEmail(_emailController.text);
//                       if (success) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CodeVerificationScreen(email: _emailController.text),
//                           ),
//                         );
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error: ${e.toString()}')),
//                       );
//                     }
//                   }
//                 },
//                 child: const Text('Submit'),
//
//                 // onPressed: () async {
//                 //   if (_formKey.currentState!.validate()) {
//                 //     // If email is valid, proceed to submit
//                 //     if (await ApiService.submitEmail(_emailController.text)) {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => CodeVerificationScreen(
//                 //               email: _emailController.text),
//                 //         ),
//                 //       );
//                 //     } else {
//                 //       // Handle API submission failure here
//                 //       showDialog(
//                 //         context: context,
//                 //         builder: (context) => AlertDialog(
//                 //           title: const Text('Submission Failed'),
//                 //           content: const Text('Please try again later.'),
//                 //           actions: <Widget>[
//                 //             TextButton(
//                 //               child: const Text('OK'),
//                 //               onPressed: () {
//                 //                 Navigator.of(context).pop();
//                 //               },
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       );
//                 //     }
//                 //   }
//                 // },
//                 // child: const Text('Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// ---------------------------------------------------
// Final Email Input



// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/auth/code_verification_screen.dart';
// import 'package:jobtask/services/api_service.dart';
//
// class EmailInputScreen extends StatefulWidget {
//   @override
//   _EmailInputScreenState createState() => _EmailInputScreenState();
// }
//
// class _EmailInputScreenState extends State<EmailInputScreen> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false; // Track loading state
//
//   // Regular expression for email validation
//   String? validateEmail(String value) {
//     final emailRegex = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     if (value.isEmpty) {
//       return "Please enter your email";
//     } else if (!emailRegex.hasMatch(value)) {
//       return "Please enter a valid email";
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/header2-2-1.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Enter your email to join us or sign in.',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) => validateEmail(value ?? ''),
//               ),
//               const SizedBox(height: 40),
//               RichText(
//                 text: const TextSpan(
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: 'By continuing, I agree to RFK\'s \n',
//                       style: TextStyle(
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Privacy Policy ',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' and ',
//                       style: TextStyle(
//                           color: Color(0xff767676), fontFamily: 'OC-Regular'),
//                     ),
//                     TextSpan(
//                       text: 'Terms of Use. ',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color(0xff767676),
//                         fontFamily: 'OC-Regular',
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(26),
//                   minimumSize: const Size(double.infinity, 50),
//                   backgroundColor: const Color(0xff3c76ad),
//                   foregroundColor: const Color(0xffffffff),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: _isLoading ? null : () async { // Disable button when loading
//                   setState(() {
//                     _isLoading = true; // Start loading
//                   });
//
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       final success = await ApiService.submitEmail(_emailController.text);
//                       if (success) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CodeVerificationScreen(email: _emailController.text),
//                           ),
//                         );
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error: ${e.toString()}')),
//                       );
//                     } finally {
//                       setState(() {
//                         _isLoading = false; // Stop loading
//                       });
//                     }
//                   } else {
//                     setState(() {
//                       _isLoading = false; // Stop loading if validation fails
//                     });
//                   }
//                 },
//                 child: _isLoading
//                     ? const SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                     strokeWidth: 2.0,
//                   ),
//                 )
//                     : const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/registration_form_screen.dart';
import 'package:jobtask/services/api_service.dart';

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
      return "Please enter your email";
    } else if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/header2-2-1.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your email to join us or sign in.',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => validateEmail(value ?? ''),
              ),
              const SizedBox(height: 40),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'By continuing, I agree to RFK\'s \n',
                      style: TextStyle(
                        color: Color(0xff767676),
                        fontFamily: 'OC-Regular',
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy ',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff767676),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(
                          color: Color(0xff767676), fontFamily: 'OC-Regular'),
                    ),
                    TextSpan(
                      text: 'Terms of Use. ',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff767676),
                        fontFamily: 'OC-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(26),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff3c76ad),
                  foregroundColor: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _isLoading ? null : () async {
                  setState(() {
                    _isLoading = true; // Start loading
                  });

                  if (_formKey.currentState!.validate()) {
                    try {
                      final success = await ApiService.submitEmail(_emailController.text);
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationFormScreen(email: _emailController.text),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false; // Stop loading
                      });
                    }
                  } else {
                    setState(() {
                      _isLoading = false; // Stop loading if validation fails
                    });
                  }
                },
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                )
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
