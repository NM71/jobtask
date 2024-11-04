// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:jobtask/sample_check.dart';
// import 'dart:math' as math;
//
// import 'package:jobtask/screens/cart/cart_screen.dart';
//
// class FloatingActionAnimation extends StatefulWidget {
//   @override
//   _FloatingActionAnimationState createState() => _FloatingActionAnimationState();
// }
//
// class _FloatingActionAnimationState extends State<FloatingActionAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 4),
//     )..repeat();
//
//     _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AvatarGlow(
//       // glowColor: Color(0xffcf2e2e),
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return FloatingActionButton(
//             backgroundColor: Color(0xffffffff),
//             shape: RoundedRectangleBorder(
//               side: BorderSide(color: Color(0xff000000)),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SampleCheck()),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Transform.rotate(
//                 angle: _rotationAnimation.value,
//                 // child: Icon(Icons.shopping_cart_checkout_outlined),
//                 child: Image.asset('assets/images/before after.png', height: 25, width: 25,),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }































import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/about/beforevsafter.dart';

class FloatingActionAnimation extends StatefulWidget {
  @override
  _FloatingActionAnimationState createState() => _FloatingActionAnimationState();
}

class _FloatingActionAnimationState extends State<FloatingActionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Color(0xff3c76ad),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xff000000)),
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => BeforeAfterComparison()),
              // );
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BeforeAfterComparison();
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  'assets/images/before after.png',
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
