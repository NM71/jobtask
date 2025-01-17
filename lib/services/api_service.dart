import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jobtask/models/order_receipt.dart';
import 'package:jobtask/models/saved_card.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
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
      );

      if (response.statusCode == 409) {
        throw Exception('Email already registered');
      }

      final data = json.decode(response.body);
      if (data['token'] != null) {
        return data['token'];
      } else {
        throw Exception('Registration failed: ${data['error']}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  // static Future<String> registerUser(Map<String, dynamic> userData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/register'),
  //       body: json.encode(userData),
  //       headers: {'Content-Type': 'application/json'},
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data['token'];
  //     } else {
  //       throw Exception('Failed to register user: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error registering user: $e');
  //   }
  // }

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

  // Onboarding
  static Future<bool> checkOnboardingStatus(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_user_profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      // print('Full response: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userProfile = data['user'];

        // print(
        //     'Onboarding status: ${userProfile['onboarding_completed']}'); // Debug print

        return userProfile['onboarding_completed'] == 1 ||
            userProfile['onboarding_completed'] == '1' ||
            userProfile['onboarding_completed'] == true;
      }
      return false;
    } catch (e) {
      print('Error checking onboarding status: $e');
      return false;
    }
  }

  // static Future<bool> checkOnboardingStatus(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_user_profile'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final userProfile = data['user'];

  //       // Check if shoe_size exists as that indicates onboarding completion
  //       return userProfile['shoe_size'] != null &&
  //           userProfile['shoe_size'].isNotEmpty;
  //     }
  //     return false;
  //   } catch (e) {
  //     print('Error checking onboarding status: $e');
  //     return false;
  //   }
  // }

  // static Future<bool> checkOnboardingStatus(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_user_profile'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final profileData = data['user_profile'];
  //       return profileData['onboarding_completed'] == '1' ||
  //           profileData['onboarding_completed'] == 1;
  //     }
  //     return false;
  //   } catch (e) {
  //     print('Error checking onboarding status: $e');
  //     return false;
  //   }
  // }
  // static Future<bool> checkOnboardingStatus(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_user_profile'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body)['user'];
  //       return data['onboarding_completed'] == true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print('Error checking onboarding status: $e');
  //     return false;
  //   }
  // }

  static Future<bool> completeOnboarding(
      String token, Map<String, dynamic> onboardingData) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/update_user_profile'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              'shoe_size': onboardingData['shoe_size'].toString(),
              'preferences': json.encode({
                'category': onboardingData['category'],
              }),
              'onboarding_completed': '1'
            }),
          )
          .timeout(timeoutDuration);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error completing onboarding: $e');
      return false;
    }
  }

  // static Future<bool> completeOnboarding(
  //     String token, Map<String, dynamic> onboardingData) async {
  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('$baseUrl/update_user_profile'),
  //     );

  //     request.headers['Authorization'] = 'Bearer $token';

  //     // Add onboarding data
  //     request.fields['shoe_size'] = onboardingData['shoe_size'].toString();
  //     request.fields['preferences'] = json.encode({
  //       'category': onboardingData['category'],
  //     });
  //     request.fields['onboarding_completed'] = 'true';

  //     var response = await request.send();
  //     var responseData = await response.stream.bytesToString();
  //     var jsonResponse = json.decode(responseData);

  //     return jsonResponse['success'] == true;
  //   } catch (e) {
  //     print('Error completing onboarding: $e');
  //     return false;
  //   }
  // }

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

  // static Future<bool> updateUserProfile(
  //     String token, Map<String, dynamic> profileData) async {
  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('$baseUrl/update_user_profile'),
  //     );

  //     // Add authorization header
  //     request.headers['Authorization'] = 'Bearer $token';

  //     // Add file if exists
  //     if (profileData.containsKey('profile_picture')) {
  //       File imageFile = File(profileData['profile_picture']);
  //       var stream = http.ByteStream(imageFile.openRead());
  //       var length = await imageFile.length();

  //       var multipartFile = http.MultipartFile(
  //           'profile_picture', stream, length,
  //           filename: imageFile.path.split('/').last);

  //       request.files.add(multipartFile);
  //       profileData.remove('profile_picture'); // Remove from regular fields
  //     }

  //     // Add other fields
  //     profileData.forEach((key, value) {
  //       request.fields[key] = value.toString();
  //     });

  //     var response = await request.send();
  //     var responseData = await response.stream.bytesToString();
  //     var jsonResponse = json.decode(responseData);

  //     return jsonResponse['success'] == true;
  //   } catch (e) {
  //     print('Error updating profile: $e');
  //     return false;
  //   }
  // }
  static Future<bool> updateUserProfile(
      String token, Map<String, dynamic> profileData) async {
    try {
      if (kDebugMode) {
        print('Starting profile update with data: $profileData');
      } // Debug data being sent

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/update_user_profile.php'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      if (kDebugMode) {
        print('Request URL: ${request.url}');
        print('Request headers: ${request.headers}');
      } // Debug URL
      // Debug headers

      profileData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (kDebugMode) {
        print('Request fields: ${request.fields}');
      } // Debug fields being sent

      var response = await request.send();
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      } // Debug response status

      var responseData = await response.stream.bytesToString();
      if (kDebugMode) {
        print('Response data: $responseData');
      } // Debug response data

      if (responseData.isNotEmpty) {
        var jsonResponse = json.decode(responseData);
        if (kDebugMode) {
          print('Parsed response: $jsonResponse');
        } // Debug parsed response
        return jsonResponse['success'] == true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Update error: $e');
      } // Debug any errors
      return false;
    }
  }

  // static Future<bool> updateUserProfile(
  //     String token, Map<String, dynamic> profileData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/update_user_profile'),
  //       body: json.encode(profileData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}'); // Add this line

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to update profile: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error updating profile: $e'); // Debug log
  //     throw Exception('Error updating profile: $e');
  //   }
  // }

  static Future<Map<String, List<Service>>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_services.php'),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final servicesData = data['data'];
          return {
            'main': (servicesData['main'] as List)
                .map((service) => Service.fromJson(service))
                .toList(),
            'individual': (servicesData['individual'] as List)
                .map((service) => Service.fromJson(service))
                .toList(),
          };
        } else {
          throw Exception('Failed to load services: ${data['message']}');
        }
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error loading services: $e');
    }
  }

  // delete account
  static Future<bool> deleteAccount(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_account.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == 'success') {
        return true;
      } else {
        // Log the error message
        print(
            'Delete account error: ${responseBody['error'] ?? 'Unknown error'}');
        return false;
      }
    } catch (e) {
      print('Exception in deleteAccount: $e');
      return false;
    }
  }

  // Forget password
  static Future<void> requestPasswordReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forgot_password.php'),
        body: json.encode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      if (response.statusCode != 200 || data['status'] == 'error') {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception('Failed to request password reset: $e');
    }
  }

  static Future<void> resetPassword(
      String email, String code, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset_password.php'),
        body: json.encode({
          'email': email,
          'code': code,
          'new_password': newPassword,
        }),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      if (response.statusCode != 200 || data['status'] == 'error') {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  // Add these methods to your existing ApiService class

  static Future<Map<String, dynamic>> getDeliveryAddress(
      String token, int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/handle_delivery_address.php?user_id=$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return data['data'];
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception('Error fetching delivery address: $e');
    }
  }

  static Future<bool> saveDeliveryAddress(
      String token, Map<String, dynamic> addressData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/handle_delivery_address.php'),
        body: json.encode(addressData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      return data['status'] == 'success';
    } catch (e) {
      throw Exception('Error saving delivery address: $e');
    }
  }

  // Stripe Methods

  // static Future<Map<String, String>> createPaymentIntent(
  //     String token, Map<String, dynamic> paymentData) async {
  //   try {
  //     print('Sending payment request to: $baseUrl/handle_payment.php');
  //     print('Request body: ${json.encode(paymentData)}');

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/handle_payment.php'),
  //       body: json.encode(paymentData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     final data = json.decode(response.body);
  //     return {
  //       'clientSecret': data['clientSecret'],
  //       'orderId': data['order_id'].toString()
  //     };
  //   } catch (e) {
  //     print('Payment creation error details: $e');
  //     throw Exception('Error creating payment: $e');
  //   }
  // }
  // static Future<Map<String, String>> createPaymentIntent(
  //     String token, Map<String, dynamic> paymentData) async {
  //   try {
  //     // Add detailed service information to the payment data
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     final enhancedPaymentData = {
  //       ...paymentData,
  //       'services_details': servicesData,
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/handle_payment.php'),
  //       body: json.encode(enhancedPaymentData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     final data = json.decode(response.body);
  //     return {
  //       'clientSecret': data['clientSecret'],
  //       'orderId': data['order_id'].toString()
  //     };
  //   } catch (e) {
  //     throw Exception('Error creating payment: $e');
  //   }
  // }
  // -------------------------------------------------------------
  static Future<Map<String, String>> createPaymentIntent(
      String token, Map<String, dynamic> paymentData) async {
    try {
      final servicesData = paymentData['cart_items']
          .map((item) => {
                'service_id': item['product_id'],
                'quantity': item['quantity'],
                'price': item['price'],
                'total_amount': (item['quantity'] * item['price']),
              })
          .toList();

      final addressData = {
        'address_type': 'shipping',
        'first_name': paymentData['shipping_first_name'],
        'last_name': paymentData['shipping_last_name'],
        'address_1': paymentData['shipping_address_1'],
        'address_2': paymentData['shipping_address_2'],
        'city': paymentData['shipping_city'],
        'state': paymentData['shipping_state'],
        'postcode': paymentData['shipping_postcode'],
        'country': paymentData['shipping_country'],
        'email': paymentData['email'],
        'phone': paymentData['shipping_phone'],
      };

      final enhancedPaymentData = {
        ...paymentData,
        'services_details': servicesData,
        'shipping_address': addressData,
        'delivery_type': paymentData['delivery_type'],
        'payment_method_type': 'card',
        'use_saved_card': paymentData['payment_method'] != null,
        'off_session': paymentData['payment_method'] != null,
        'confirm': paymentData['payment_method'] != null,
      };

      print(
          'Creating payment intent with data: ${json.encode(enhancedPaymentData)}');

      final response = await http.post(
        Uri.parse('$baseUrl/create_payment_intent.php'),
        body: json.encode(enhancedPaymentData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final data = json.decode(response.body);
      return {
        'clientSecret': data['clientSecret'],
        'paymentIntentId': data['payment_intent_id']
      };
    } catch (e) {
      print('Payment creation error details: $e');
      throw Exception('Error creating payment: $e');
    }
  }

  // -------------------------------------------------------------
  // static Future<Map<String, String>> createPaymentIntent(
  //     String token, Map<String, dynamic> paymentData) async {
  //   try {
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     final addressData = {
  //       'address_type': 'shipping',
  //       'first_name': paymentData['shipping_first_name'],
  //       'last_name': paymentData['shipping_last_name'],
  //       'address_1': paymentData['shipping_address_1'],
  //       'address_2': paymentData['shipping_address_2'],
  //       'city': paymentData['shipping_city'],
  //       'state': paymentData['shipping_state'],
  //       'postcode': paymentData['shipping_postcode'],
  //       'country': paymentData['shipping_country'],
  //       'email': paymentData['email'],
  //       'phone': paymentData['shipping_phone'],
  //     };

  //     final enhancedPaymentData = {
  //       ...paymentData,
  //       'services_details': servicesData,
  //       'shipping_address': addressData,
  //       'delivery_type': paymentData['delivery_type'],
  //       'payment_method_type': 'card',
  //       'off_session': paymentData['use_saved_card'] == true,
  //       'confirm': paymentData['use_saved_card'] == true,
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/create_payment_intent.php'),
  //       body: json.encode(enhancedPaymentData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response Status: ${response.statusCode}');
  //     print('Response Body: ${response.body}');

  //     final data = json.decode(response.body);
  //     return {
  //       'clientSecret': data['clientSecret'],
  //       'paymentIntentId': data['payment_intent_id']
  //     };
  //   } catch (e) {
  //     throw Exception('Error creating payment: $e');
  //   }
  // }
  // -------------------------------------------------------------
  // static Future<Map<String, String>> createPaymentIntent(
  //     String token, Map<String, dynamic> paymentData) async {
  //   try {
  //     // Add detailed service information to the payment data
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     // Add address data structure
  //     final addressData = {
  //       'address_type': 'shipping',
  //       'first_name': paymentData['shipping_first_name'],
  //       'last_name': paymentData['shipping_last_name'],
  //       'address_1': paymentData['shipping_address_1'],
  //       'address_2': paymentData['shipping_address_2'],
  //       'city': paymentData['shipping_city'],
  //       'state': paymentData['shipping_state'],
  //       'postcode': paymentData['shipping_postcode'],
  //       'country': paymentData['shipping_country'],
  //       'email': paymentData['email'],
  //       'phone': paymentData['shipping_phone'],
  //     };

  //     final enhancedPaymentData = {
  //       ...paymentData,
  //       'services_details': servicesData,
  //       'shipping_address': addressData,
  //       'delivery_type': paymentData['delivery_type'],
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/create_payment_intent.php'),
  //       body: json.encode(enhancedPaymentData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response Status: ${response.statusCode}');
  //     print('Response Body: ${response.body}');

  //     final data = json.decode(response.body);
  //     return {
  //       'clientSecret': data['clientSecret'],
  //       'paymentIntentId': data['payment_intent_id']
  //     };
  //   } catch (e) {
  //     throw Exception('Error creating payment: $e');
  //   }
  // }
// ---------------------------------------------------
  // static Future<String> createOrder(String token, String paymentIntentId,
  //     Map<String, dynamic> paymentData) async {
  //   try {
  //     // Add detailed service information to the payment data
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     // Get delivery address from storage
  //     final addressData = {
  //       'first_name': paymentData['shipping_first_name'],
  //       'last_name': paymentData['shipping_last_name'],
  //       'address_1': paymentData['shipping_address_1'],
  //       'address_2': paymentData['shipping_address_2'],
  //       'city': paymentData['shipping_city'],
  //       'state': paymentData['shipping_state'],
  //       'postcode': paymentData['shipping_postcode'],
  //       'country': paymentData['shipping_country'],
  //       'phone': paymentData['shipping_phone'],
  //     };

  //     final orderData = {
  //       ...paymentData,
  //       'payment_intent_id': paymentIntentId,
  //       'services_details': servicesData,
  //       'shipping_address': addressData,
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/create_order.php'),
  //       body: json.encode(orderData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     final data = json.decode(response.body);
  //     return data['order_id'].toString();
  //   } catch (e) {
  //     throw Exception('Error creating order: $e');
  //   }
  // }
// ----------------------------------------------------------------
  static Future<String> createOrder(String token, String paymentIntentId,
      Map<String, dynamic> paymentData) async {
    try {
      final servicesData = paymentData['cart_items']
          .map((item) => {
                'service_id': item['product_id'],
                'quantity': item['quantity'],
                'price': item['price'],
                'total_amount': (item['quantity'] * item['price']),
              })
          .toList();

      final addressData = {
        'first_name': paymentData['shipping_first_name'],
        'last_name': paymentData['shipping_last_name'],
        'address_1': paymentData['shipping_address_1'],
        'address_2': paymentData['shipping_address_2'],
        'city': paymentData['shipping_city'],
        'state': paymentData['shipping_state'],
        'postcode': paymentData['shipping_postcode'],
        'country': paymentData['shipping_country'],
        'phone': paymentData['shipping_phone'],
      };

      final orderData = {
        ...paymentData,
        'payment_intent_id': paymentIntentId,
        'services_details': servicesData,
        'shipping_address': addressData,
        'payment_method': paymentData['payment_method'],
        'use_saved_card': paymentData['use_saved_card'],
      };

      final response = await http.post(
        Uri.parse('$baseUrl/create_order.php'),
        body: json.encode(orderData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      return data['order_id'].toString();
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  // static Future<String> createOrder(String token, String paymentIntentId,
  //     Map<String, dynamic> paymentData) async {
  //   try {
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     final addressData = {
  //       'address_type': 'shipping',
  //       'first_name': paymentData['shipping_first_name'],
  //       'last_name': paymentData['shipping_last_name'],
  //       'address_1': paymentData['shipping_address_1'],
  //       'address_2': paymentData['shipping_address_2'],
  //       'city': paymentData['shipping_city'],
  //       'state': paymentData['shipping_state'],
  //       'postcode': paymentData['shipping_postcode'],
  //       'country': paymentData['shipping_country'],
  //       'email': paymentData['email'],
  //       'phone': paymentData['shipping_phone'],
  //     };

  //     final orderData = {
  //       ...paymentData,
  //       'payment_intent_id': paymentIntentId,
  //       'services_details': servicesData,
  //       'shipping_address': addressData,
  //       'delivery_type': paymentData['delivery_type'],
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/create_order.php'),
  //       body: json.encode(orderData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     final data = json.decode(response.body);
  //     return data['order_id'].toString();
  //   } catch (e) {
  //     throw Exception('Error creating order: $e');
  //   }
  // }

  // static Future<Map<String, String>> createPaymentIntent(
  //     String token, Map<String, dynamic> paymentData) async {
  //   try {
  //     // Add detailed service information to the payment data
  //     final servicesData = paymentData['cart_items']
  //         .map((item) => {
  //               'service_id': item['product_id'],
  //               'quantity': item['quantity'],
  //               'price': item['price'],
  //               'total_amount': (item['quantity'] * item['price']),
  //             })
  //         .toList();

  //     // Add address data structure
  //     final addressData = {
  //       'address_type': 'shipping',
  //       'first_name': paymentData['shipping_first_name'],
  //       'last_name': paymentData['shipping_last_name'],
  //       'address_1': paymentData['shipping_address_1'],
  //       'address_2': paymentData['shipping_address_2'],
  //       'city': paymentData['shipping_city'],
  //       'state': paymentData['shipping_state'],
  //       'postcode': paymentData['shipping_postcode'],
  //       'country': paymentData['shipping_country'],
  //       'email': paymentData['email'],
  //       'phone': paymentData['shipping_phone'],
  //     };

  //     final enhancedPaymentData = {
  //       ...paymentData,
  //       'services_details': servicesData,
  //       'shipping_address': addressData,
  //       'delivery_type': paymentData['delivery_type'],
  //     };

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/handle_payment.php'),
  //       body: json.encode(enhancedPaymentData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response Status: ${response.statusCode}'); // Log status
  //     print('Response Body: ${response.body}'); // Log response

  //     final data = json.decode(response.body);
  //     return {
  //       'clientSecret': data['clientSecret'],
  //       'orderId': data['order_id'].toString()
  //     };
  //   } catch (e) {
  //     throw Exception('Error creating payment: $e');
  //   }
  // }

  static Future<bool> updateOrderStatus(
      String token, String orderId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_order_status.php'),
        body: json.encode({'order_id': orderId, 'status': status}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      return json.decode(response.body)['status'] == 'success';
    } catch (e) {
      throw Exception('Error updating order: $e');
    }
  }

  // Reviews and Ratings
  // Get reviews for a specific service
  static Future<List<Map<String, dynamic>>> getServiceReviews(
      int serviceId) async {
    try {
      // Add timestamp to prevent caching
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final response = await http.get(
        Uri.parse(
            '$baseUrl/get_service_reviews.php?service_id=$serviceId&t=$timestamp'),
        headers: {
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
        },
      ).timeout(timeoutDuration);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['reviews']);
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      print('Error in getServiceReviews: $e');
      throw Exception('Error loading reviews: $e');
    }
  }

  // static Future<List<Map<String, dynamic>>> getServiceReviews(
  //     int serviceId) async {
  //   try {
  //     print('Fetching reviews for service ID: $serviceId');
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_service_reviews.php?service_id=$serviceId'),
  //       headers: {'Content-Type': 'application/json'},
  //     ).timeout(timeoutDuration);

  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return List<Map<String, dynamic>>.from(data['reviews']);
  //     } else {
  //       throw Exception('Failed to load reviews');
  //     }
  //   } catch (e) {
  //     print('Error in getServiceReviews: $e');
  //     throw Exception('Error loading reviews: $e');
  //   }
  // }

  // static Future<List<Map<String, dynamic>>> getServiceReviews(
  //     int serviceId) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_service_reviews.php?service_id=$serviceId'),
  //       headers: {'Content-Type': 'application/json'},
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return List<Map<String, dynamic>>.from(data['reviews']);
  //     } else {
  //       throw Exception('Failed to load reviews');
  //     }
  //   } catch (e) {
  //     throw Exception('Error loading reviews: $e');
  //   }
  // }

// Add a new review
  static Future<bool> addServiceReview(
      String token, Map<String, dynamic> reviewData) async {
    try {
      print('Making request to: $baseUrl/add_service_review.php');
      print('Headers: ${{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }}');
      print('Body: ${json.encode(reviewData)}');

      final response = await http
          .post(
            Uri.parse('$baseUrl/add_service_review.php'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: json.encode(reviewData),
          )
          .timeout(timeoutDuration);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Error in addServiceReview: $e');
      throw Exception('Error adding review: $e');
    }
  }

  // static Future<bool> addServiceReview(
  //     String token, Map<String, dynamic> reviewData) async {
  //   try {
  //     final response = await http
  //         .post(
  //           Uri.parse('$baseUrl/add_service_review.php'),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Authorization': 'Bearer $token'
  //           },
  //           body: json.encode(reviewData),
  //         )
  //         .timeout(timeoutDuration);

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     throw Exception('Error adding review: $e');
  //   }
  // }

  // Get order receipt
  static Future<OrderReceipt> getOrderReceipt(String token, int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_order_receipt.php?order_id=$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return OrderReceipt.fromJson(data['order']);
        }
        throw Exception(data['message'] ?? 'Failed to load receipt');
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order receipt: $e');
      throw Exception('Failed to load receipt: $e');
    }
  }

  // static Future<OrderReceipt> getOrderReceipt(String token, int orderId) async {
  //   try {
  //     print('Fetching receipt for order: $orderId');
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/generate_receipt.php?order_id=$orderId'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Receipt API Response: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data['status'] == 'success') {
  //         return OrderReceipt.fromJson(data['receipt']);
  //       }
  //       throw Exception('Failed to load receipt: ${data['message']}');
  //     } else {
  //       throw Exception('Failed to load receipt: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Receipt Error Details: $e');
  //     throw Exception('Error loading receipt: $e');
  //   }
  // }

  // static Future<OrderReceipt> getOrderReceipt(String token, int orderId) async {
  //   try {
  //     print('Fetching receipt for order: $orderId');
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/generate_receipt.php?order_id=$orderId'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Receipt API Response: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return OrderReceipt.fromJson(data['receipt']);
  //     } else {
  //       throw Exception('Failed to load receipt: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Receipt Error Details: $e');
  //     throw Exception('Error loading receipt: $e');
  //   }
  // }

  // static Future<OrderReceipt> getOrderReceipt(String token, int orderId) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/generate_receipt.php?order_id=$orderId'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //         'Cache-Control': 'no-cache',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return OrderReceipt.fromJson(data['receipt']);
  //     } else {
  //       throw Exception('Failed to load receipt');
  //     }
  //   } catch (e) {
  //     throw Exception('Error loading receipt: $e');
  //   }
  // }

  static Future<bool> cancelOrder(String token, String orderId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cancel_order.php'),
        body: json.encode({'order_id': orderId, 'status': 'cancelled'}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      return data['status'] == 'success';
    } catch (e) {
      print('Error cancelling order: $e');
      throw Exception('Failed to cancel order');
    }
  }

  // Get Order History
  static Future<List<OrderReceipt>> getOrderHistory(String token) async {
    try {
      print('Fetching order history with token: ${token.substring(0, 10)}...');

      final response = await http.get(
        Uri.parse('$baseUrl/get_order_history.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final List<dynamic> ordersData = data['orders'];
          return ordersData
              .map((orderJson) => OrderReceipt.fromJson(orderJson))
              .toList();
        }
        throw Exception('Failed to load orders: ${data['message']}');
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Detailed error in getOrderHistory: $e');
      throw Exception('Failed to load orders: $e');
    }
  }

  // static Future<List<OrderReceipt>> getOrderHistory(String token) async {
  //   try {
  //     print('Fetching order history with token: ${token.substring(0, 10)}...');

  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_order_history.php'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data['status'] == 'success') {
  //         final orders = (data['orders'] as List)
  //             .map((order) => OrderReceipt.fromJson(order))
  //             .toList();
  //         print('Successfully parsed ${orders.length} orders');
  //         return orders;
  //       }
  //       throw Exception(data['message'] ?? 'Unknown error occurred');
  //     } else {
  //       throw Exception('Server returned status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Detailed error in getOrderHistory: $e');
  //     throw Exception('Failed to load orders: $e');
  //   }
  // }

  // static Future<List<OrderReceipt>> getOrderHistory(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_order_history.php'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     print('Order History Response: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data['status'] == 'success') {
  //         return (data['orders'] as List)
  //             .map((order) => OrderReceipt.fromJson(order))
  //             .toList();
  //       }
  //       throw Exception(data['message']);
  //     } else {
  //       throw Exception('Failed to load orders');
  //     }
  //   } catch (e) {
  //     print('Order History Error: $e');
  //     throw Exception('Error loading orders: $e');
  //   }
  // }

  // static Future<List<OrderReceipt>> getOrderHistory(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_order_history.php'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //         'Cache-Control': 'no-cache',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return (data['orders'] as List)
  //           .map((order) => OrderReceipt.fromJson(order))
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load order history');
  //     }
  //   } catch (e) {
  //     throw Exception('Error loading order history: $e');
  //   }
  // }

  //---------------------------------------------------------
  // Add these methods to the existing ApiService class

// Billing Address Methods
  static Future<int> saveBillingAddress(
      String token, Map<String, dynamic> addressData) async {
    final userProfile = await getUserProfile(token);
    final userId = userProfile['ID'];

    final requestData = {
      'user_id': userId,
      'first_name': addressData['first_name'],
      'last_name': addressData['last_name'],
      'address_1': addressData['address_1'],
      'address_2': addressData['address_2'],
      'city': addressData['city'],
      'state': addressData['state'],
      'postcode': addressData['postcode'],
      'country': addressData['country'],
      'phone': addressData['phone']
    };

    final response = await http
        .post(
          Uri.parse('$baseUrl/payment/save_billing_address.php'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(requestData),
        )
        .timeout(timeoutDuration);

    print('Billing Address Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return data['address_id'];
      }
      throw Exception(data['message'] ?? 'Failed to save billing address');
    }

    throw Exception('Server error occurred');
  }

  // static Future<int> saveBillingAddress(
  //     String token, Map<String, dynamic> addressData) async {
  //   final response = await http
  //       .post(
  //         Uri.parse('$baseUrl/payment/save_billing_address.php'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: json.encode(addressData),
  //       )
  //       .timeout(timeoutDuration);

  //   final data = json.decode(response.body);
  //   if (data['status'] == 'success') {
  //     return data['address_id'];
  //   }
  //   throw Exception(data['message']);
  // }

  static Future<List<Map<String, dynamic>>> getBillingAddresses(
      String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/payment/get_billing_addresses.php'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(timeoutDuration);

    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      return List<Map<String, dynamic>>.from(data['addresses']);
    }
    throw Exception(data['message']);
  }

// Saved Cards Methods
  // static Future<void> saveCard(
  //     String token, Map<String, dynamic> cardData) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/save_card.php'),
  //       body: json.encode(cardData),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to save card');
  //     }
  //   } catch (e) {
  //     throw Exception('Error saving card: $e');
  //   }
  // }
  static Future<void> saveCard(
      String token, Map<String, dynamic> cardData) async {
    try {
      print('Saving card with data: $cardData');

      final response = await http
          .post(
            Uri.parse(
                '${baseUrl}/payment/save_card.php'), // Updated endpoint path
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
            },
            body: json.encode(cardData),
          )
          .timeout(timeoutDuration);

      print('Card save response: ${response.body}');
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return;
        }
        throw Exception(data['message'] ?? 'Failed to save card');
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saving card: $e');
    }
  }

  // static Future<void> saveCard(
  //     String token, Map<String, dynamic> cardData) async {
  //   try {
  //     final response = await http
  //         .post(
  //           Uri.parse('$baseUrl/payment/save_card.php'),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Authorization': 'Bearer $token',
  //           },
  //           body: json.encode(cardData),
  //         )
  //         .timeout(timeoutDuration);

  //     print('Save Card Response: ${response.body}');

  //     if (response.body.isEmpty) {
  //       throw Exception('Server returned empty response');
  //     }

  //     final data = json.decode(response.body);
  //     if (data['status'] != 'success') {
  //       throw Exception(data['message']);
  //     }
  //   } catch (e) {
  //     print('Save Card Error: $e');
  //     rethrow;
  //   }
  // }

  // static Future<void> saveCard(
  //     String token, Map<String, dynamic> cardData) async {
  //   final response = await http
  //       .post(
  //         Uri.parse('$baseUrl/payment/save_card.php'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: json.encode(cardData),
  //       )
  //       .timeout(timeoutDuration);

  //   final data = json.decode(response.body);
  //   if (data['status'] != 'success') {
  //     throw Exception(data['message']);
  //   }
  // }

  static Future<List<SavedCard>> getSavedCards(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/payment/get_saved_cards.php'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      print('Cards API Response: ${response.body}');

      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        final cardsList = data['cards'] as List;
        return cardsList.map((card) => SavedCard.fromJson(card)).toList();
      }

      return [];
    } catch (e) {
      print('Error details: $e');
      return [];
    }
  }

  // static Future<List<SavedCard>> getSavedCards(String token) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/get_saved_cards.php'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(timeoutDuration);

  //     final data = json.decode(response.body);
  //     return (data as List).map((card) => SavedCard.fromJson(card)).toList();
  //   } catch (e) {
  //     throw Exception('Error fetching saved cards: $e');
  //   }
  // }

  // static Future<List<Map<String, dynamic>>> getSavedCards(String token) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/payment/get_saved_cards.php'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   ).timeout(timeoutDuration);

  //   final data = json.decode(response.body);
  //   if (data['status'] == 'success') {
  //     return List<Map<String, dynamic>>.from(data['cards']);
  //   }
  //   throw Exception(data['message']);
  // }

  static Future<void> updateDefaultCard(String token, int cardId) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/payment/update_default_card.php'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({'card_id': cardId}),
        )
        .timeout(timeoutDuration);

    final data = json.decode(response.body);
    if (data['status'] != 'success') {
      throw Exception(data['message']);
    }
  }

  static Future<void> deleteCard(String token, int cardId) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/payment/delete_card.php'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({'card_id': cardId}),
        )
        .timeout(timeoutDuration);

    final data = json.decode(response.body);
    if (data['status'] != 'success') {
      throw Exception(data['message']);
    }
  }
}
