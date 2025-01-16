// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/models/order_service.dart';

// class OrderReceipt {
//   final int orderId;
//   final String purchaseNumber;
//   final String paymentType;
//   final String cardNumber;
//   final double subtotal;
//   final double deliveryFee;
//   final double tax;
//   final double total;
//   final List<OrderService> services;
//   final Address address;

//   OrderReceipt({
//     required this.orderId,
//     required this.purchaseNumber,
//     required this.paymentType,
//     required this.cardNumber,
//     required this.subtotal,
//     required this.deliveryFee,
//     required this.tax,
//     required this.total,
//     required this.services,
//     required this.address,
//   });

//   factory OrderReceipt.fromJson(Map<String, dynamic> json) {
//     return OrderReceipt(
//       orderId: json['order_id'],
//       purchaseNumber: json['purchase_number'],
//       paymentType: json['payment_type'],
//       cardNumber: json['card_number'],
//       subtotal: double.parse(json['subtotal'].toString()),
//       deliveryFee: double.parse(json['delivery_fee'].toString()),
//       tax: double.parse(json['tax'].toString()),
//       total: double.parse(json['total_amount'].toString()),
//       services: (json['services'] as List)
//           .map((s) => OrderService.fromJson(s))
//           .toList(),
//       address: Address.fromJson(json['address']),
//     );
//   }
// }

// import 'package:jobtask/models/delivery_address.dart';
// import 'package:jobtask/models/order_service.dart';

// class OrderReceipt {
//   final int orderId;
//   final String purchaseNumber;
//   final String paymentType;
//   final String cardNumber;
//   final double subtotal;
//   final double deliveryFee;
//   final double tax;
//   final double total;
//   final List<OrderService> services;
//   final DeliveryAddress address;
//   final String status; // Added status field
//   final DateTime orderDate; // Added order date

//   OrderReceipt({
//     required this.orderId,
//     required this.purchaseNumber,
//     required this.paymentType,
//     required this.cardNumber,
//     required this.subtotal,
//     required this.deliveryFee,
//     required this.tax,
//     required this.total,
//     required this.services,
//     required this.address,
//     required this.status,
//     required this.orderDate,
//   });

//   factory OrderReceipt.fromJson(Map<String, dynamic> json) {
//     return OrderReceipt(
//       orderId: json['order_id'],
//       purchaseNumber: json['purchase_number'],
//       paymentType: json['payment_type'],
//       cardNumber: json['card_number'],
//       subtotal: double.parse(json['subtotal'].toString()),
//       deliveryFee: double.parse(json['delivery_fee'].toString()),
//       tax: double.parse(json['tax'].toString()),
//       total: double.parse(json['total_amount'].toString()),
//       services: (json['services'] as List)
//           .map((s) => OrderService.fromJson(s))
//           .toList(),
//       address: DeliveryAddress.fromJson(json['address']),
//       status: json['status'],
//       orderDate: DateTime.parse(json['order_date']),
//     );
//   }
// }

import 'package:jobtask/models/order_service.dart';

// class OrderReceipt {
//   final int orderId;
//   final String status;
//   final String currency;
//   final String paymentType;
//   final String paymentMethodTitle;
//   final String? transactionId; // Nullable
//   final double? tax; // Nullable
//   final double totalAmount;
//   final int customerId;
//   final String customerEmail;
//   final DateTime dateCreated;
//   final List<OrderService> services;

//   OrderReceipt({
//     required this.orderId,
//     required this.status,
//     required this.currency,
//     required this.paymentType,
//     required this.paymentMethodTitle,
//     this.transactionId,
//     this.tax,
//     required this.totalAmount,
//     required this.customerId,
//     required this.customerEmail,
//     required this.dateCreated,
//     required this.services,
//   });

//   factory OrderReceipt.fromJson(Map<String, dynamic> json) {
//     return OrderReceipt(
//       orderId: int.parse(json['order_id']),
//       status: json['status'] ?? 'pending',
//       currency: json['currency'] ?? 'usd',
//       paymentType: json['payment_type'] ?? '',
//       paymentMethodTitle: json['payment_method_title'] ?? '',
//       transactionId: json['transaction_id'] ?? '', // Already nullable
//       tax: json['tax'] != null ? double.parse(json['tax'].toString()) : null,
//       totalAmount: double.parse(json['total_amount']),
//       customerId: int.parse(json['customer_id']),
//       customerEmail: json['customer_email'] ?? '',
//       dateCreated: DateTime.parse(json['order_date']),
//       services: (json['services'] as List)
//           .map((s) => OrderService.fromJson(s))
//           .toList(),
//     );
//   }
// }

// // class OrderReceipt {
// //   final int orderId;
// //   final String status;
// //   final String currency;
// //   final String paymentMethod;
// //   final String paymentMethodTitle;
// //   final String? transactionId;
// //   final double taxAmount;
// //   final double totalAmount;
// //   final int customerId;
// //   final String? billingEmail;
// //   final DateTime dateCreated;
// //   final List<OrderService> services;

