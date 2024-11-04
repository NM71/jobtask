// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("Cart", style: TextStyle(fontSize: 28)),
//             Card(
//               elevation: 0,
//               color: Color(0xfff6f6f6),
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Not in a Hurry?"),
//                     SizedBox(height: 8),
//                     Text("Select No Rush Shipping at checkout."),
//                     SizedBox(height: 8),
//                     Text("---"),
//
//                     // Here the selected service should be displaying like the image provided
//                     // and the user should be able to update the quantity and the total price should also
//                     // update according to that
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Delivery"),
//             SizedBox(height: 8),
//             Text("Arrives Wed, 30 Oct"),
//             SizedBox(height: 8),
//             Text("to Fri, 2 Nov  Edit Location"),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   'assets/images/services_images/soleSwaps_service.jpg',
//                   height: 200,
//                   width: 200,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("ReFresh"),
//                     Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio.",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 )),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             // total
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Subtotal",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 Text(
//                   "US\$30.00",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Delivery",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 Text(
//                   "Standard-Free",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Estimated Total",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "US\$30.00 + Tax",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xff3c76ad),
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () {},
//               child: Text("Checkout"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:provider/provider.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<CartProvider>(
//         builder: (context, cartProvider, child) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("Cart", style: TextStyle(fontSize: 28)),
//
//                 // Cart Items List
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cartProvider.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = cartProvider.cartItems[index];
//                       return CartItemWidget(
//                         cartItem: cartItem,
//                         onQuantityChanged: (newQuantity) {
//                           cartProvider.updateQuantity(cartItem.service, newQuantity);
//                         },
//                         onRemove: () {
//                           cartProvider.removeFromCart(cartItem.service);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//
//                 // Total and Checkout
//                 if (cartProvider.cartItems.isNotEmpty) ...[
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Subtotal",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(
//                         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)}",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Delivery",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(
//                         "Standard-Free",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Estimated Total",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)} + Tax",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff3c76ad),
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       // Implement checkout logic
//                     },
//                     child: Text("Checkout"),
//                   ),
//                 ] else ...[
//                   Text("Your cart is empty"),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:jobtask/sample_check.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/utils/custom_buttons/my_button.dart';
// import 'package:provider/provider.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<CartProvider>(
//         builder: (context, cartProvider, child) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Cart", style: TextStyle(fontSize: 28)),
//
//                 // Check if the cart is empty
//                 if (cartProvider.cartItems.isEmpty) ...[
//                   Expanded(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             'assets/images/cart_image.png',
//                             height: 100,
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             'Your Cart is empty.',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'When you add products, they\'ll appear here.',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           SizedBox(height: 24),
//                           // ElevatedButton(
//                           //   style: ElevatedButton.styleFrom(
//                           //     backgroundColor: Color(0xff3c76ad),
//                           //     foregroundColor: Colors.white,
//                           //   ),
//                           //   onPressed: () {
//                           //     // Navigate to the shop screen
//                           //     // Navigator.pushNamed(context, '/shop');
//                           //   },
//                           //   child: Text('Shop Now'),
//                           // ),
//                           MyButton(
//                               text: "Shop Now",
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => WebViewScreen()));
//                               }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ] else ...[
//                   // Existing cart items list and total/checkout section
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: cartProvider.cartItems.length,
//                       itemBuilder: (context, index) {
//                         final cartItem = cartProvider.cartItems[index];
//                         return CartItemWidget(
//                           cartItem: cartItem,
//                           onQuantityChanged: (newQuantity) {
//                             cartProvider.updateQuantity(
//                                 cartItem.service, newQuantity);
//                           },
//                           onRemove: () {
//                             cartProvider.removeFromCart(cartItem.service);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Subtotal",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(
//                         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)}",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Delivery",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       Text(
//                         "Standard-Free",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Estimated Total",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)} + Tax",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   // ElevatedButton(
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: Color(0xff3c76ad),
//                   //     foregroundColor: Colors.white,
//                   //   ),
//                   //   onPressed: () {
//                   //     // Implement checkout logic
//                   //   },
//                   //   child: Text("Checkout"),
//                   // ),
//                   MyButton(text: "Checkout", onTap: () {}),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // New widget to handle individual cart item display and quantity
// class CartItemWidget extends StatelessWidget {
//   final CartItem cartItem;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onRemove;
//
//   const CartItemWidget({
//     Key? key,
//     required this.cartItem,
//     required this.onQuantityChanged,
//     required this.onRemove,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shadowColor: Colors.blue,
//       elevation: 0,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   cartItem.service.imagePath,
//                   height: 130,
//                   width: 130,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         cartItem.service.name,
//                         style: TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         cartItem.service.description,
//                         style:
//                             TextStyle(fontSize: 12, color: Color(0xff989898)),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//             // Column Items
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove_circle_outline),
//                   onPressed: () {
//                     if (cartItem.quantity > 1) {
//                       onQuantityChanged(cartItem.quantity - 1);
//                     }
//                   },
//                 ),
//                 Text('${cartItem.quantity}'),
//                 IconButton(
//                   icon: Icon(Icons.add_circle_outline),
//                   onPressed: () {
//                     onQuantityChanged(cartItem.quantity + 1);
//                   },
//                 ),
//                 Spacer(),
//                 Text(
//                   "\$${cartItem.service.price.toStringAsFixed(2)}",
//                   style: TextStyle(color: Color(0xff3c76ad)),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete, color: Color(0xff3c76ad)),
//                   onPressed: onRemove,
//                 ),
//               ],
//             ),
//
//             // Delivery Details
//             Text("Delivery"),
//             Text("Arrives Wed, 11 May"),
//             Text("to Fri, 13 May"),
//             Divider(
//               indent: MediaQuery.of(context).size.width*0.05,
//               endIndent: MediaQuery.of(context).size.width*0.05,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }














































