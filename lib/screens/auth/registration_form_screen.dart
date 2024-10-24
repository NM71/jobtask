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
// Final Code


// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/auth/sign_in_screen.dart';
// import 'package:jobtask/screens/dashboard_screen.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class RegistrationFormScreen extends StatefulWidget {
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
//   bool _isLoading = false;
//
//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//       try {
//         final userData = {
//           'email': widget.email,
//           'firstName': _firstNameController.text,
//           'surname': _surnameController.text,
//           'password': _passwordController.text,
//           'dateOfBirth': _dateOfBirth!.toIso8601String(),
//         };
//         final token = await ApiService.registerUser(userData);
//
//         final storage = FlutterSecureStorage();
//         await storage.write(key: 'auth_token', value: token);
//
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => SignInScreen()),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
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
//               _isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : ElevatedButton(
//                 onPressed: _register,
//                 child: Text('Register'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(26),
//                   minimumSize: const Size(double.infinity, 50),
//                   backgroundColor: const Color(0xff3c76ad),
//                   foregroundColor: const Color(0xffffffff),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
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
          'email': widget.email,
          'firstName': _firstNameController.text,
          'surname': _surnameController.text,
          'password': _passwordController.text,
          'dateOfBirth': _dateOfBirth!.toIso8601String(),
        };
        final token = await ApiService.registerUser(userData);

        final storage = const FlutterSecureStorage();
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

  Future<void> _verifyCode() async {
    if (_codeController.text.length == 6 && !_isCodeVerified) {
      try {
        final verifiedEmail = await ApiService.verifyCode(_codeController.text);
        if (verifiedEmail == widget.email) {
          setState(() {
            _isCodeVerified = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification successful!')),
          );
          // Proceed to register user
          _register();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification failed: Email mismatch')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _resendCode() async {
    if (_isResendAvailable) {
      try {
        await ApiService.submitEmail(widget.email); // Resend using the same method
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification code resent!')),
        );
        _startTimer();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resending code: ${e.toString()}')),
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
