// // Checkout Flow

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/checkout/delivery_selection_sheet.dart';
// import 'package:jobtask/screens/checkout/payment_selection_sheet.dart';
// import 'package:jobtask/screens/checkout/payment_success_screen.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';

// class CheckoutBottomSheet extends StatefulWidget {
//   final double totalAmount;
//   final Function(String, String) onCheckout;

//   const CheckoutBottomSheet({
//     super.key,
//     required this.totalAmount,
//     required this.onCheckout,
//   });

//   @override
//   _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
// }

// class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
//   String? selectedDeliveryType;
//   String? selectedPaymentMethod;
//   Map<String, dynamic>? deliveryAddress;
//   bool hasDeliveryAddress = false;
//   bool _isProcessing = false;

// // Methods
//   Future<void> _showDeliverySheet() async {
//     final result = await showModalBottomSheet<Map<String, dynamic>>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => DeliverySelectionSheet(
//         initialAddress: deliveryAddress,
//         initialDeliveryType: selectedDeliveryType,
//         hasDeliveryAddress: hasDeliveryAddress,
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         selectedDeliveryType = result['deliveryType'];
//         deliveryAddress = result['address'];
//         hasDeliveryAddress = true;
//       });
//     }
//   }

//   Future<void> _showPaymentSheet() async {
//     final result = await showModalBottomSheet<String>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => PaymentSelectionSheet(
//         initialPaymentMethod: selectedPaymentMethod,
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         selectedPaymentMethod = result;
//       });
//     }
//   }

//   // Payment Processing with Split Flow
//   Future<void> _processPayment(BuildContext context) async {
//     setState(() => _isProcessing = true);

//     try {
//       print("1. Starting payment process"); // Debug point 1

//       final storage = const FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token == null) {
//         CustomSnackbar.show(
//             context: context, message: 'Please login to continue');
//         return;
//       }

//       print("2. Got token, fetching user profile"); // Debug point 2

//       final userProfile = await ApiService.getUserProfile(token);
//       final userId = userProfile['ID'];

//       print("3. Creating payment data"); // Debug point 3

//       final paymentData = {
//         'amount': (widget.totalAmount * 100).toInt(),
//         'currency': 'usd',
//         'user_id': userId,
//         'email': userProfile['email'],
//         'delivery_type': selectedDeliveryType,
//         'payment_method': selectedPaymentMethod?.toLowerCase() ?? 'stripe',
//         'payment_method_title': selectedPaymentMethod ?? 'Stripe Payment',
//         'cart_items': Provider.of<CartProvider>(context, listen: false)
//             .cartItems
//             .map((item) => {
//                   'product_id': item.service.id,
//                   'quantity': item.quantity,
//                   'price': item.service.price
//                 })
//             .toList(),
//         'shipping_first_name': deliveryAddress?['first_name'],
//         'shipping_last_name': deliveryAddress?['last_name'],
//         'shipping_address_1': deliveryAddress?['address_line1'],
//         'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
//         'shipping_city': deliveryAddress?['city'],
//         'shipping_state': deliveryAddress?['state'] ?? '',
//         'shipping_postcode': deliveryAddress?['postal_code'],
//         'shipping_country': deliveryAddress?['country'],
//         'shipping_phone': deliveryAddress?['phone_number'],
//       };

//       print("4. Creating payment intent"); // Debug point 4

//       final paymentDetails =
//           await ApiService.createPaymentIntent(token, paymentData);

//       print("5. Initializing payment sheet"); // Debug point 5

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentDetails['clientSecret']!,
//           merchantDisplayName: 'RFKicks',
//           style: ThemeMode.light,
//           appearance: PaymentSheetAppearance(
//             colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
//             shapes: PaymentSheetShape(borderRadius: 12),
//           ),
//         ),
//       );

//       print("6. Presenting payment sheet"); // Debug point 6

//       await Stripe.instance.presentPaymentSheet();

//       // Create order after successful payment
//       print("7. Creating order"); // Debug point 7

//       await ApiService.createOrder(
//           token, paymentDetails['paymentIntentId']!, paymentData);

//       Provider.of<CartProvider>(context, listen: false).clearCart();
//       Navigator.pop(context);

//       // Show payment success animation
//       Navigator.push(
//           context,
//           PageTransition(
//               child: PaymentSuccessScreen(),
//               type: PageTransitionType.rightToLeft));