import 'package:flutter/material.dart';
import 'package:jobtask/sample_check.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final screenWidth = MediaQuery.of(context).size.width;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cart", style: TextStyle(fontSize: screenWidth * 0.08)),

                // Check if the cart is empty
                if (cartProvider.cartItems.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/cart_image.png',
                            height: screenWidth * 0.25, // Responsive height
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your Cart is empty.',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'When you add products, they\'ll appear here.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 24),
                          MyButton(
                            text: "Shop Now",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Existing cart items list and total/checkout section
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartProvider.cartItems[index];
                        return CartItemWidget(
                          cartItem: cartItem,
                          onQuantityChanged: (newQuantity) {
                            cartProvider.updateQuantity(cartItem.service, newQuantity);
                          },
                          onRemove: () {
                            cartProvider.removeFromCart(cartItem.service);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSubtotalRow(screenWidth, cartProvider),
                  SizedBox(height: 8),
                  _buildDeliveryRow(screenWidth),
                  SizedBox(height: 8),
                  _buildEstimatedTotalRow(screenWidth, cartProvider),
                  SizedBox(height: 20),
                  MyButton(text: "Checkout", onTap: () {}),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubtotalRow(double screenWidth, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Subtotal",
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
        ),
        Text(
          "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)}",
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
        ),
      ],
    );
  }

  Widget _buildDeliveryRow(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Delivery",
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
        ),
        Text(
          "Standard-Free",
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
        ),
      ],
    );
  }

  Widget _buildEstimatedTotalRow(double screenWidth, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Estimated Total",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045),
        ),
        Text(
          "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)} + Tax",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045),
        ),
      ],
    );
  }
}

// New widget to handle individual cart item display and quantity
class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      shadowColor: Colors.blue,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  cartItem.service.imagePath,
                  height: screenWidth * 0.3, // Responsive image height
                  width: screenWidth * 0.3, // Responsive image width
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.service.name,
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                      SizedBox(height: 5),
                      Text(
                        cartItem.service.description,
                        style: TextStyle(fontSize: screenWidth * 0.035, color: Color(0xff989898)),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      onQuantityChanged(cartItem.quantity - 1);
                    }
                  },
                ),
                Text('${cartItem.quantity}', style: TextStyle(fontSize: screenWidth * 0.035)),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    onQuantityChanged(cartItem.quantity + 1);
                  },
                ),
                Spacer(),
                Text(
                  "\$${cartItem.service.price.toStringAsFixed(2)}",
                  style: TextStyle(color: Color(0xff3c76ad), fontSize: screenWidth * 0.035),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Color(0xff3c76ad)),
                  onPressed: onRemove,
                ),
              ],
            ),
            Text("Delivery", style: TextStyle(fontSize: screenWidth * 0.035)),
            Text("Arrives Wed, 11 May", style: TextStyle(fontSize: screenWidth * 0.035)),
            Text("to Fri, 13 May", style: TextStyle(fontSize: screenWidth * 0.035)),
            Divider(
              indent: screenWidth * 0.05,
              endIndent: screenWidth * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
