
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/email_input_screen.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Future<void> _signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true; // Start loading
  //     });
  //     try {
  //       final token = await ApiService.signIn(
  //         _emailController.text,
  //         _passwordController.text,
  //       );
  //
  //       final storage = FlutterSecureStorage();
  //       await storage.write(key: 'auth_token', value: token);
  //
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: ${e.toString()}')),
  //       );
  //     } finally {
  //       setState(() {
  //         _isLoading = false; // Stop loading
  //       });
  //     }
  //   }
  // }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      // Trim the email and password inputs
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final token = await ApiService.signIn(email, password);

        final storage = FlutterSecureStorage();
        await storage.write(key: 'auth_token', value: token);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
        );
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${e.toString()}')),
        // );
        CustomSnackbar.show(
                      context: context,
                      message: 'Error: ${e.toString()}',
                    );
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/header2-2-1.png',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 15),
              const Text("Sign In to RFK",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
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
              const SizedBox(height: 25),

              // Sign In button
              // _isLoading // Show loading indicator if loading
              //     ? Center(child: CircularProgressIndicator())
              //     : ElevatedButton(
              //   onPressed: _signIn,
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.all(26),
              //     minimumSize: const Size(double.infinity, 50),
              //     backgroundColor: const Color(0xff3c76ad),
              //     foregroundColor: const Color(0xffffffff),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ), // Call _signIn function
              //   child: const Text('Sign In'),
              // ),
            ElevatedButton(
              onPressed: _isLoading ? null : _signIn, // Disable button while loading
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(26),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff3c76ad),
                foregroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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

            const SizedBox(height: 40),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Haven\'t joined us?',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),
                      TextSpan(
                        text: ' Join now',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmailInputScreen(),
                              ),
                            );
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

