import 'package:flutter/material.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_border.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:jobtask/screens/auth/reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/header2-2-1.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(height: 20),
                Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your email to receive a password reset code",
                  style: TextStyle(
                    color: Color(0xff767676),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xff767676)),
                    border: customBorder(),
                    enabledBorder: customBorder(),
                    focusedBorder: customBorder(),
                  ),
                  validator: (value) => validateEmail(value ?? ''),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color(0xff3c76ad),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            try {
                              await ApiService.requestPasswordReset(
                                  _emailController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen(
                                    email: _emailController.text,
                                  ),
                                ),
                              );
                            } catch (e) {
                              CustomSnackbar.show(
                                context: context,
                                message: e.toString(),
                              );
                            } finally {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  child: _isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Send Reset Code',
                          style: TextStyle(color: Colors.white),
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
