// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/checkout/order_receipt_screen.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:jobtask/screens/cart/delivery_address_form.dart';
// import 'package:jobtask/utils/receipt_dialog.dart';
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
//   Map<String, dynamic>? deliveryAddress;

//   bool isDeliveryExpanded = false;
//   bool isPaymentExpanded = false;
//   String? selectedDeliveryType;
//   String? selectedPaymentMethod;
//   bool hasDeliveryAddress = false;

// // Method to fetch address
// Future<void> _loadDeliveryAddress() async {
//   final storage = const FlutterSecureStorage();
//   final token = await storage.read(key: 'auth_token');
//   if (token != null) {
//     final userProfile = await ApiService.getUserProfile(token);
//     final userId = userProfile['ID'];
//     try {
//       final address = await ApiService.getDeliveryAddress(token, userId);
//       setState(() {
//         deliveryAddress = address;
//         hasDeliveryAddress = true;
//       });
//     } catch (e) {
//       print('No saved address found');
//     }
//   }
// }

// // Payment processing method
//   // Future<void> _processPayment(BuildContext context) async {
//   //   final storage = const FlutterSecureStorage();
//   //   final token = await storage.read(key: 'auth_token');

//   //   if (token == null) {
//   //     CustomSnackbar.show(
//   //         context: context, message: 'Please login to continue');
//   //     return;
//   //   }

//   //   final userProfile = await ApiService.getUserProfile(token);
//   //   final userId = userProfile['ID'];

//   //   final paymentData = {
//   //     'amount': (widget.totalAmount * 100).toInt(),
//   //     'currency': 'usd',
//   //     'user_id': userId,
//   //     'email': userProfile['email'],
//   //     'delivery_type': selectedDeliveryType,
//   //     'payment_method': selectedPaymentMethod?.toLowerCase() ?? 'stripe',
//   //     'payment_method_title': selectedPaymentMethod ?? 'Stripe Payment',
//   //     'cart_items': Provider.of<CartProvider>(context, listen: false)
//   //         .cartItems
//   //         .map((item) => {
//   //               'product_id': item.service.id,
//   //               'quantity': item.quantity,
//   //               'price': item.service.price
//   //             })
//   //         .toList()
//   //   };

//   //   final paymentDetails =
//   //       await ApiService.createPaymentIntent(token, paymentData);

//   //   await Stripe.instance.initPaymentSheet(
//   //     paymentSheetParameters: SetupPaymentSheetParameters(
//   //       paymentIntentClientSecret: paymentDetails['clientSecret']!,
//   //       merchantDisplayName: 'RFKicks',
//   //       style: ThemeMode.light,
//   //       appearance: PaymentSheetAppearance(
//   //         colors: PaymentSheetAppearanceColors(primary: Color(0xff3c76ad)),
//   //         shapes: PaymentSheetShape(borderRadius: 12),
//   //       ),
//   //     ),
//   //   );

//   //   await Stripe.instance.presentPaymentSheet();
//   //   // await ApiService.updateOrderStatus(
//   //   //     token, paymentDetails['orderId']!, 'completed');

//   //   Provider.of<CartProvider>(context, listen: false).clearCart();

//   //   CustomSnackbar.show(
//   //       context: context, message: 'Order placed successfully!');
//   //   Navigator.pop(context, true);
//   // }
//   Future<void> _processPayment(BuildContext context) async {
//     try {
//       final storage = const FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token == null) {
//         CustomSnackbar.show(
//             context: context, message: 'Please login to continue');
//         return;
//       }

//       final userProfile = await ApiService.getUserProfile(token);
//       final userId = userProfile['ID'];
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
//             .toList()
//       };

//       final paymentDetails =
//           await ApiService.createPaymentIntent(token, paymentData);

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
//       // await ApiService.updateOrderStatus(
//       //     token, paymentDetails['orderId']!, 'completed');

