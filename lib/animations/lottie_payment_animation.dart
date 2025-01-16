import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePaymentAnimation extends StatelessWidget {
  const LottiePaymentAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/lottie_payment_slow.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
