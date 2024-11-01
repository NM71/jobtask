import 'package:flutter/material.dart';
import 'package:jobtask/screens/shop/shop_now.dart';
import 'package:page_transition/page_transition.dart';

import '../shop/shop_screen.dart';

class ProductDescription extends StatelessWidget {
  final Service service;

  const ProductDescription({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${service.name} Shoes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(service.imagePath,
                height: 160, width: 160, fit: BoxFit.cover),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  service.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  '\$${service.price}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff3c76ad),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              service.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: ShopNow(shoeSize: 0, service: service,),
                        type: PageTransitionType.rightToLeft));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3c76ad),
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white24),
              ),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }
}
