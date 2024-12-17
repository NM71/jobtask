import 'package:flutter/material.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/shop/reviews_screen.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'shop_screen.dart';

class ShopNow extends StatelessWidget {
  final double? shoeSize;
  final Service service;
  final List<Service> allServices;

  const ShopNow(
      {super.key,
      required this.shoeSize,
      required this.service,
      required this.allServices});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter similar services (excluding current service)
    final similarServices = allServices
        .where(
            (s) => s.id != service.id && s.serviceType == service.serviceType)
        .take(4)
        .toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '${service.name} Shoes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Responsive image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.network(
                    service.imagePath,
                    // height: screenHeight * 0.4,
                    // width: screenWidth * 0.9,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                // Responsive text size
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service.name,
                        style: TextStyle(
                            fontSize: screenWidth * 0.085,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${service.price.toStringAsFixed(0)}\$',
                        style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3c76ad)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Responsive description text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    service.description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),

                // Select size button with dropdown icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xff3c76ad),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select Size',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: Colors.white,
                                      height: 24,
                                      width: 24,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Select your Shoe Size: \n\n",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.08,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Image.asset(
                              'assets/icons/dropdown_icon.png',
                              height: 25,
                              width: 25,
                              color: Color(0xff3c76ad),
                            ),
                          ),
                        ],
                      )),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: MyButton(
                      text: "Add to Cart",
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(service);
                        CustomSnackbar.show(
                          context: context,
                          message: '${service.name} added to cart',
                        );
                      }),
                ),

                SizedBox(height: 20),
                // Divider

                Divider(
                  color: Color(0xffe4e4e4),
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                ),
                SizedBox(height: 10),
                // Reviews section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Reviews (20)",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "★ ★ ★ ★ ★",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ReviewsScreen(),
                                    type: PageTransitionType.rightToLeft));
                          },
                          icon: Image.asset(
                            'assets/icons/dropdown_icon.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                // You Might Also Like section title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "You Might Also Like",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: similarServices.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(service: similarServices[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
