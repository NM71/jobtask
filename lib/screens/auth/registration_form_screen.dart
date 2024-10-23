// // lib/screens/registration_form_screen.dart
// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/dashboard_screen.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
//
// class RegistrationFormScreen extends StatefulWidget {
//   final String email;
//   final TextEditingController code;
//
//   RegistrationFormScreen({required this.email, required this.code});
//
//   @override
//   _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
// }
//
// class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _surnameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   DateTime? _dateOfBirth;
//   bool _obscurePassword = true;
//
//
//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final userData = {
//           'email': widget.email,
//           'firstName': _firstNameController.text,
//           'surname': _surnameController.text,
//           'password': _passwordController.text,
//           'dateOfBirth': _dateOfBirth!.toIso8601String(),
//         };
//
//         final token = await ApiService.registerUser(userData);
//
//         final storage = FlutterSecureStorage();
//         await storage.write(key: 'auth_token', value: token);
//
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Registration failed: ${e.toString()}'),
//             duration: Duration(seconds: 5),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(40.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               Image.asset(
//                 'assets/images/header2-2-1.png',
//                 height: 50,
//                 width: 50,
//               ),
//               const SizedBox(height: 15),
//               const Text("Now let's make you a RFK Member.",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Code',
//                   hintText: ,
//                   contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.refresh),
//                 ),
//                 readOnly: true,
//               ),
//               Container(
//                 child: const Text(
//                   'Resend in timer',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 alignment: const Alignment(1, 0),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _firstNameController,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 10),
//                         labelText: 'First name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your first name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _surnameController,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 10),
//                         labelText: 'Surname',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your surname';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   labelText: 'Password',
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscurePassword
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password must be at least 8 characters long';
//                   }
//                   if (!value.contains(RegExp(r'[A-Z]')) ||
//                       !value.contains(RegExp(r'[a-z]')) ||
//                       !value.contains(RegExp(r'[0-9]'))) {
//                     return 'Password must contain uppercase, lowercase, and number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Text('✓ Minimum of 8 characters',
//                   style: TextStyle(color: Colors.green)),
//               const Text(
//                 '✓ Uppercase, lowercase letters and one number',
//                 style: TextStyle(color: Colors.green),
//               ),
//               const SizedBox(height: 20),
//               InkWell(
//                 onTap: () async {
//                   final DateTime? picked = await showDatePicker(
//                     context: context,
//                     initialDate: _dateOfBirth ?? DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (picked != null && picked != _dateOfBirth) {
//                     setState(() {
//                       _dateOfBirth = picked;
//                     });
//                   }
//                 },
//                 child: InputDecorator(
//                   decoration: const InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                     labelText: 'Date of Birth',
//                     border: OutlineInputBorder(),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(_dateOfBirth == null
//                           ? 'Date of Birth'
//                           : '${_dateOfBirth!.day} ${_getMonthName(_dateOfBirth!.month)} ${_dateOfBirth!.year}'),
//                       const Icon(Icons.calendar_today),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text('Get a RFK Member Reward on your birthday.',
//                   style: TextStyle(color: Colors.grey)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 // onPressed: () async {
//                 //   if (_formKey.currentState!.validate()) {
//                 //     try {
//                 //       final userData = {
//                 //         'email': widget.email,
//                 //         'firstName': _firstNameController.text,
//                 //         'surname': _surnameController.text,
//                 //         'password': _passwordController.text,
//                 //         'dateOfBirth': _dateOfBirth!.toIso8601String(),
//                 //       };
//                 //       final token = await ApiService.registerUser(userData);
//                 //
//                 //       final storage = FlutterSecureStorage();
//                 //       await storage.write(key: 'auth_token', value: token);
//                 //
//                 //       // Store the token securely (e.g., using flutter_secure_storage)
//                 //       // Then navigate to the main app screen or dashboard
//                 //       Navigator.of(context).pushReplacement(
//                 //         MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
//                 //       );
//                 //     } catch (e) {
//                 //       ScaffoldMessenger.of(context).showSnackBar(
//                 //         SnackBar(content: Text('Error: ${e.toString()}')),
//                 //       );
//                 //     }
//                 //   }
//                 // },
//                 onPressed: _register,
//                 child: Text('Register'),
//
//                 // onPressed: () async {
//                 //   if (_formKey.currentState!.validate()) {
//                 //     final userData = {
//                 //       'firstName': _firstNameController.text,
//                 //       'surname': _surnameController.text,
//                 //       'password': _passwordController.text,
//                 //       'dateOfBirth': _dateOfBirth!.toIso8601String(),
//                 //     };
//                 //     if (await ApiService.registerUser(userData)) {
//                 //       Navigator.pushNamed(context, '/confirm');
//                 //     } else {
//                 //       // Show error message
//                 //     }
//                 //   }
//                 // },
//                 style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(26),
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: const Color(0xff3c76ad),
//                     foregroundColor: const Color(0xffffffff),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 // child: const Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _getMonthName(int month) {
//     const monthNames = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec"
//     ];
//     return monthNames[month - 1];
//   }
// }












//---------------------------------------------------------------------

