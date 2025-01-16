import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/about/beforevsafter.dart';

class FloatingActionAnimation extends StatefulWidget {
  @override
  _FloatingActionAnimationState createState() =>
      _FloatingActionAnimationState();
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
      glowColor: Color(0xff9ec1ec),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FloatingActionButton(
            backgroundColor: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: Color(0xff000000)),
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => BeforeAfterComparison()),
              // );
              showModalBottomSheet(
                  useSafeArea: true,
                  sheetAnimationStyle:
                      AnimationStyle(duration: Duration(seconds: 1)),
                  showDragHandle: true,
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
