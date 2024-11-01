import 'package:flutter/material.dart';

class ProductHolder extends StatefulWidget {
  const ProductHolder({super.key});

  @override
  State<ProductHolder> createState() => _ProductHolderState();
}

class _ProductHolderState extends State<ProductHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text("First up, which product do you use the most?"),
        ],
      ),
    );
  }
}