//       // Clear cart and close checkout sheet first
//       Provider.of<CartProvider>(context, listen: false).clearCart();
//       Navigator.pop(context); // Close checkout sheet

//       // Get receipt data
//       final orderId = int.parse(paymentDetails['orderId']!);
//       final receipt = await ApiService.getOrderReceipt(token, orderId);

//       // Show receipt dialog
//       await showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => ReceiptDialog(receipt: receipt),
//       );
//       CustomSnackbar.show(
//           context: context, message: 'Order placed successfully!');
//     } catch (e) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Payment failed: ${e.toString()}',
//       );
//     }
//   }

//   // Future<void> _processPayment(BuildContext context) async {
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
//   //     // await ApiService.updateOrderStatus(
//   //     //     token, paymentDetails['orderId']!, 'completed');

//   //     Provider.of<CartProvider>(context, listen: false).clearCart();

//   //     // Get receipt and show receipt screen
//   //     // final receipt = await ApiService.getOrderReceipt(
//   //     //     token, int.parse(paymentDetails['orderId']!));

//   //     // Get and display receipt
//   //     final orderId = int.parse(paymentDetails['orderId']!);
//   //     final receipt = await ApiService.getOrderReceipt(token, orderId);

//   //     // Navigator.of(context).pushAndRemoveUntil(
//   //     //   MaterialPageRoute(
//   //     //     builder: (context) => OrderReceiptScreen(receipt: receipt),
//   //     //   ),
//   //     //   (route) => route.isFirst,
//   //     // );
//   //     // Navigator.pushReplacement(
//   //     //   context,
//   //     //   MaterialPageRoute(
//   //     //     builder: (context) => OrderReceiptScreen(receipt: receipt),
//   //     //   ),
//   //     // );
//   //     // Show receipt dialog
//   //     if (mounted) {
//   //       showDialog(
//   //         context: context,
//   //         barrierDismissible: true,
//   //         builder: (context) => ReceiptDialog(receipt: receipt),
//   //       ).then((_) {
//   //         // After closing receipt, close checkout sheet
//   //         Navigator.pop(context);
//   //       });
//   //     }