//       CustomSnackbar.show(
//           context: context,
//           message:
//               'Your payment was successful! Thank you for shopping with RFKicks');

//       CustomSnackbar.show(
//           context: context,
//           message:
//               'Your order has been placed successfully!, Thank You\nVisit Order History to view your order details');
//     } catch (e) {
//       print("Error in payment process: $e"); // Debug error point

//       CustomSnackbar.show(
//         context: context,
//         message: 'Payment failed: ${e.toString()}',
//       );
//     } finally {
//       setState(() => _isProcessing = false);
//     }
//   }

//   // Future<void> _processPayment(BuildContext context) async {
//   //   setState(() => _isProcessing = true);

//   //   try {
//   //     final storage = const FlutterSecureStorage();
//   //     final token = await storage.read(key: 'auth_token');

//   //     if (token == null) {
//   //       CustomSnackbar.show(
//   //           context: context, message: 'Please login to continue');
//   //       return;
//   //     }

//   //     final userProfile = await ApiService.getUserProfile(token);
//   //     final userId = userProfile['ID'];
//   //     final paymentData = {
//   //       'amount': (widget.totalAmount * 100).toInt(),
//   //       'currency': 'usd',
//   //       'user_id': userId,
//   //       'email': userProfile['email'],
//   //       'delivery_type': selectedDeliveryType,
//   //       'payment_method': selectedPaymentMethod?.toLowerCase() ?? 'stripe',
//   //       'payment_method_title': selectedPaymentMethod ?? 'Stripe Payment',
//   //       'cart_items': Provider.of<CartProvider>(context, listen: false)
//   //           .cartItems
//   //           .map((item) => {
//   //                 'product_id': item.service.id,
//   //                 'quantity': item.quantity,
//   //                 'price': item.service.price
//   //               })
//   //           .toList()
//   //     };

//   //     final paymentDetails =
//   //         await ApiService.createPaymentIntent(token, paymentData);

//   //     await Stripe.instance.initPaymentSheet(
//   //       paymentSheetParameters: SetupPaymentSheetParameters(
//   //         paymentIntentClientSecret: paymentDetails['clientSecret']!,
//   //         merchantDisplayName: 'RFKicks',
//   //         style: ThemeMode.light,
//   //         appearance: PaymentSheetAppearance(
//   //           colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
//   //           shapes: PaymentSheetShape(borderRadius: 12),
//   //         ),
//   //       ),
//   //     );

//   //     await Stripe.instance.presentPaymentSheet();
//   //     Provider.of<CartProvider>(context, listen: false).clearCart();
//   //     Navigator.pop(context);

//   //     CustomSnackbar.show(
//   //         context: context,
//   //         message:
//   //             'Your payment was successful! Thank you for shopping with RFKicks');

//   //     CustomSnackbar.show(
//   //         context: context,
//   //         message:
//   //             'Your order has been placed successfully!, Thank You\nVisit Order History to view your order details');
//   //   } catch (e) {
//   //     CustomSnackbar.show(
//   //       context: context,
//   //       message: 'Payment failed: ${e.toString()}',
//   //     );
//   //   } finally {
//   //     if (mounted) {
//   //       setState(() => _isProcessing = false);
//   //     }
//   //   }
//   // }

// // Load Delivery Address
//   Future<void> _loadDeliveryAddress() async {
//     final storage = const FlutterSecureStorage();
//     final token = await storage.read(key: 'auth_token');
//     if (token != null) {
//       final userProfile = await ApiService.getUserProfile(token);
//       final userId = userProfile['ID'];
//       try {
//         final address = await ApiService.getDeliveryAddress(token, userId);
//         setState(() {
//           deliveryAddress = address;
//           hasDeliveryAddress = true;
//         });
//       } catch (e) {
//         print('No saved address found');
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadDeliveryAddress();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // _buildDragHandle(),
//           const SizedBox(height: 10),
//           _buildTitle(),
//           const SizedBox(height: 20),
//           Divider(color: Colors.grey[300]),
//           // const SizedBox(height: 20),
//           _buildDeliveryButton(),
//           Divider(color: Colors.grey[300]),
//           // const SizedBox(height: 16),
//           _buildPaymentButton(),
//           Divider(color: Colors.grey[300]),
//           const SizedBox(height: 35),
//           _buildSubmitButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDragHandle() {
//     return Container(
//       width: 40,
//       height: 4,
//       margin: EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(2),
//       ),
//     );
//   }

