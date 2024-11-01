import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';

class SampleCheck extends StatefulWidget {
  const SampleCheck({super.key});

  @override
  State<SampleCheck> createState() => _SampleCheckState();
}

class _SampleCheckState extends State<SampleCheck> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BeforeAfter(
          value: _value,
          before: Image.asset('assets/images/services_images/lintRemove_service.jpg'),
          after: Image.asset('assets/images/services_images/kids_service.jpg'),
          onValueChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// class SampleCheck extends StatelessWidget {
//   const SampleCheck({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.network('https://lottiefiles.com/free-animation/cart-checkout-fast-gHqTaBD6Mo'),
//       ),
//     );
//   }
// }
