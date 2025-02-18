// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:jobtask/env.dart';

// class CurrencyService {
//   static const String baseUrl =
//       'https://api.exchangerate-api.com/v4/latest/USD';

//   static Future<double> getExchangeRate(String currencyCode) async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['rates'][currencyCode] ?? 1.0;
//       }
//       return 1.0;
//     } catch (e) {
//       return 1.0; // Default to 1.0 if there's an error
//     }
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String baseUrl =
      'https://v6.exchangerate-api.com/v6/b39e53a14dabf8cb0bc64919/latest/USD';
  static const storage = FlutterSecureStorage();

  static Future<double> getExchangeRate(String currencyCode) async {
    String? cachedRate; // Declare at the top of the method

    try {
      // Check if we have a cached rate and its timestamp
      cachedRate = await storage.read(key: 'rate_$currencyCode');
      final cacheTime = await storage.read(key: 'rate_time_$currencyCode');

      if (cachedRate != null && cacheTime != null) {
        final cacheDateTime = DateTime.parse(cacheTime);
        final now = DateTime.now();

        if (now.difference(cacheDateTime).inHours < 24) {
          return double.parse(cachedRate);
        }
      }

      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rate = data['conversion_rates'][currencyCode].toDouble();

        await storage.write(key: 'rate_$currencyCode', value: rate.toString());
        await storage.write(
            key: 'rate_time_$currencyCode',
            value: DateTime.now().toIso8601String());

        return rate;
      }

      return cachedRate != null ? double.parse(cachedRate) : 1.0;
    } catch (e) {
      print('Exchange rate fetch failed: $e');
      return cachedRate != null ? double.parse(cachedRate) : 1.0;
    }
  }
}

// class CurrencyService {
//   static const String baseUrl =
//       'https://v6.exchangerate-api.com/v6/b39e53a14dabf8cb0bc64919/latest/USD';

//   static Future<double> getExchangeRate(String currencyCode) async {
//     try {
//       final response = await http.get(
//         Uri.parse(baseUrl),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//       ).timeout(
//         const Duration(seconds: 10),
//         onTimeout: () {
//           throw TimeoutException('The connection has timed out');
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final rate = data['conversion_rates'][currencyCode];
//         print('Success: Rate for $currencyCode is $rate');
//         return rate ?? 1.0;
//       } else {
//         print('API Error: ${response.statusCode} - ${response.body}');
//         return 1.0;
//       }
//     } catch (e) {
//       print('Network Error: $e');
//       return 1.0;
//     }
//   }
// }
