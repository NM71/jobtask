
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

  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_user_profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        return json.decode(response.body)['user'];
      } else {
        throw Exception('Failed to get user profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting user profile: $e');
    }
  }

  static Future<bool> updateUserProfile(String token, Map<String, dynamic> profileData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_user_profile'),
        body: json.encode(profileData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');  // Add this line

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      print('Error updating profile: $e'); // Debug log
      throw Exception('Error updating profile: $e');
    }
  }

  // static Future<bool> updateUserProfile(String token, Map<String, dynamic> profileData) async {
  //   try {
  //     final response = await http.post(
  //         Uri.parse('$baseUrl/update_user_profile'),
  //       body: json.encode(profileData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);
  //
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to update profile: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error updating profile: $e');
  //   }
  // }

  // static Future<bool> updateUserProfile(String token, Map<String, dynamic> profileData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/update_user_profile'),
  //       body: json.encode(profileData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);
  //
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to update profile: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error updating profile: $e');
  //   }
  // }


  // static Future<bool> updateUserProfile(String token, Map<String, dynamic> profileData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/update_user_profile'),
  //       body: json.encode(profileData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);
  //
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to update profile: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error updating profile: $e');
  //   }
  // }


}