// //   OrderReceipt({
// //     required this.orderId,
// //     required this.status,
// //     required this.currency,
// //     required this.paymentMethod,
// //     required this.paymentMethodTitle,
// //     this.transactionId,
// //     required this.taxAmount,
// //     required this.totalAmount,
// //     required this.customerId,
// //     this.billingEmail,
// //     required this.dateCreated,
// //     required this.services,
// //   });

// //   factory OrderReceipt.fromJson(Map<String, dynamic> json) {
// //     return OrderReceipt(
// //       orderId: int.parse(json['order_id']),
// //       status: json['status'],
// //       currency: json['currency'],
// //       paymentMethod: json['payment_type'],
// //       paymentMethodTitle: json['payment_method_title'],
// //       transactionId: json['transaction_id'],
// //       taxAmount:
// //           json['tax'] != null ? double.parse(json['tax'].toString()) : 0.0,
// //       totalAmount: double.parse(json['total_amount']),
// //       customerId: int.parse(json['customer_id']),
// //       billingEmail: json['customer_email'],
// //       dateCreated: DateTime.parse(json['order_date']),
// //       services: (json['services'] as List)
// //           .map((s) => OrderService.fromJson(s))
// //           .toList(),
// //     );
// //   }

// //   // factory OrderReceipt.fromJson(Map<String, dynamic> json) {
// //   //   return OrderReceipt(
// //   //     orderId: json['order_id'],
// //   //     status: json['status'],
// //   //     currency: json['currency'] ?? 'USD',
// //   //     paymentMethod: json['payment_type'],
// //   //     paymentMethodTitle: json['payment_method_title'],
// //   //     transactionId: json['transaction_id'],
// //   //     taxAmount: double.parse(json['tax'].toString()),
// //   //     totalAmount: double.parse(json['total_amount'].toString()),
// //   //     customerId: json['customer_id'] ?? 0,
// //   //     billingEmail: json['customer_email'],
// //   //     dateCreated: DateTime.parse(json['order_date']),
// //   //     services: (json['services'] as List)
// //   //         .map((s) => OrderService.fromJson(s))
// //   //         .toList(),
// //   //   );
// //   // }
// // }
class OrderReceipt {
  final int orderId;
  final String status;
  final String currency;
  final String paymentType;
  final String paymentMethodTitle;
  final String? transactionId;
  final double? tax;
  final double totalAmount;
  final int customerId;
  final String customerEmail;
  final DateTime dateCreated;
  final List<OrderService> services;
  final String deliveryType;

  OrderReceipt({
    required this.orderId,
    required this.status,
    required this.currency,
    required this.paymentType,
    required this.paymentMethodTitle,
    this.transactionId,
    this.tax,
    required this.totalAmount,
    required this.customerId,
    required this.customerEmail,
    required this.dateCreated,
    required this.services,
    required this.deliveryType,
  });

  factory OrderReceipt.fromJson(Map<String, dynamic> json) {
    try {
      return OrderReceipt(
        orderId: int.parse(json['order_id']?.toString() ?? '0'),
        status: json['status'] ?? 'pending',
        currency: json['currency'] ?? 'usd',
        paymentType: json['payment_type'] ?? 'unknown',
        paymentMethodTitle:
            json['payment_method_title'] ?? 'Unknown Payment Method',
        transactionId: json['transaction_id'],
        tax: json['tax'] != null
            ? double.tryParse(json['tax'].toString())
            : null,
        totalAmount: double.parse(json['total_amount']?.toString() ?? '0.0'),
        customerId: int.parse(json['customer_id']?.toString() ?? '0'),
        customerEmail: json['customer_email'] ?? '',
        dateCreated: json['order_date'] != null
            ? DateTime.parse(json['order_date'])
            : DateTime.now(),
        deliveryType: json['delivery_type'] ?? 'Standard Delivery',
        services: (json['services'] as List? ?? [])
            .map((s) => OrderService.fromJson(s))
            .toList(),
      );
    } catch (e) {
      print('Error parsing order: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  // factory OrderReceipt.fromJson(Map<String, dynamic> json) {
  //   try {
  //     return OrderReceipt(
  //       orderId: int.parse(json['order_id']?.toString() ?? '0'),
  //       status: json['status'] ?? 'pending',
  //       currency: json['currency'] ?? 'usd',
  //       paymentType: json['payment_type'] ?? 'unknown',
  //       paymentMethodTitle:
  //           json['payment_method_title'] ?? 'Unknown Payment Method',
  //       transactionId: json['transaction_id'],
  //       tax: json['tax'] != null
  //           ? double.tryParse(json['tax'].toString())
  //           : null,
  //       totalAmount: double.parse(json['total_amount']?.toString() ?? '0.0'),
  //       customerId: int.parse(json['customer_id']?.toString() ?? '0'),
  //       customerEmail: json['customer_email'] ?? '',
  //       dateCreated: json['order_date'] != null
  //           ? DateTime.parse(json['order_date'])
  //           : DateTime.now(),
  //       deliveryType: json['delivery_type'] ?? 'Standard Delivery',
  //       services: (json['services'] as List? ?? [])
  //           .map((s) => OrderService.fromJson(s))
  //           .toList(),
  //     );
  //   } catch (e) {
  //     print('Error parsing order: $e');
  //     print('JSON data: $json');
  //     rethrow;
  //   }
  // }
}
