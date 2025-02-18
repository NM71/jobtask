import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/cart/delivery_type_selector.dart';
import 'package:jobtask/screens/cart/delivery_address_form.dart';
import 'package:jobtask/screens/cart/navigation_provider.dart';
import 'package:jobtask/screens/checkout/checkout_bottom_sheet.dart';
import 'package:jobtask/screens/profile/country_provider.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<CartProvider>(
//         builder: (context, cartProvider, child) {
//           final screenWidth = MediaQuery.of(context).size.width;

//           return SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text("Cart",
//                         style: TextStyle(fontSize: screenWidth * 0.08)),
//                     if (cartProvider.cartItems.isEmpty) ...[
//                       Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: 50,
//                                 ),
//                                 Image.asset(
//                                   'assets/images/cart_image.png',
//                                   height: screenWidth * 0.15,
//                                 ),
//                                 SizedBox(height: 25),
//                                 Text(
//                                   'Your Cart is empty.',
//                                   style:
//                                       TextStyle(fontSize: screenWidth * 0.04),
//                                 ),
//                                 SizedBox(height: 16),
//                                 Text(
//                                   textAlign: TextAlign.center,
//                                   'When you add services, they\'ll\nappear here.',
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 25),
//                             MyButton(
//                               height: 51,
//                               text: "Shop Now",
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   PageTransition(
//                                     type: PageTransitionType.leftToRight,
//                                     child: ServicePage(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ] else ...[
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: cartProvider.cartItems.length,
//                         itemBuilder: (context, index) {
//                           final cartItem = cartProvider.cartItems[index];
//                           return CartItemWidget(
//                             cartItem: cartItem,
//                             onQuantityChanged: (newQuantity) {
//                               cartProvider.updateQuantity(
//                                   cartItem.service, newQuantity);
//                             },
//                             onRemove: () {
//                               cartProvider.removeFromCart(cartItem.service);
//                             },
//                           );
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       _buildSubtotalRow(screenWidth, cartProvider),
//                       SizedBox(height: 8),
//                       _buildDeliveryRow(screenWidth),
//                       SizedBox(height: 8),
//                       _buildEstimatedTotalRow(screenWidth, cartProvider),
//                       SizedBox(height: 20),
//                       MyButton(
//                         height: 51,
//                         text: "Checkout",
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             backgroundColor: Colors.transparent,
//                             builder: (context) => CheckoutBottomSheet(
//                               totalAmount: cartProvider.getTotalPrice(),
//                               onCheckout: (deliveryType, paymentMethod) async {
//                                 _handleCheckout(context, cartProvider);
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

class _CartScreenState extends State<CartScreen> {
  Timer? _serviceCheckTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _startServiceCheck();
  }

  bool _hasServiceChanged(Service oldService, Service newService) {
    return oldService.name != newService.name ||
        oldService.price != newService.price ||
        oldService.imagePath != newService.imagePath ||
        oldService.description != newService.description ||
        oldService.serviceType != newService.serviceType;
  }

  void _startServiceCheck() {
    // Initial check
    _verifyCartServices();

    // Set up periodic check every 10 seconds
    _serviceCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _verifyCartServices();
    });
  }

  Future<void> _verifyCartServices() async {
    try {
      final services = await ApiService.getServices();
      final allServices = [
        ...services['main'] ?? [],
        ...services['individual'] ?? []
      ];

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final cartItems = List.from(cartProvider.cartItems);

      for (var cartItem in cartItems) {
        // Find matching service from current database
        final updatedService = allServices.firstWhere(
          (service) => service.id == cartItem.service.id,
          orElse: () => Service(
            id: -1,
            name: '',
            price: 0,
            imagePath: '',
            description: '',
            serviceType: '',
          ),
        );

        if (updatedService.id == -1) {
          // Service no longer exists
          cartProvider.removeFromCart(cartItem.service);
          if (mounted) {
            CustomSnackbar.show(
              context: context,
              message: '${cartItem.service.name} is no longer available',
            );
          }
        } else if (_hasServiceChanged(cartItem.service, updatedService)) {
          // Update service details in cart
          cartProvider.updateServiceDetails(cartItem.service, updatedService);
          if (mounted) {
            CustomSnackbar.show(
              context: context,
              message: '${updatedService.name} details have been updated',
            );
          }
        }
      }
    } catch (e) {
      print('Error verifying services: $e');
    }
  }

  // Future<void> _verifyCartServices() async {
  //   try {
  //     final services = await ApiService.getServices();
  //     final allServices = [
  //       ...services['main'] ?? [],
  //       ...services['individual'] ?? []
  //     ];

  //     final cartProvider = Provider.of<CartProvider>(context, listen: false);
  //     final cartItems = cartProvider.cartItems;

  //     for (var cartItem in cartItems) {
  //       bool serviceExists =
  //           allServices.any((service) => service.id == cartItem.service.id);
  //       if (!serviceExists) {
  //         cartProvider.removeFromCart(cartItem.service);
  //         if (mounted) {
  //           CustomSnackbar.show(
  //             context: context,
  //             message: '${cartItem.service.name} is no longer available',
  //           );
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Error verifying services: $e');
  //   }
  // }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _serviceCheckTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final screenWidth = MediaQuery.of(context).size.width;

          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cart", style: TextStyle(fontSize: screenWidth * 0.08)),
                  if (cartProvider.cartItems.isEmpty) ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/cart_image.png',
                              height: screenWidth * 0.15,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Your Cart is empty.',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'When you add services, they\'ll\nappear here.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MyButton(
                        height: 51,
                        text: "Shop Now",
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     type: PageTransitionType.leftToRight,
                          //     child: ServicePage(),
                          //   ),
                          // );
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .jumpToPage(1);
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cartProvider.cartItems.length,
                              itemBuilder: (context, index) {
                                final cartItem = cartProvider.cartItems[index];
                                return CartItemWidget(
                                  cartItem: cartItem,
                                  onQuantityChanged: (newQuantity) {
                                    cartProvider.updateQuantity(
                                        cartItem.service, newQuantity);
                                  },
                                  onRemove: () {
                                    cartProvider
                                        .removeFromCart(cartItem.service);
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            _buildSubtotalRow(screenWidth, cartProvider),
                            SizedBox(height: 8),
                            _buildDeliveryRow(screenWidth),
                            SizedBox(height: 8),
                            _buildEstimatedTotalRow(screenWidth, cartProvider),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MyButton(
                        height: 51,
                        text: "Checkout",
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => CheckoutBottomSheet(
                              totalAmount: cartProvider.getTotalPrice(),
                              onCheckout: (deliveryType, paymentMethod) async {
                                _handleCheckout(context, cartProvider);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<void> _handleCheckout(
  //     BuildContext context, CartProvider cartProvider) async {
  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please login to continue')),
  //       );
  //       return;
  //     }

  //     final userProfile = await ApiService.getUserProfile(token);

  //     // Print for debugging
  //     // print('User Profile Data: $userProfile');

  //     // Access ID directly without parsing
  //     final userId = userProfile['ID'];

  //     // print('This is my User ID: ${userId}');

  //     final deliveryType = await showModalBottomSheet<String>(
  //       context: context,
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       builder: (context) => DeliveryTypeSelector(),
  //     );

  //     if (deliveryType == null) return;

  //     final addressResult = await showModalBottomSheet<bool>(
  //       context: context,
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       builder: (context) => DeliveryAddressForm(
  //         token: token,
  //         userId: userId,
  //       ),
  //     );

  //     if (addressResult != true) return;

  //     // final paymentData = {
  //     //   'amount': (cartProvider.getTotalPrice() * 100).toInt(),
  //     //   'currency': 'usd',
  //     //   'user_id': userId,
  //     //   // 'email': userProfile['user_email'],
  //     //   'email': userProfile['user_email'] ??
  //     //       userProfile['email'] ??
  //     //       '', // Handle both possible email field names
  //     //   'delivery_type': deliveryType,
  //     // };

  //     final paymentData = {
  //       'amount': (cartProvider.getTotalPrice() * 100).toInt(),
  //       'currency': 'usd',
  //       'user_id': userId,
  //       'email': userProfile['email'],
  //       'delivery_type': deliveryType,
  //       'cart_items': cartProvider.cartItems
  //           .map((item) => {
  //                 'product_id': item.service.id,
  //                 'quantity': item.quantity,
  //                 'price': item.service.price
  //               })
  //           .toList()
  //     };

  //     // In _handleCheckout method in cart_screen.dart, add these print statements:
  //     print('Payment Data: $paymentData');
  //     print('User Profile: $userProfile'); // Add this to see full user data

  //     final paymentDetails =
  //         await ApiService.createPaymentIntent(token, paymentData);
  //     print('Payment Response: $paymentDetails');

  //     // final paymentDetails =
  //     //     await ApiService.createPaymentIntent(token, paymentData);

  //     if (paymentDetails['clientSecret'] == null) {
  //       throw Exception('Failed to create payment intent');
  //     }

  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //         merchantDisplayName: 'RFKicks',
  //         style: ThemeMode.light,
  //         appearance: PaymentSheetAppearance(
  //           colors: PaymentSheetAppearanceColors(
  //             primary: Color(0xff3c76ad),
  //           ),
  //           shapes: PaymentSheetShape(
  //             borderRadius: 12,
  //           ),
  //         ),
  //       ),
  //     );

  //     await Stripe.instance.presentPaymentSheet();

  //     await ApiService.updateOrderStatus(
  //         token, paymentDetails['orderId']!, 'completed');

  //     cartProvider.clearCart();

  //     if (mounted) {
  //       CustomSnackbar.show(
  //           context: context, message: 'Order placed successfully!');
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   const SnackBar(content: Text('Order placed successfully!')),
  //       // );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //               'Checkout failed: ${e.toString().replaceAll('Exception: ', '')}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }
  Future<void> _handleCheckout(
      BuildContext context, CartProvider cartProvider) async {
    try {
      final storage = const FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to continue')),
        );
        return;
      }

      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'];

      final deliveryType = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DeliveryTypeSelector(),
      );

      if (deliveryType == null) return;

      final addressResult = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DeliveryAddressForm(
          token: token,
          userId: userId,
        ),
      );

      if (addressResult != true) return;

      // Get original USD prices for payment
      final paymentData = {
        'amount':
            (cartProvider.getTotalPrice() * 100).toInt(), // Original USD price
        'currency': 'usd',
        'user_id': userId,
        'email': userProfile['email'],
        'delivery_type': deliveryType,
        'cart_items': cartProvider.cartItems
            .map((item) => {
                  'product_id': item.service.id,
                  'quantity': item.quantity,
                  'price': item.service.price // Original USD price
                })
            .toList()
      };

      final paymentDetails =
          await ApiService.createPaymentIntent(token, paymentData);

      if (paymentDetails['clientSecret'] == null) {
        throw Exception('Failed to create payment intent');
      }

      // Continue with Stripe payment using USD amounts
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentDetails['clientSecret']!,
          merchantDisplayName: 'RFKicks',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      await ApiService.updateOrderStatus(
          token, paymentDetails['orderId']!, 'completed');
      cartProvider.clearCart();

      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Order placed successfully!');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Checkout failed: ${e.toString().replaceAll('Exception: ', '')}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Widget _buildSubtotalRow(double screenWidth, CartProvider cartProvider) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         "Subtotal",
  //         style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
  //       ),
  //       Text(
  //         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)}",
  //         style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildSubtotalRow(double screenWidth, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Subtotal",
          style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
        ),
        Consumer<CountryProvider>(
          builder: (context, countryProvider, child) {
            double localTotal =
                countryProvider.convertPrice(cartProvider.getTotalPrice());
            return Text(
              countryProvider.formatPrice(localTotal),
              style:
                  TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
            );
          },
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

  // Widget _buildEstimatedTotalRow(
  //     double screenWidth, CartProvider cartProvider) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         "Estimated Total",
  //         style: TextStyle(fontSize: screenWidth * 0.045),
  //       ),
  //       Text(
  //         "US\$${cartProvider.getTotalPrice().toStringAsFixed(2)} + Tax",
  //         style: TextStyle(fontSize: screenWidth * 0.045),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildEstimatedTotalRow(
      double screenWidth, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Estimated Total",
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        Consumer<CountryProvider>(
          builder: (context, countryProvider, child) {
            double localTotal =
                countryProvider.convertPrice(cartProvider.getTotalPrice());
            return Text(
              "${countryProvider.formatPrice(localTotal)} + Tax",
              style: TextStyle(fontSize: screenWidth * 0.045),
            );
          },
        ),
      ],
    );
  }
}

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
    final DateTime today = DateTime.now();
    final DateTime threeDaysLater = today.add(Duration(days: 3));
    final String todayFormatted = DateFormat('EEE, dd MMM').format(today);
    final String threeDaysLaterFormatted =
        DateFormat('EEE, dd MMM').format(threeDaysLater);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  cartItem.service.imagePath,
                  height: screenWidth * 0.38,
                  width: screenWidth * 0.38,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 12),
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
                        style: TextStyle(
                            fontSize: screenWidth * 0.036,
                            color: Color(0xff989898)),
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
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 24,
                  ),
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      onQuantityChanged(cartItem.quantity - 1);
                    }
                  },
                ),
                Text('${cartItem.quantity}', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 24,
                  ),
                  onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                ),
                Spacer(),
                // Text(
                //   "\$${cartItem.service.price.toStringAsFixed(2)}",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                // ),
                Consumer<CountryProvider>(
                  builder: (context, countryProvider, child) {
                    double localPrice =
                        countryProvider.convertPrice(cartItem.service.price);
                    return Text(
                      countryProvider.formatPrice(localPrice),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    );
                  },
                ),

                IconButton(
                  icon: Icon(Icons.delete_outline,
                      size: 24, color: Color(0xff3c76ad)),
                  onPressed: onRemove,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivery", style: TextStyle(fontSize: 16)),
                Text("Arrives $todayFormatted", style: TextStyle(fontSize: 16)),
                Text("to $threeDaysLaterFormatted",
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