//   //     CustomSnackbar.show(
//   //         context: context, message: 'Order placed successfully!');
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('Payment failed: ${e.toString()}'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //     // CustomSnackbar.show(
//   //     //     context: context, message: 'Payment failed: ${e.toString()}');
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _loadDeliveryAddress();
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
//             'Checkout',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff3c76ad),
//             ),
//           ),
//           SizedBox(height: 20),
//           Divider(),
//           // Delivery Section
//           ExpansionTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Delivery'),
//                 Text(
//                   selectedDeliveryType ?? 'Select Delivery',
//                   style: TextStyle(
//                     color: selectedDeliveryType != null
//                         ? Color(0xff3c76ad)
//                         : Color(0xffca462a),
//                   ),
//                 ),
//               ],
//             ),
//             trailing: Icon(Icons.add),
//             backgroundColor: Colors.grey[50],
//             collapsedBackgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//               side: BorderSide(color: Colors.grey[200]!),
//             ),
//             children: [
//               ListTile(
//                 title: Text('Standard Delivery'),
//                 onTap: () {
//                   setState(() {
//                     selectedDeliveryType = 'Standard Delivery';
//                   });
//                 },
//               ),
//               ListTile(
//                 title: Text('Express Delivery'),
//                 onTap: () {
//                   setState(() {
//                     selectedDeliveryType = 'Express Delivery';
//                   });
//                 },
//               ),
//               if (selectedDeliveryType != null)
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         title: Text(
//                           hasDeliveryAddress
//                               ? 'Delivery Address'
//                               : 'Add Delivery Address',
//                           style: TextStyle(
//                             color:
//                                 hasDeliveryAddress ? Colors.black : Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         subtitle: hasDeliveryAddress
//                             ? Text(
//                                 '${deliveryAddress?['street']}, ${deliveryAddress?['city']}')
//                             : null,
//                         trailing: Icon(Icons.edit),
//                         onTap: () async {
//                           final storage = const FlutterSecureStorage();
//                           final token = await storage.read(key: 'auth_token');

//                           if (token != null) {
//                             final userProfile =
//                                 await ApiService.getUserProfile(token);
//                             final userId = userProfile['ID'];

//                             final result = await showModalBottomSheet<bool>(
//                               context: context,
//                               isScrollControlled: true,
//                               backgroundColor: Colors.transparent,
//                               builder: (context) => DeliveryAddressForm(
//                                 token: token,
//                                 userId: userId,
//                               ),
//                             );
//                             if (result == true) {
//                               _loadDeliveryAddress();
//                             }
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//           Divider(),
//           // SizedBox(height: 16),

//           // Payment Section
//           ExpansionTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Payment'),
//                 Text(
//                   selectedPaymentMethod ?? 'Select Payment',
//                   style: TextStyle(
//                     color: selectedPaymentMethod != null
//                         ? Color(0xff3c76ad)
//                         : Color(0xffca462a),
//                   ),
//                 ),
//               ],
//             ),
//             trailing: Icon(Icons.add),
//             backgroundColor: Colors.grey[50],
//             collapsedBackgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//               side: BorderSide(color: Colors.grey[200]!),
//             ),
//             children: [
//               ListTile(
//                 leading: Image.asset(
//                   'assets/icons/stripe.png',
//                   height: 25,
//                   width: 25,
//                 ),
//                 title: Center(child: Text('Stripe')),
//                 onTap: () {
//                   setState(() {
//                     selectedPaymentMethod = 'Stripe';
//                   });
//                 },
//               ),
//             ],
//           ),
//           Divider(),
//           SizedBox(height: 20),

//           // Pay Button
//           if (selectedDeliveryType != null &&
//               hasDeliveryAddress &&
//               selectedPaymentMethod != null)
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xff3c76ad),
//                 minimumSize: Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () => _processPayment(context),
//               child: Text(
//                 'Pay ${widget.totalAmount.toStringAsFixed(2)} USD',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
// --------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:jobtask/screens/cart/delivery_address_form.dart';
// import 'package:jobtask/utils/receipt_dialog.dart';
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
//   Map<String, dynamic>? deliveryAddress;
//   bool isDeliveryExpanded = false;
//   bool isPaymentExpanded = false;
//   String? selectedDeliveryType;
//   String? selectedPaymentMethod;
//   bool hasDeliveryAddress = false;
//   bool _isProcessing = false;

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

//   Future<void> _processPayment(BuildContext context) async {
//     if (!mounted) return;
//     setState(() => _isProcessing = true);

//     try {
//       final storage = const FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token == null) {
//         CustomSnackbar.show(
//             context: context, message: 'Please login to continue');
//         return;
//       }

//       final userProfile = await ApiService.getUserProfile(token);
//       final userId = userProfile['ID'];
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
//             .toList()
//       };

//       final paymentDetails =
//           await ApiService.createPaymentIntent(token, paymentData);

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

//       if (!mounted) return;
//       Provider.of<CartProvider>(context, listen: false).clearCart();

//       // CustomSnackbar.show(
//       //     context: context, message: 'Order placed successfully!');
//       CustomSnackbar.show(
//           context: context,
//           message:
//               'Your payment was successful! Thank you for shopping with RFKicks');

//       CustomSnackbar.show(
//           context: context,
//           message:
//               'Your order has been placed successfully!, Thank You\nVisit Order History to view your order details');

//       Navigator.pop(context);
//     } catch (e) {
//       if (!mounted) return;
//       CustomSnackbar.show(
//         context: context,
//         message: 'Payment failed: ${e.toString()}',
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _isProcessing = false);
//       }
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

//   //     final orderId = int.parse(paymentDetails['orderId']!);
//   //     final receipt = await ApiService.getOrderReceipt(token, orderId);