//   Widget _buildTitle() {
//     return Text(
//       'Checkout',
//       style: TextStyle(
//         fontSize: 20,
//         // fontWeight: FontWeight.bold,F
//         // color: Color(0xff3c76ad),
//       ),
//     );
//   }

//   Widget _buildDeliveryButton() {
//     return InkWell(
//       onTap: () => _showDeliverySheet(),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         // decoration: BoxDecoration(
//         //   border: Border.all(color: Colors.grey[300]!),
//         //   borderRadius: BorderRadius.circular(10),
//         // ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Delivery',
//               style: TextStyle(fontSize: 16),
//             ),
//             Row(
//               children: [
//                 Text(
//                   selectedDeliveryType ?? 'Select Delivery',
//                   style: TextStyle(
//                     color: selectedDeliveryType != null
//                         ? Colors.black
//                         : Color(0xffCA462A),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Icon(
//                   Icons.add,
//                   size: 18,
//                   color: Colors.black,
//                   // color: selectedDeliveryType != null
//                   //     ? Colors.black
//                   //     : Color(0xffca462a),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentButton() {
//     return InkWell(
//       onTap: () => _showPaymentSheet(),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         // decoration: BoxDecoration(
//         //   border: Border.all(color: Colors.grey[300]!),
//         //   borderRadius: BorderRadius.circular(10),
//         // ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Payment',
//               style: TextStyle(fontSize: 16),
//             ),
//             Row(
//               children: [
//                 Text(
//                   selectedPaymentMethod ?? 'Select Payment',
//                   style: TextStyle(
//                     color: selectedPaymentMethod != null
//                         ? Colors.black
//                         : Color(0xffCA462A),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Icon(
//                   Icons.add,
//                   size: 18,
//                   color: Colors.black,
//                   // color: selectedDeliveryType != null
//                   //     ? Colors.black
//                   //     : Color(0xffca462a),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     bool isEnabled = selectedDeliveryType != null &&
//         selectedPaymentMethod != null &&
//         hasDeliveryAddress;

