import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jobtask/models/order_receipt.dart';
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

  static Future<bool> updateUserProfile(
      String token, Map<String, dynamic> profileData) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/update_user_profile'),
      );

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add file if exists
      if (profileData.containsKey('profile_picture')) {
        File imageFile = File(profileData['profile_picture']);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
            'profile_picture', stream, length,
            filename: imageFile.path.split('/').last);

        request.files.add(multipartFile);
        profileData.remove('profile_picture'); // Remove from regular fields
      }

      // Add other fields
      profileData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      return jsonResponse['success'] == true;
    } catch (e) {
      print('Error updating profile: $e');
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
  static Future<Map<String, String>> createPaymentIntent(
      String token, Map<String, dynamic> paymentData) async {
    try {
      // Add detailed service information to the payment data
      final servicesData = paymentData['cart_items']
          .map((item) => {
                'service_id': item['product_id'],
                'quantity': item['quantity'],
                'price': item['price'],
                'total_amount': (item['quantity'] * item['price']),
              })
          .toList();

      // Add address data structure
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
      };

      final response = await http.post(
        Uri.parse('$baseUrl/handle_payment.php'),
        body: json.encode(enhancedPaymentData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);

      final data = json.decode(response.body);
      return {
        'clientSecret': data['clientSecret'],
        'orderId': data['order_id'].toString()
      };
    } catch (e) {
      throw Exception('Error creating payment: $e');
    }
  }

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
}