// lib/screens/registration_form_screen.dart
// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/dashboard_screen.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
//
// class RegistrationFormScreen extends StatefulWidget {
//
//   final String email;
//
//   RegistrationFormScreen({required this.email});
//
//   @override
//   _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
// }
//
// class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _surnameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   DateTime? _dateOfBirth;
//   bool _obscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(40.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               Image.asset(
//                 'assets/images/header2-2-1.png',
//                 height: 50,
//                 width: 50,
//               ),
//               const SizedBox(height: 15),
//               const Text("Now let's make you a RFK Member.",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Code',
//                   contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.refresh),
//                 ),
//                 readOnly: true,
//               ),
//               Container(
//                 child: const Text(
//                   'Resend in timer',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 alignment: const Alignment(1, 0),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _firstNameController,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 10),
//                         labelText: 'First name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your first name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _surnameController,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.only(left: 10),
//                         labelText: 'Surname',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your surname';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                   labelText: 'Password',
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscurePassword
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password must be at least 8 characters long';
//                   }
//                   if (!value.contains(RegExp(r'[A-Z]')) ||
//                       !value.contains(RegExp(r'[a-z]')) ||
//                       !value.contains(RegExp(r'[0-9]'))) {
//                     return 'Password must contain uppercase, lowercase, and number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               const Text('✓ Minimum of 8 characters',
//                   style: TextStyle(color: Colors.green)),
//               const Text(
//                 '✓ Uppercase, lowercase letters and one number',
//                 style: TextStyle(color: Colors.green),
//               ),
//               const SizedBox(height: 20),
//               InkWell(
//                 onTap: () async {
//                   final DateTime? picked = await showDatePicker(
//                     context: context,
//                     initialDate: _dateOfBirth ?? DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (picked != null && picked != _dateOfBirth) {
//                     setState(() {
//                       _dateOfBirth = picked;
//                     });
//                   }
//                 },
//                 child: InputDecorator(
//                   decoration: const InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                     labelText: 'Date of Birth',
//                     border: OutlineInputBorder(),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(_dateOfBirth == null
//                           ? 'Date of Birth'
//                           : '${_dateOfBirth!.day} ${_getMonthName(_dateOfBirth!.month)} ${_dateOfBirth!.year}'),
//                       const Icon(Icons.calendar_today),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text('Get a RFK Member Reward on your birthday.',
//                   style: TextStyle(color: Colors.grey)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       final userData = {
//                         'email': widget.email,
//                         'firstName': _firstNameController.text,
//                         'surname': _surnameController.text,
//                         'password': _passwordController.text,
//                         'dateOfBirth': _dateOfBirth!.toIso8601String(),
//                       };
//                       final token = await ApiService.registerUser(userData);
//
//                       final storage = FlutterSecureStorage();
//                       await storage.write(key: 'auth_token', value: token);
//
//                       // Store the token securely (e.g., using flutter_secure_storage)
//                       // Then navigate to the main app screen or dashboard
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => DashboardScreen(token: token)),
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Error: ${e.toString()}')),
//                       );
//                     }
//                   }
//                 },
//                 child: Text('Register'),
//
//                 // onPressed: () async {
//                 //   if (_formKey.currentState!.validate()) {
//                 //     final userData = {
//                 //       'firstName': _firstNameController.text,
//                 //       'surname': _surnameController.text,
//                 //       'password': _passwordController.text,
//                 //       'dateOfBirth': _dateOfBirth!.toIso8601String(),
//                 //     };
//                 //     if (await ApiService.registerUser(userData)) {
//                 //       Navigator.pushNamed(context, '/confirm');
//                 //     } else {
//                 //       // Show error message
//                 //     }
//                 //   }
//                 // },
//                 style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.all(26),
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: const Color(0xff3c76ad),
//                     foregroundColor: const Color(0xffffffff),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 // child: const Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _getMonthName(int month) {
//     const monthNames = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec"
//     ];
//     return monthNames[month - 1];
//   }
// }

//--------------------------------------------------------------------------------








import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegistrationFormScreen extends StatefulWidget {
  final String email;

  RegistrationFormScreen({required this.email});

  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _dateOfBirth;
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userData = {
          'email': widget.email,
          'firstName': _firstNameController.text,
          'surname': _surnameController.text,
          'password': _passwordController.text,
          'dateOfBirth': _dateOfBirth!.toIso8601String(),
        };
        final token = await ApiService.registerUser(userData);

        final storage = FlutterSecureStorage();
        await storage.write(key: 'auth_token', value: token);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Code',
                  contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.refresh),
                ),
                readOnly: true,
              ),
              Container(
                child: const Text(
                  'Resend in timer',
                  style: const TextStyle(color: Colors.grey),
                ),
                alignment: const Alignment(1, 0),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
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
                        contentPadding: EdgeInsets.only(left: 10),
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
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
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
              const Text('✓ Minimum of 8 characters',
                  style: TextStyle(color: Colors.green)),
              const Text(
                '✓ Uppercase, lowercase letters and one number',
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 20),
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
                    contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
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
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(26),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xff3c76ad),
                  foregroundColor: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return monthNames[month - 1];
  }
}