//   //     await showDialog(
//   //       context: context,
//   //       barrierDismissible: false,
//   //       builder: (context) => ReceiptDialog(receipt: receipt),
//   //     );
//   //   } catch (e) {
//   //     CustomSnackbar.show(
//   //       context: context,
//   //       message: 'Payment failed: ${e.toString()}',
//   //     );
//   //   } finally {
//   //     setState(() => _isProcessing = false);
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _loadDeliveryAddress();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
//             'Checkout',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff3c76ad),
//             ),
//           ),
//           SizedBox(height: 20),
//           Divider(),
// // Delivery Section
//           ExpansionTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Delivery'),
//                 Text(
//                   selectedDeliveryType ?? 'Select Delivery',
//                   style: TextStyle(
//                     color: selectedDeliveryType != null
//                         ? Color(0xff3c76ad)
//                         : Color(0xffca462a),
//                   ),
//                 ),
//               ],
//             ),
//             trailing: Icon(Icons.add),
//             backgroundColor: Colors.grey[50],
//             collapsedBackgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//               side: BorderSide(color: Colors.grey[200]!),
//             ),
//             children: [
//               ListTile(
//                 title: Text('Standard Delivery'),
//                 onTap: () {
//                   setState(() {
//                     selectedDeliveryType = 'Standard Delivery';
//                   });
//                 },
//               ),
//               ListTile(
//                 title: Text('Express Delivery'),
//                 onTap: () {
//                   setState(() {
//                     selectedDeliveryType = 'Express Delivery';
//                   });
//                 },
//               ),
//               if (selectedDeliveryType != null)
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         title: Text(
//                           hasDeliveryAddress
//                               ? 'Delivery Address'
//                               : 'Add Delivery Address',
//                           style: TextStyle(
//                             color:
//                                 hasDeliveryAddress ? Colors.black : Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         subtitle: hasDeliveryAddress
//                             ? Text(
//                                 '${deliveryAddress?['street']}, ${deliveryAddress?['city']}')
//                             : null,
//                         trailing: Icon(Icons.edit),
//                         onTap: () async {
//                           final storage = const FlutterSecureStorage();
//                           final token = await storage.read(key: 'auth_token');

//                           if (token != null) {
//                             final userProfile =
//                                 await ApiService.getUserProfile(token);
//                             final userId = userProfile['ID'];

//                             final result = await showModalBottomSheet<bool>(
//                               context: context,
//                               isScrollControlled: true,
//                               backgroundColor: Colors.transparent,
//                               builder: (context) => DeliveryAddressForm(
//                                 token: token,
//                                 userId: userId,
//                               ),
//                             );
//                             if (result == true) {
//                               _loadDeliveryAddress();
//                             }
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//           Divider(),
//           // SizedBox(height: 16),

//           // Payment Section
//           ExpansionTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Payment'),
//                 Text(
//                   selectedPaymentMethod ?? 'Select Payment',
//                   style: TextStyle(
//                     color: selectedPaymentMethod != null
//                         ? Color(0xff3c76ad)
//                         : Color(0xffca462a),
//                   ),
//                 ),
//               ],
//             ),
//             trailing: Icon(Icons.add),
//             backgroundColor: Colors.grey[50],
//             collapsedBackgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//               side: BorderSide(color: Colors.grey[200]!),
//             ),
//             children: [
//               ListTile(
//                 leading: Image.asset(
//                   'assets/icons/stripe.png',
//                   height: 25,
//                   width: 25,
//                 ),
//                 title: Center(child: Text('Stripe')),
//                 onTap: () {
//                   setState(() {
//                     selectedPaymentMethod = 'Stripe';
//                   });
//                 },
//               ),
//             ],
//           ),
//           Divider(),
//           SizedBox(height: 20),
//           if (selectedDeliveryType != null &&
//               hasDeliveryAddress &&
//               selectedPaymentMethod != null)
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xff3c76ad),
//                 minimumSize: Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: _isProcessing ? null : () => _processPayment(context),
//               child: _isProcessing
//                   ? SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                   : Text(
//                       'Pay ${widget.totalAmount.toStringAsFixed(2)} USD',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// --------------------------------------------------------------------------
// New Checkout Flow

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/checkout/delivery_selection_sheet.dart';
import 'package:jobtask/screens/checkout/payment_selection_sheet.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:provider/provider.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final double totalAmount;
  final Function(String, String) onCheckout;

  const CheckoutBottomSheet({
    super.key,
    required this.totalAmount,
    required this.onCheckout,
  });

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  String? selectedDeliveryType;
  String? selectedPaymentMethod;
  Map<String, dynamic>? deliveryAddress;
  bool hasDeliveryAddress = false;
  bool _isProcessing = false;

