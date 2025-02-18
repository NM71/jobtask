import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_border.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isLengthValid = false;
  bool _isComplexityValid = false;

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
        padding: EdgeInsets.all(30.0),
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
              SizedBox(height: 40),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Reset Code',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Enter reset code' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.length < 6) {
                //     return 'Password too short';
                //   }
                //   return null;
                // },
                // In the TextFormField for new password:
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
              SizedBox(height: 20),
              // Add these widgets below the password field:
              Text(
                _isLengthValid
                    ? '✓ Minimum of 8 characters'
                    : 'X Minimum of 8 characters',
                style: TextStyle(
                    color:
                        _isLengthValid ? Color(0xff32862B) : Color(0xff767676)),
              ),
              Text(
                _isComplexityValid
                    ? '✓ Uppercase, lowercase letters and one number'
                    : 'X Uppercase, lowercase letters and one number',
                style: TextStyle(
                    color: _isComplexityValid
                        ? Color(0xff32862B)
                        : Color(0xff767676)),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Color(0xff767676)),
                  border: customBorder(),
                  enabledBorder: customBorder(),
                  focusedBorder: customBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () => setState(() =>
                        _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                validator: (value) => value != _passwordController.text
                    ? 'Passwords do not match'
                    : null,
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
                            await ApiService.resetPassword(
                              widget.email,
                              _codeController.text,
                              _passwordController.text,
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                              (route) => false,
                            );
                            CustomSnackbar.show(
                              context: context,
                              message: 'Password reset successful',
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
                        'Reset Password',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
