import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

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

  Future<void> _register() async {
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
          MaterialPageRoute(builder: (context) => SignInScreen()),
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
          _isLoading = false;
        });
      }
    }
  }

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
        await ApiService.submitEmail(widget.email); // Resend using the same method
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Verification code resent!')),
        // );
        CustomSnackbar.show(
          context: context,
          message: 'Verification code resent!',
        );
        _startTimer();
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error resending code: ${e.toString()}')),
        // );
        CustomSnackbar.show(
          context: context,
          message: 'Error resending code: ${e.toString()}',
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _codeController.removeListener(_verifyCode);
    _codeController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              const Text("Now let's make you a RFK Member.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Verification Code Field
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _isResendAvailable ? _resendCode : null,
                  ),
                ),
                keyboardType: TextInputType.number,
                enabled: !_isCodeVerified, // Disable if code is verified
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
              const SizedBox(height: 10),
              Text(
                _isResendAvailable
                    ? 'You can resend the code'
                    : 'Resend available in $_timerDuration seconds',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),

              // Name Fields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First name',
                        border: OutlineInputBorder(),
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
                      decoration: const InputDecoration(
                        labelText: 'Surname',
                        border: OutlineInputBorder(),
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
              const SizedBox(height: 10),
              Text(
                '✓ Minimum of 8 characters',
                style: TextStyle(color: _isLengthValid ? Colors.green : Colors.red),
              ),
              Text(
                '✓ Uppercase, lowercase letters and one number',
                style: TextStyle(color: _isComplexityValid ? Colors.green : Colors.red),
              ),
              const SizedBox(height: 20),

              // Date of Birth Picker
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _dateOfBirth) {
                    setState(() {
                      _dateOfBirth = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_dateOfBirth == null
                          ? 'Date of Birth'
                          : '${_dateOfBirth!.day} ${_getMonthName(_dateOfBirth!.month)} ${_dateOfBirth!.year}'),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Get a RFK Member Reward on your birthday.',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // Register Button
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _isCodeVerified ? _register : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(26),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff3c76ad),
                  foregroundColor: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Verify and Register'),
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
