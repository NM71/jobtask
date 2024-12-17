import 'package:flutter/material.dart';
import 'package:jobtask/screens/shop/shop_now.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../shop/shop_screen.dart';

class ProductDescription extends StatelessWidget {
  final Service service;
  final List<Service> allServices;

  const ProductDescription(
      {Key? key, required this.service, required this.allServices})
      : super(key: key);

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
            Image.network(service.imagePath,
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
            MyButton(
                text: "Shop Now",
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ShopNow(
                            shoeSize: 0,
                            service: service,
                            allServices: Provider.of<ServiceProvider>(context,
                                    listen: false)
                                .getAllServices(),
                          ),
                          type: PageTransitionType.rightToLeft));
                })
          ],
        ),
      ),
    );
  }
}
