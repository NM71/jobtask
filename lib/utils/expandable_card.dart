import 'package:flutter/material.dart';

class ReusableExpandableCard extends StatelessWidget {
  final String title;
  final String content;

  const ReusableExpandableCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ExpansionTile(
        collapsedIconColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Color(0xff5c5c5c),
        iconColor: Colors.white,
        collapsedBackgroundColor: Color(0xff3c76ad),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
