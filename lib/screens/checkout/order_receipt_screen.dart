// // import 'package:flutter/material.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:intl/intl.dart';
// // import 'package:jobtask/models/order_receipt.dart';
// // import 'package:jobtask/services/api_service.dart';
// // import 'package:jobtask/utils/custom_snackbar.dart';

// // class OrderReceiptScreen extends StatelessWidget {
// //   final OrderReceipt receipt;

// //   const OrderReceiptScreen({super.key, required this.receipt});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Color(0xff3c76ad),
// //         title: Text('Order Receipt'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.share),
// //             onPressed: () => _shareReceipt(),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _buildHeader(),
// //             Divider(height: 32),
// //             _buildOrderInfo(),
// //             Divider(height: 32),
// //             _buildServicesList(),
// //             Divider(height: 32),
// //             _buildPriceBreakdown(),
// //             Divider(height: 32),
// //             _buildDeliveryAddress(),
// //             SizedBox(height: 24),
// //             _buildThankYouNote(),
// //             if (receipt.status != 'cancelled' && receipt.status != 'completed')
// //               _buildCancelButton(context),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHeader() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Image.asset('assets/images/rfkicks_logo.png', height: 50),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.end,
// //               children: [
// //                 Text(
// //                   'Order #${receipt.purchaseNumber}',
// //                   style: TextStyle(fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   DateFormat('MMM dd, yyyy').format(receipt.orderDate),
// //                   style: TextStyle(color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         SizedBox(height: 16),
// //         Container(
// //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //           decoration: BoxDecoration(
// //             color: _getStatusColor(receipt.status).withOpacity(0.1),
// //             borderRadius: BorderRadius.circular(6),
// //           ),
// //           child: Text(
// //             receipt.status.toUpperCase(),
// //             style: TextStyle(
// //               color: _getStatusColor(receipt.status),
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Color _getStatusColor(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'completed':
// //         return Colors.green;
// //       case 'processing':
// //         return Colors.blue;
// //       case 'cancelled':
// //         return Colors.red;
// //       default:
// //         return Colors.orange;
// //     }
// //   }

// //   Widget _buildServicesList() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Services',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 12),
// //         ...receipt.services
// //             .map((service) => Padding(
// //                   padding: EdgeInsets.only(bottom: 8),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(service.name),
// //                             Text(
// //                               'Quantity: ${service.quantity}',
// //                               style: TextStyle(color: Colors.grey),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Text(
// //                         '\$${(service.price * service.quantity).toStringAsFixed(2)}',
// //                         style: TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                     ],
// //                   ),
// //                 ))
// //             .toList(),
// //       ],
// //     );
// //   }

// //   Widget _buildPriceBreakdown() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Price Details',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 12),
// //         _buildPriceRow('Subtotal', receipt.subtotal),
// //         _buildPriceRow('Delivery Fee', receipt.deliveryFee),
// //         _buildPriceRow('Tax', receipt.tax),
// //         Divider(height: 16),
// //         _buildPriceRow('Total', receipt.total, isTotal: true),
// //       ],
// //     );
// //   }

// //   Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             label,
// //             style: TextStyle(
// //               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
// //             ),
// //           ),
// //           Text(
// //             '\$${amount.toStringAsFixed(2)}',
// //             style: TextStyle(
// //               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
// //               color: isTotal ? Color(0xff3c76ad) : null,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildThankYouNote() {
// //     return Container(
// //       width: double.infinity,
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Color(0xff3c76ad).withOpacity(0.1),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             'Thank You!',
// //             style: TextStyle(
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xff3c76ad),
// //             ),
// //           ),
// //           SizedBox(height: 8),
// //           Text(
// //             'We appreciate your business and hope to serve you again soon.',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCancelButton(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.only(top: 24),
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.red,
// //           minimumSize: Size(double.infinity, 50),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //         onPressed: () => _showCancelConfirmation(context),
// //         child: Text('Cancel Order'),
// //       ),
// //     );
// //   }

// //   Future<void> _showCancelConfirmation(BuildContext context) async {
// //     final confirmed = await showDialog<bool>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Cancel Order'),
// //         content: Text('Are you sure you want to cancel this order?'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context, false),
// //             child: Text('No'),
// //           ),
// //           ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.red,
// //             ),
// //             onPressed: () => Navigator.pop(context, true),
// //             child: Text('Yes, Cancel'),
// //           ),
// //         ],
// //       ),
// //     );