// Methods
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

  Future<void> _showPaymentSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentSelectionSheet(
        initialPaymentMethod: selectedPaymentMethod,
      ),
    );

    if (result != null) {
      setState(() {
        selectedPaymentMethod = result;
      });
    }
  }

  // Payment Processing
  Future<void> _processPayment(BuildContext context) async {
    setState(() => _isProcessing = true);

    try {
      final storage = const FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token == null) {
        CustomSnackbar.show(
            context: context, message: 'Please login to continue');
        return;
      }

      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'];
      final paymentData = {
        'amount': (widget.totalAmount * 100).toInt(),
        'currency': 'usd',
        'user_id': userId,
        'email': userProfile['email'],
        'delivery_type': selectedDeliveryType,
        'payment_method': selectedPaymentMethod?.toLowerCase() ?? 'stripe',
        'payment_method_title': selectedPaymentMethod ?? 'Stripe Payment',
        'cart_items': Provider.of<CartProvider>(context, listen: false)
            .cartItems
            .map((item) => {
                  'product_id': item.service.id,
                  'quantity': item.quantity,
                  'price': item.service.price
                })
            .toList()
      };

      final paymentDetails =
          await ApiService.createPaymentIntent(token, paymentData);

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
      Provider.of<CartProvider>(context, listen: false).clearCart();
      Navigator.pop(context);

      CustomSnackbar.show(
          context: context,
          message:
              'Your payment was successful! Thank you for shopping with RFKicks');

      CustomSnackbar.show(
          context: context,
          message:
              'Your order has been placed successfully!, Thank You\nVisit Order History to view your order details');
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Payment failed: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

// Load Delivery Address
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

  @override
  void initState() {
    super.initState();
    _loadDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _buildDragHandle(),
          const SizedBox(height: 10),
          _buildTitle(),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[300]),
          // const SizedBox(height: 20),
          _buildDeliveryButton(),
          Divider(color: Colors.grey[300]),
          // const SizedBox(height: 16),
          _buildPaymentButton(),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 35),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 4,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Checkout',
      style: TextStyle(
        fontSize: 20,
        // fontWeight: FontWeight.bold,F
        // color: Color(0xff3c76ad),
      ),
    );
  }

  Widget _buildDeliveryButton() {
    return InkWell(
      onTap: () => _showDeliverySheet(),
      child: Container(
        padding: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey[300]!),
        //   borderRadius: BorderRadius.circular(10),
        // ),
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
                        ? Colors.black
                        : Color(0xffca462a),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.black,
                  // color: selectedDeliveryType != null
                  //     ? Colors.black
                  //     : Color(0xffca462a),
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
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey[300]!),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Payment',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  selectedPaymentMethod ?? 'Select Payment',
                  style: TextStyle(
                    color: selectedPaymentMethod != null
                        ? Colors.black
                        : Color(0xffca462a),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.black,
                  // color: selectedDeliveryType != null
                  //     ? Colors.black
                  //     : Color(0xffca462a),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