//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color(0xff3c76ad),
//         minimumSize: Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       onPressed:
//           isEnabled && !_isProcessing ? () => _processPayment(context) : null,
//       child: _isProcessing
//           ? SizedBox(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             )
//           : Text(
//               'Submit Payment',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobtask/models/saved_card.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/checkout/delivery_selection_sheet.dart';
import 'package:jobtask/screens/checkout/payment_selection_sheet.dart';
import 'package:jobtask/screens/checkout/payment_success_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final double totalAmount;
  final Function(String, String) onCheckout;

  const CheckoutBottomSheet({
    Key? key,
    required this.totalAmount,
    required this.onCheckout,
  }) : super(key: key);

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  String? selectedDeliveryType;
  String? selectedPaymentMethod;
  SavedCard? selectedCard;
  Map<String, dynamic>? deliveryAddress;
  bool hasDeliveryAddress = false;
  bool _isProcessing = false;
  List<SavedCard> savedCards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _loadSavedCards();
    // _loadDeliveryAddress();
    _initializeCheckout();
  }

  Future<void> _initializeCheckout() async {
    setState(() => _isLoading = true);
    try {
      await Future.wait([_loadSavedCards(), _loadDeliveryAddress()]);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSavedCards() async {
    try {
      final storage = const FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final cardsData = await ApiService.getSavedCards(token);
        if (mounted) {
          setState(() {
            savedCards = cardsData;
            // Find default card if exists
            final defaultCard =
                savedCards.where((card) => card.isDefault).toList();
            if (defaultCard.isNotEmpty) {
              selectedCard = defaultCard.first;
              selectedPaymentMethod =
                  'Card ending in ${defaultCard.first.last4}';
            }
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading saved cards: $e');
      }
    }
  }
  // Future<void> _loadSavedCards() async {
  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token != null) {
  //       final cardsData = await ApiService.getSavedCards(token);
  //       setState(() {
  //         savedCards = cardsData;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error loading saved cards: $e');
  //   }
  // }

  Future<void> _loadDeliveryAddress() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    if (token != null) {
      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'];
      try {
        final address = await ApiService.getDeliveryAddress(token, userId);
        setState(() {
          deliveryAddress = address;
          hasDeliveryAddress = true;
        });
      } catch (e) {
        print('No saved address found');
      }
    }
  }

  Future<void> _showDeliverySheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeliverySelectionSheet(
        initialAddress: deliveryAddress,
        initialDeliveryType: selectedDeliveryType,
        hasDeliveryAddress: hasDeliveryAddress,
      ),
    );

    if (result != null) {
      setState(() {
        selectedDeliveryType = result['deliveryType'];
        deliveryAddress = result['address'];
        hasDeliveryAddress = true;
      });
    }
  }

  // Future<void> _showPaymentSheet() async {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //       padding: EdgeInsets.all(20),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Container(
  //             width: 40,
  //             height: 4,
  //             margin: EdgeInsets.only(bottom: 20),
  //             decoration: BoxDecoration(
  //               color: Colors.grey[300],
  //               borderRadius: BorderRadius.circular(2),
  //             ),
  //           ),
  //           Text(
  //             'Select Payment Method',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 20),
  //           if (savedCards.isNotEmpty) ...[
  //             ...savedCards
  //                 .map((card) => ListTile(
  //                       leading: Icon(Icons.credit_card),
  //                       title: Text('**** ${card.last4}'),
  //                       subtitle:
  //                           Text('Expires ${card.expMonth}/${card.expYear}'),
  //                       trailing: card.isDefault
  //                           ? Chip(label: Text('Default'))
  //                           : null,
  //                       onTap: () {
  //                         setState(() {
  //                           selectedCard = card;
  //                           selectedPaymentMethod =
  //                               'Card ending in ${card.last4}';
  //                         });
  //                         Navigator.pop(context);
  //                       },
  //                     ))
  //                 .toList(),
  //             Divider(),
  //           ],
  //           ListTile(
  //             leading: Icon(Icons.add_card),
  //             title: Text('Add New Card'),
  //             onTap: () {
  //               setState(() {
  //                 selectedCard = null;z
  //                 selectedPaymentMethod = 'New Card';
  //               });
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// ------------------------------------------------------------------------
  // Future<void> _showPaymentSheet() async {
  //   final result = await showModalBottomSheet<Map<String, dynamic>>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => PaymentSelectionSheet(
  //       initialPaymentMethod: selectedPaymentMethod,
  //     ),
  //   );

  //   if (result != null) {
  //     setState(() {
  //       selectedPaymentMethod = result['method'];
  //       selectedCard = result['card'];
  //     });
  //   }
  // }
  Future<void> _showPaymentSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentSelectionSheet(
        initialPaymentMethod: selectedPaymentMethod,
        selectedCard: selectedCard,
      ),
    );

    if (result != null) {
      setState(() {
        selectedPaymentMethod = result['method'];
        selectedCard = result['card'];
      });
    }
  }