// //     if (confirmed == true) {
// //       try {
// //         final storage = const FlutterSecureStorage();
// //         final token = await storage.read(key: 'auth_token');

// //         if (token == null) throw Exception('Authentication required');

// //         final success = await ApiService.cancelOrder(token, receipt.orderId);

// //         if (success) {
// //           Navigator.pop(context);
// //           CustomSnackbar.show(
// //             context: context,
// //             message: 'Order cancelled successfully',
// //           );
// //         }
// //       } catch (e) {
// //         CustomSnackbar.show(
// //           context: context,
// //           message: e.toString(),
// //         );
// //       }
// //     }
// //   }

// //   Future<void> _shareReceipt() async {
// //     // Implement receipt sharing functionality
// //   }

// //   Widget _buildOrderInfo() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Order Information',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 12),
// //         _buildInfoRow('Payment Method', receipt.paymentType),
// //         _buildInfoRow('Card Number',
// //             '****${receipt.cardNumber.substring(receipt.cardNumber.length - 4)}'),
// //         _buildInfoRow(
// //             'Order Date', DateFormat('MMM dd, yyyy').format(receipt.orderDate)),
// //       ],
// //     );
// //   }

// //   Widget _buildInfoRow(String label, String value) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(vertical: 4),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(label, style: TextStyle(color: Colors.grey)),
// //           Text(value),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDeliveryAddress() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           'Delivery Address',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 12),
// //         Text('${receipt.address.firstName} ${receipt.address.lastName}'),
// //         Text(receipt.address.address1),
// //         if (receipt.address.address2 != null &&
// //             receipt.address.address2!.isNotEmpty)
// //           Text(receipt.address.address2!),
// //         Text(
// //             '${receipt.address.city}, ${receipt.address.state} ${receipt.address.postcode}'),
// //         Text(receipt.address.country),
// //         SizedBox(height: 8),
// //         Text('Contact Information:',
// //             style: TextStyle(fontWeight: FontWeight.w500)),
// //         Text('Email: ${receipt.address.email}'),
// //         Text('Phone: ${receipt.address.phone}'),
// //       ],
// //     );
// //   }

// //   // Widget _buildDeliveryAddress() {
// //   //   return Column(
// //   //     crossAxisAlignment: CrossAxisAlignment.start,
// //   //     children: [
// //   //       Text(
// //   //         'Delivery Address',
// //   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //   //       ),
// //   //       SizedBox(height: 12),
// //   //       Text(receipt.address.street),
// //   //       Text(
// //   //           '${receipt.address.city}, ${receipt.address.state} ${receipt.address.zipCode}'),
// //   //       Text(receipt.address.country),
// //   //       if (receipt.address.additionalInfo != null)
// //   //         Text(receipt.address.additionalInfo!,
// //   //             style: TextStyle(color: Colors.grey)),
// //   //     ],
// //   //   );
// //   // }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:jobtask/models/order_receipt.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';

// class OrderReceiptScreen extends StatelessWidget {
//   final OrderReceipt receipt;

