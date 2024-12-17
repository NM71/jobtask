import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  static String get stripeKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
}