// -----------------------------------------------------------------------------
  // Future<void> _processPayment(BuildContext context) async {
  //   setState(() => _isProcessing = true);

  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token == null) {
  //       throw Exception('Please login to continue');
  //     }

  //     final userProfile = await ApiService.getUserProfile(token);
  //     final userId = userProfile['ID'];

  //     final cartItems = Provider.of<CartProvider>(context, listen: false)
  //         .cartItems
  //         .map((item) => {
  //               'product_id': item.service.id,
  //               'quantity': item.quantity,
  //               'price': item.service.price
  //             })
  //         .toList();

  //     final paymentData = {
  //       'amount': (widget.totalAmount * 100).toInt(),
  //       'currency': 'usd',
  //       'user_id': userId,
  //       'email': userProfile['email'],
  //       'delivery_type': selectedDeliveryType,
  //       'payment_method': selectedCard?.stripeCardId,
  //       'payment_method_type': 'card',
  //       'use_saved_card': selectedCard != null,
  //       'cart_items': cartItems,
  //       'shipping_first_name': deliveryAddress?['first_name'],
  //       'shipping_last_name': deliveryAddress?['last_name'],
  //       'shipping_address_1': deliveryAddress?['address_line1'],
  //       'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
  //       'shipping_city': deliveryAddress?['city'],
  //       'shipping_state': deliveryAddress?['state'] ?? '',
  //       'shipping_postcode': deliveryAddress?['postal_code'],
  //       'shipping_country': deliveryAddress?['country'],
  //       'shipping_phone': deliveryAddress?['phone_number'],
  //     };

  //     print('Using saved card: ${selectedCard != null}');
  //     print('Payment method ID: ${selectedCard?.stripeCardId}');

  //     final paymentDetails =
  //         await ApiService.createPaymentIntent(token, paymentData);

  //     if (selectedCard == null) {
  //       await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //           merchantDisplayName: 'RFKicks',
  //           style: ThemeMode.light,
  //           appearance: PaymentSheetAppearance(
  //             colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
  //             shapes: PaymentSheetShape(borderRadius: 12),
  //           ),
  //         ),
  //       );

  //       await Stripe.instance.presentPaymentSheet();
  //     }

  //     await ApiService.createOrder(
  //         token, paymentDetails['paymentIntentId']!, paymentData);

  //     Provider.of<CartProvider>(context, listen: false).clearCart();
  //     Navigator.pop(context);

  //     Navigator.push(
  //       context,
  //       PageTransition(
  //           child: PaymentSuccessScreen(),
  //           type: PageTransitionType.rightToLeft),
  //     );

  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment successful! Thank you for shopping with RFKicks',
  //     );
  //   } catch (e) {
  //     print("Payment Error: $e");
  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment failed: ${e.toString()}',
  //     );
  //   } finally {
  //     setState(() => _isProcessing = false);
  //   }
  // }

  // -------------------------------------------------------------
  Future<void> _processPayment(BuildContext context) async {
    setState(() => _isProcessing = true);

    try {
      final storage = const FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        throw Exception('Please login to continue');
      }

      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'];

      final cartItems = Provider.of<CartProvider>(context, listen: false)
          .cartItems
          .map((item) => {
                'product_id': item.service.id,
                'quantity': item.quantity,
                'price': item.service.price
              })
          .toList();

      final paymentData = {
        'amount': (widget.totalAmount * 100).toInt(),
        'currency': 'usd',
        'user_id': userId,
        'email': userProfile['email'],
        'delivery_type': selectedDeliveryType,
        'payment_method': selectedPaymentMethod == 'stripe'
            ? null
            : selectedCard?.stripeCardId,
        'use_saved_card': selectedPaymentMethod == 'saved_card',
        'cart_items': cartItems,
        'shipping_first_name': deliveryAddress?['first_name'],
        'shipping_last_name': deliveryAddress?['last_name'],
        'shipping_address_1': deliveryAddress?['address_line1'],
        'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
        'shipping_city': deliveryAddress?['city'],
        'shipping_state': deliveryAddress?['state'] ?? '',
        'shipping_postcode': deliveryAddress?['postal_code'],
        'shipping_country': deliveryAddress?['country'],
        'shipping_phone': deliveryAddress?['phone_number'],
      };

      final paymentDetails =
          await ApiService.createPaymentIntent(token, paymentData);

      if (selectedPaymentMethod == 'stripe') {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentDetails['clientSecret']!,
            merchantDisplayName: 'RFKicks',
            style: ThemeMode.light,
            appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
              shapes: PaymentSheetShape(borderRadius: 12),
            ),
          ),
        );
        await Stripe.instance.presentPaymentSheet();
      }

      await ApiService.createOrder(
          token, paymentDetails['paymentIntentId']!, paymentData);

      Provider.of<CartProvider>(context, listen: false).clearCart();
      Navigator.pop(context);

      Navigator.push(
        context,
        PageTransition(
            child: PaymentSuccessScreen(),
            type: PageTransitionType.rightToLeft),
      );

      CustomSnackbar.show(
        context: context,
        message: 'Payment successful! Thank you for shopping with RFKicks',
      );
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        // message: 'Payment failed: ${e.toString()}',
        message: 'Payment Failed: Try Again Later',
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  // Future<void> _processPayment(BuildContext context) async {
  //   setState(() => _isProcessing = true);

  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token == null) {
  //       throw Exception('Please login to continue');
  //     }

  //     final userProfile = await ApiService.getUserProfile(token);
  //     final userId = userProfile['ID'];

  //     final cartItems = Provider.of<CartProvider>(context, listen: false)
  //         .cartItems
  //         .map((item) => {
  //               'product_id': item.service.id,
  //               'quantity': item.quantity,
  //               'price': item.service.price
  //             })
  //         .toList();

  //     final paymentData = {
  //       'amount': (widget.totalAmount * 100).toInt(),
  //       'currency': 'usd',
  //       'user_id': userId,
  //       'email': userProfile['email'],
  //       'delivery_type': selectedDeliveryType,
  //       'payment_method': selectedCard?.stripeCardId,
  //       'use_saved_card': selectedCard != null,
  //       'cart_items': cartItems,
  //       'shipping_first_name': deliveryAddress?['first_name'],
  //       'shipping_last_name': deliveryAddress?['last_name'],
  //       'shipping_address_1': deliveryAddress?['address_line1'],
  //       'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
  //       'shipping_city': deliveryAddress?['city'],
  //       'shipping_state': deliveryAddress?['state'] ?? '',
  //       'shipping_postcode': deliveryAddress?['postal_code'],
  //       'shipping_country': deliveryAddress?['country'],
  //       'shipping_phone': deliveryAddress?['phone_number'],
  //     };

  //     final paymentDetails =
  //         await ApiService.createPaymentIntent(token, paymentData);

  //     if (selectedCard == null) {
  //       await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //           merchantDisplayName: 'RFKicks',
  //           style: ThemeMode.light,
  //           appearance: PaymentSheetAppearance(
  //             colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
  //             shapes: PaymentSheetShape(borderRadius: 12),
  //           ),
  //         ),
  //       );

  //       await Stripe.instance.presentPaymentSheet();
  //     }

  //     await ApiService.createOrder(
  //         token, paymentDetails['paymentIntentId']!, paymentData);

  //     Provider.of<CartProvider>(context, listen: false).clearCart();
  //     Navigator.pop(context);

  //     Navigator.push(
  //       context,
  //       PageTransition(
  //           child: PaymentSuccessScreen(),
  //           type: PageTransitionType.rightToLeft),
  //     );

  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment successful! Thank you for shopping with RFKicks',
  //     );
  //   } catch (e) {
  //     print("Payment Error: $e");
  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment failed: ${e.toString()}',
  //     );
  //   } finally {
  //     setState(() => _isProcessing = false);
  //   }
  // }

  // -------------------------------------------------------------
  // Future<void> _processPayment(BuildContext context) async {
  //   setState(() => _isProcessing = true);

  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token == null) {
  //       throw Exception('Please login to continue');
  //     }

  //     final userProfile = await ApiService.getUserProfile(token);
  //     final userId = userProfile['ID'];

  //     final cartItems = Provider.of<CartProvider>(context, listen: false)
  //         .cartItems
  //         .map((item) => {
  //               'product_id': item.service.id,
  //               'quantity': item.quantity,
  //               'price': item.service.price
  //             })
  //         .toList();

  //     final paymentData = {
  //       'amount': (widget.totalAmount * 100).toInt(),
  //       'currency': 'usd',
  //       'user_id': userId,
  //       'email': userProfile['email'],
  //       'delivery_type': selectedDeliveryType,
  //       'payment_method': selectedCard?.stripeCardId,
  //       'payment_method_type': 'card',
  //       'use_saved_card': selectedCard != null,
  //       'confirm': true, // Add this for saved cards
  //       'off_session': selectedCard != null, // Add this for saved cards
  //       'cart_items': cartItems,
  //       'shipping_first_name': deliveryAddress?['first_name'],
  //       'shipping_last_name': deliveryAddress?['last_name'],
  //       'shipping_address_1': deliveryAddress?['address_line1'],
  //       'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
  //       'shipping_city': deliveryAddress?['city'],
  //       'shipping_state': deliveryAddress?['state'] ?? '',
  //       'shipping_postcode': deliveryAddress?['postal_code'],
  //       'shipping_country': deliveryAddress?['country'],
  //       'shipping_phone': deliveryAddress?['phone_number'],
  //     };

  //     final paymentDetails =
  //         await ApiService.createPaymentIntent(token, paymentData);

  //     if (selectedCard == null) {
  //       await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //           merchantDisplayName: 'RFKicks',
  //           style: ThemeMode.light,
  //           appearance: PaymentSheetAppearance(
  //             colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
  //             shapes: PaymentSheetShape(borderRadius: 12),
  //           ),
  //         ),
  //       );

  //       await Stripe.instance.presentPaymentSheet();
  //     } else {
  //       // For saved cards, confirm the payment intent directly
  //       await Stripe.instance.confirmPayment(
  //         paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //         data: PaymentMethodParams.cardFromMethodId(
  //           paymentMethodData: PaymentMethodDataCardFromMethod(
  //             paymentMethodId: selectedCard!.stripeCardId,
  //           ),
  //         ),
  //       );

  //       // await Stripe.instance.confirmPayment(
  //       //   paymentDetails['clientSecret']!,
  //       //   PaymentMethodParams.cardFromMethodId(
  //       //     paymentMethodId: selectedCard!.stripeCardId,
  //       //   ),
  //       // );
  //     }

  //     // Create order after successful payment
  //     await ApiService.createOrder(
  //         token, paymentDetails['paymentIntentId']!, paymentData);

  //     Provider.of<CartProvider>(context, listen: false).clearCart();
  //     Navigator.pop(context);

  //     Navigator.push(
  //       context,
  //       PageTransition(
  //           child: PaymentSuccessScreen(),
  //           type: PageTransitionType.rightToLeft),
  //     );

  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment successful! Thank you for shopping with RFKicks',
  //     );
  //   } catch (e) {
  //     print("Payment Error: $e");
  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment failed: ${e.toString()}',
  //     );
  //   } finally {
  //     setState(() => _isProcessing = false);
  //   }
  // }

  // ------------------------------------------------------------------

  // Future<void> _processPayment(BuildContext context) async {
  //   setState(() => _isProcessing = true);

  //   try {
  //     final storage = const FlutterSecureStorage();
  //     final token = await storage.read(key: 'auth_token');

  //     if (token == null) {
  //       throw Exception('Please login to continue');
  //     }

  //     final userProfile = await ApiService.getUserProfile(token);
  //     final userId = userProfile['ID'];

  //     final paymentData = {
  //       'amount': (widget.totalAmount * 100).toInt(),
  //       'currency': 'usd',
  //       'user_id': userId,
  //       'email': userProfile['email'],
  //       'delivery_type': selectedDeliveryType,
  //       'payment_method': selectedCard?.stripeCardId,
  //       'payment_method_type': 'card',
  //       'use_saved_card': selectedCard != null,
  //       'cart_items': Provider.of<CartProvider>(context, listen: false)
  //           .cartItems
  //           .map((item) => {
  //                 'product_id': item.service.id,
  //                 'quantity': item.quantity,
  //                 'price': item.service.price
  //               })
  //           .toList(),
  //       'shipping_first_name': deliveryAddress?['first_name'],
  //       'shipping_last_name': deliveryAddress?['last_name'],
  //       'shipping_address_1': deliveryAddress?['address_line1'],
  //       'shipping_address_2': deliveryAddress?['address_line2'] ?? '',
  //       'shipping_city': deliveryAddress?['city'],
  //       'shipping_state': deliveryAddress?['state'] ?? '',
  //       'shipping_postcode': deliveryAddress?['postal_code'],
  //       'shipping_country': deliveryAddress?['country'],
  //       'shipping_phone': deliveryAddress?['phone_number'],
  //       'payment_method': selectedCard?.stripeCardId,
  //       'use_saved_card': selectedCard != null,
  //     };

  //     final paymentDetails =
  //         await ApiService.createPaymentIntent(token, paymentData);

  //     // if (selectedCard == null) {
  //     //   await Stripe.instance.initPaymentSheet(
  //     //     paymentSheetParameters: SetupPaymentSheetParameters(
  //     //       paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //     //       merchantDisplayName: 'RFKicks',
  //     //       style: ThemeMode.light,
  //     //       appearance: PaymentSheetAppearance(
  //     //         colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
  //     //         shapes: PaymentSheetShape(borderRadius: 12),
  //     //       ),
  //     //     ),
  //     //   );

  //     //   await Stripe.instance.presentPaymentSheet();
  //     // }
  //     if (selectedCard == null) {
  //       await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentDetails['clientSecret']!,
  //           merchantDisplayName: 'RFKicks',
  //           style: ThemeMode.light,
  //           appearance: PaymentSheetAppearance(
  //             colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
  //             shapes: PaymentSheetShape(borderRadius: 12),
  //           ),
  //         ),
  //       );

  //       await Stripe.instance.presentPaymentSheet();
  //     }

  //     await ApiService.createOrder(
  //         token, paymentDetails['paymentIntentId']!, paymentData);

  //     Provider.of<CartProvider>(context, listen: false).clearCart();
  //     Navigator.pop(context);

  //     Navigator.push(
  //       context,
  //       PageTransition(
  //           child: PaymentSuccessScreen(),
  //           type: PageTransitionType.rightToLeft),
  //     );

  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment successful! Thank you for shopping with RFKicks',
  //     );
  //   } catch (e) {
  //     print("Payment Error: $e");
  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Payment failed: ${e.toString()}',
  //     );
  //   } finally {
  //     setState(() => _isProcessing = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        minHeight: 300,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: _isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text('Checkout', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 40),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3c76ad)),
                ),
                const SizedBox(height: 40),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.grey[300]),
                _buildDeliveryButton(),
                Divider(color: Colors.grey[300]),
                _buildPaymentButton(),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: 35),
                _buildSubmitButton(),
              ],
            ),
    );
  }

  Widget _buildDeliveryButton() {
    return InkWell(
      onTap: () => _showDeliverySheet(),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  selectedDeliveryType ?? 'Select Delivery',
                  style: TextStyle(
                    color: selectedDeliveryType != null
                        ? Color(0xff767676)
                        : Color(0xffCA462A),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return InkWell(
      onTap: () => _showPaymentSheet(),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Payment', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                if (selectedPaymentMethod == 'stripe')
                  Text('Stripe Payment',
                      style: TextStyle(color: Color(0xff767676)))
                else if (selectedCard != null)
                  Row(
                    children: [
                      Text('**** ${selectedCard!.last4}',
                          style: TextStyle(color: Color(0xff767676))),
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/${selectedCard!.brand.toLowerCase()}.svg',
                        height: 24,
                      ),
                    ],
                  )
                else
                  Text('Select Payment',
                      style: TextStyle(color: Color(0xffCA462A))),
                SizedBox(width: 8),
                Icon(Icons.add, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPaymentButton() {
  //   return InkWell(
  //     onTap: () => _showPaymentSheet(),
  //     child: Container(
  //       padding: EdgeInsets.all(16),
  //       // child: Row(
  //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       //   children: [
  //       //     Text(
  //       //       'Payment',
  //       //       style: TextStyle(fontSize: 16),
  //       //     ),
  //       //     Row(
  //       //       children: [
  //       //         Text(
  //       //           selectedPaymentMethod ?? 'Select Payment',
  //       //           style: TextStyle(
  //       //             color: selectedPaymentMethod != null
  //       //                 ? Colors.black
  //       //                 : Color(0xffCA462A),
  //       //           ),
  //       //         ),
  //       //         SizedBox(width: 8),
  //       //         Icon(
  //       //           Icons.add,
  //       //           size: 18,
  //       //           color: Colors.black,
  //       //         ),
  //       //       ],
  //       //     ),
  //       //   ],
  //       // ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Payment',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Row(
  //             children: [
  //               if (selectedCard != null)
  //                 Row(
  //                   children: [
  //                     Text(
  //                       '**** **** ${selectedCard!.last4}',
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                     SizedBox(width: 8),
  //                     SvgPicture.asset(
  //                       'assets/icons/${selectedCard!.brand.toLowerCase()}.svg',
  //                       height: 28,
  //                       width: 42,
  //                     ),
  //                   ],
  //                 )
  //               else
  //                 Text(
  //                   selectedPaymentMethod ?? 'Select Payment',
  //                   style: TextStyle(
  //                     color: selectedPaymentMethod != null
  //                         ? Colors.black
  //                         : Color(0xffCA462A),
  //                   ),
  //                 ),
  //               SizedBox(width: 8),
  //               Icon(Icons.add, size: 18, color: Colors.black),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSubmitButton() {
    bool isEnabled = selectedDeliveryType != null &&
        selectedPaymentMethod != null &&
        hasDeliveryAddress;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff3c76ad),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed:
          isEnabled && !_isProcessing ? () => _processPayment(context) : null,
      child: _isProcessing
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Submit Payment',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
    );
  }
}
