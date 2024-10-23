// // lib/services/api_service.dart
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   static const String baseUrl = 'https://rfkicks.com/api';
//
//   static Future<bool> submitEmail(String email) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/submit-email'),
//       body: {'email': email},
//     );
//
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Exception('Failed to submit email');
//     }
//   }
//
//   static Future<bool> verifyCode(String email, String code) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/verify-code'),
//       body: {'email': email, 'code': code},
//     );
//
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Exception('Failed to verify code');
//     }
//   }
//
//   static Future<bool> registerUser(Map<String, dynamic> userData) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       body: json.encode(userData),
//       headers: {'Content-Type': 'application/json'},
//     );
//
//     if (response.statusCode == 201) {
//       return true;
//     } else {
//       throw Exception('Failed to register user');
//     }
//   }
// }
























































//---------------------------------------------------------
// 04-10-24 :  03:45 PM code (latest)

// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// // class ApiService {
// //   static const String baseUrl = 'https://rfkicks.com/api';
// //
// //   static Future<bool> submitEmail(String email) async {
// //     final response = await http.post(
// //       Uri.parse('$baseUrl/submit_email.php'),
// //       body: json.encode({'email': email}),
// //       headers: {'Content-Type': 'application/json'},
// //     );
// //
// //     if (response.statusCode == 200) {
// //       return true;
// //     } else {
// //       throw Exception('Failed to submit email: ${response.body}');
// //     }
// //   }
//
// class ApiService {
//   static const String baseUrl = 'https://rfkicks.com/api';
//   static const Duration timeoutDuration = Duration(seconds: 10);
//
//   static Future<bool> submitEmail(String email) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/submit_email'),
//         body: json.encode({'email': email}),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(timeoutDuration);
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception('Failed to submit email: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error submitting email: $e');
//     }
//   }
//
//   static Future<bool> verifyCode(String email, String code) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/verify_code.php'),
//       body: json.encode({'email': email, 'code': code}),
//       headers: {'Content-Type': 'application/json'},
//     );
//
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw Exception('Failed to verify code: ${response.body}');
//     }
//   }
//
//   static Future<String> registerUser(Map<String, dynamic> userData) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register.php'),
//       body: json.encode(userData),
//       headers: {'Content-Type': 'application/json'},
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['token'];
//     } else {
//       throw Exception('Failed to register user: ${response.body}');
//     }
//   }
// }

//---------------------------------------------------------------------------------------------


















// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
//
// class ApiService {
//   // Update this base URL to match your actual domain and path to API files
//   static const String baseUrl = 'https://rfkicks.com/api';
//
//   static Future<bool> submitEmail(String email) async {
//     try {
//       // Ensure this matches the actual filename on your server
//       final response = await http.post(
//         Uri.parse('$baseUrl/submit_email.php'),
//         body: json.encode({'email': email}),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception('Failed to submit email: ${response.body}');
//       }
//     } on SocketException catch (e) {
//       throw Exception('Network error: Unable to connect to the server. Please check your internet connection and try again.');
//     } catch (e) {
//       throw Exception('An unexpected error occurred: ${e.toString()}');
//     }
//   }
//
//   static Future<bool> verifyCode(String email, String code) async {
//     try {
//       // Ensure this matches the actual filename on your server
//       final response = await http.post(
//         Uri.parse('$baseUrl/verify_code.php'),
//         body: json.encode({'email': email, 'code': code}),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception('Failed to verify code: ${response.body}');
//       }
//     } on SocketException catch (e) {
//       throw Exception('Network error: Unable to connect to the server. Please check your internet connection and try again.');
//     } catch (e) {
//       throw Exception('An unexpected error occurred: ${e.toString()}');
//     }
//   }
//
//   static Future<String> registerUser(Map<String, dynamic> userData) async {
//     try {
//       // Ensure this matches the actual filename on your server
//       final response = await http.post(
//         Uri.parse('$baseUrl/register.php'),
//         body: json.encode(userData),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['token'];
//       } else {
//         throw Exception('Failed to register user: ${response.body}');
//       }
//     } on SocketException catch (e) {
//       throw Exception('Network error: Unable to connect to the server. Please check your internet connection and try again.');
//     } catch (e) {
//       throw Exception('An unexpected error occurred: ${e.toString()}');
//     }
//   }
// }






























// -----------------------------------------------------------------

//-------------------------------------------------------
// 04-10-24  :  04:07 PM (latest after change in verification method)
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   static const String baseUrl = 'https://rfkicks.com/api';
//   static const Duration timeoutDuration = Duration(seconds: 10);
//
//   static Future<bool> submitEmail(String email) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/submit_email'),
//         body: json.encode({'email': email}),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(timeoutDuration);
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception('Failed to submit email: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error submitting email: $e');
//     }
//   }
//
//   static Future<String> verifyCode(String code) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/verify_code'),
//         body: json.encode({'code': code}),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(timeoutDuration);
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['email'];
//       } else {
//         throw Exception('Failed to verify code: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error verifying code: $e');
//     }
//   }
//
//   static Future<String> registerUser(Map<String, dynamic> userData) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/register'),
//         body: json.encode(userData),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(timeoutDuration);
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['token'];
//       } else {
//         throw Exception('Failed to register user: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error registering user: $e');
//     }
//   }
// }



















//------------------------------------------------------------------------

// changing the code

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://rfkicks.com/api';
  static const Duration timeoutDuration = Duration(seconds: 10);

  static Future<bool> submitEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit_email'),
        body: json.encode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to submit email: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error submitting email: $e');
    }
  }

  static Future<String> verifyCode(String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify_code'),
        body: json.encode({'code': code}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['email'];
      } else {
        throw Exception('Failed to verify code: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying code: $e');
    }
  }

  static Future<String> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['token'];
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }
  static Future<String> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sign_in'),
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['token'];
      } else {
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  static Future<bool> validateToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/validate_token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error validating token: $e');
      return false;
    }
  }
}