//   const OrderReceiptScreen({super.key, required this.receipt});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Color(0xff3c76ad),
//         title: Text('Order Receipt'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () => _shareReceipt(),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             Divider(height: 32),
//             _buildOrderInfo(),
//             Divider(height: 32),
//             _buildServicesList(),
//             Divider(height: 32),
//             _buildPriceBreakdown(),
//             SizedBox(height: 24),
//             _buildThankYouNote(),
//             if (receipt.status != 'cancelled' && receipt.status != 'completed')
//               _buildCancelButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset('assets/images/rfkicks_logo.png', height: 50),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   'Order #${receipt.orderId}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   DateFormat('MMM dd, yyyy').format(receipt.dateCreated),
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: _getStatusColor(receipt.status).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Text(
//             receipt.status.toUpperCase(),
//             style: TextStyle(
//               color: _getStatusColor(receipt.status),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Order Information',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         _buildInfoRow('Payment Method', receipt.paymentMethodTitle),
//         if (receipt.transactionId != null)
//           _buildInfoRow('Transaction ID', receipt.transactionId!),
//         _buildInfoRow('Email', receipt.billingEmail ?? 'N/A'),
//       ],
//     );
//   }

//   Widget _buildServicesList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Services',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: receipt.services.length,
//           itemBuilder: (context, index) {
//             final service = receipt.services[index];
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           service.name,
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         if (service.description != null)
//                           Text(
//                             service.description!,
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 12,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text(
//                       'x${service.quantity}',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       '${receipt.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         color: Color(0xff3c76ad),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   // Widget _buildServicesList() {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Services',
//   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //       ),
//   //       SizedBox(height: 12),
//   //       ...receipt.services
//   //           .map((service) => Padding(
//   //                 padding: EdgeInsets.only(bottom: 8),
//   //                 child: Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: [
//   //                     Expanded(
//   //                       child: Column(
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: [
//   //                           Text(service.name),
//   //                           Text(
//   //                             'Quantity: ${service.quantity}',
//   //                             style: TextStyle(color: Colors.grey),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                     Text(
//   //                       '${receipt.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
//   //                       style: TextStyle(fontWeight: FontWeight.bold),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ))
//   //           .toList(),
//   //     ],
//   //   );
//   // }

//   Widget _buildPriceBreakdown() {
//     final subtotal = receipt.services.fold<double>(
//       0,
//       (sum, service) => sum + (service.price * service.quantity),
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Price Details',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         _buildPriceRow('Subtotal', subtotal),
//         _buildPriceRow('Tax', receipt.taxAmount),
//         Divider(height: 16),
//         _buildPriceRow('Total', receipt.totalAmount, isTotal: true),
//       ],
//     );
//   }

//   Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             '${receipt.currency} ${amount.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: isTotal ? Color(0xff3c76ad) : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildPriceBreakdown() {
//   //   final subtotal = receipt.totalAmount - receipt.taxAmount;
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Price Details',
//   //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //       ),
//   //       SizedBox(height: 12),
//   //       _buildPriceRow('Subtotal', subtotal),
//   //       _buildPriceRow('Tax', receipt.taxAmount),
//   //       Divider(height: 16),
//   //       _buildPriceRow('Total', receipt.totalAmount, isTotal: true),
//   //     ],
//   //   );
//   // }

//   // Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
//   //   return Padding(
//   //     padding: EdgeInsets.symmetric(vertical: 4),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         Text(
//   //           label,
//   //           style: TextStyle(
//   //             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//   //           ),
//   //         ),
//   //         Text(
//   //           '${receipt.currency} ${amount.toStringAsFixed(2)}',
//   //           style: TextStyle(
//   //             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//   //             color: isTotal ? Color(0xff3c76ad) : null,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'completed':
//         return Colors.green;
//       case 'processing':
//         return Colors.blue;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.orange;
//     }
//   }

//   Widget _buildThankYouNote() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xff3c76ad).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'Thank You!',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff3c76ad),
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'We appreciate your business and hope to serve you again soon.',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCancelButton(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 24),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red,
//           minimumSize: Size(double.infinity, 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         onPressed: () => _showCancelConfirmation(context),
//         child: Text('Cancel Order'),
//       ),
//     );
//   }

//   Future<void> _showCancelConfirmation(BuildContext context) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Cancel Order'),
//         content: Text('Are you sure you want to cancel this order?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: Text('No'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//             ),
//             onPressed: () => Navigator.pop(context, true),
//             child: Text('Yes, Cancel'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       try {
//         final storage = const FlutterSecureStorage();
//         final token = await storage.read(key: 'auth_token');

//         if (token == null) throw Exception('Authentication required');

//         final success = await ApiService.cancelOrder(token, receipt.orderId);

//         if (success) {
//           Navigator.pop(context);
//           CustomSnackbar.show(
//             context: context,
//             message: 'Order cancelled successfully',
//           );
//         }
//       } catch (e) {
//         CustomSnackbar.show(
//           context: context,
//           message: e.toString(),
//         );
//       }
//     }
//   }

//   Future<void> _shareReceipt() async {
//     // Implement receipt sharing functionality
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(color: Colors.grey)),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
