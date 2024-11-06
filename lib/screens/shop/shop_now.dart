// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/reviews_screen.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'shop_screen.dart';
//
// class ShopNow extends StatelessWidget {
//   final double? shoeSize;
//   final Service service;
//
//   const ShopNow({super.key, required this.shoeSize, required this.service});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('${service.name} Shoes'),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(service.imagePath,
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     fit: BoxFit.cover),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       service.name,
//                       style:
//                           TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       '${service.price.toString()}\$',
//                       style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff3c76ad)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   service.description,
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Color(0xff3c76ad),
//                       ),
//                       onPressed: () {},
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Select Size',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 showModalBottomSheet(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return Container(
//                                         color: Colors.white,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.95,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.95,
//                                         padding: const EdgeInsets.all(16.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Select your Shoe Size: \n\n",
//                                               style: TextStyle(
//                                                   fontSize: 30,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     });
//                               },
//                               icon: Image.asset(
//                                 'assets/icons/dropdown_icon.png',
//                                 height: 25,
//                                 width: 25,
//                                 color: Color(0xff3c76ad),
//                               ))
//                         ],
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff3c76ad),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     Provider.of<CartProvider>(context, listen: false).addToCart(service);
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   SnackBar(content: Text('${service.name} added to cart')),);
//                     CustomSnackbar.show(
//                       context: context,
//                       message: '${service.name} added to cart',
//                     );
//                   },
//                   child: Text(
//                     "Add to Cart",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Divider(
//                   color: Color(0xffe4e4e4),
//                   thickness: 2,
//                   indent: 20,
//                   endIndent: 20,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "Reviews (20)",
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "★ ★ ★ ★ ★",
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   PageTransition(
//                                       child: ReviewsScreen(),
//                                       type: PageTransitionType.rightToLeft));
//                             },
//                             icon: Image.asset(
//                               'assets/icons/dropdown_icon.png',
//                               height: 25,
//                               width: 25,
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "You Might Also Like",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 30),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// -------------------------------------------------------


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

  const ShopNow({super.key, required this.shoeSize, required this.service});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text('${service.name} Shoes'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Responsive image
                Image.asset(
                  service.imagePath,
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.9,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                // Responsive text size
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      service.name,
                      style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${service.price}',
                      style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3c76ad)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Responsive description text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    service.description,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),
                // Select size button with dropdown icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xff3c76ad),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select Size',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: Colors.white,
                                      height: screenHeight * 0.95,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 10),
                // Add to cart button
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xff3c76ad),
                //     foregroundColor: Colors.white,
                //   ),
                //   onPressed: () {
                //     Provider.of<CartProvider>(context, listen: false).addToCart(service);
                //     CustomSnackbar.show(
                //       context: context,
                //       message: '${service.name} added to cart',
                //     );
                //   },
                //   child: Text(
                //     "Add to Cart",
                //     style: TextStyle(fontSize: screenWidth * 0.05),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyButton(text: "Add to Cart", onTap: (){
                    Provider.of<CartProvider>(context, listen: false).addToCart(service);
                    CustomSnackbar.show(
                      context: context,
                      message: '${service.name} added to cart',
                    );
                  }),
                ),
                SizedBox(height: 10),
                // Divider
                Divider(
                  color: Color(0xffe4e4e4),
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 10),
                // Reviews section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Reviews (20)",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "★ ★ ★ ★ ★",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
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
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // You Might Also Like section title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "You Might Also Like",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: screenWidth * 0.08),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
