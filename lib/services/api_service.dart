// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'YOUR_API_BASE_URL';

  static Future<bool> submitEmail(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit-email'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to submit email');
    }
  }

  static Future<bool> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-code'),
      body: {'email': email, 'code': code},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to verify code');
    }
  }

  static Future<bool> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }
}