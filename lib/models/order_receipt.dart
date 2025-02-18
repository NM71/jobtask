import 'package:jobtask/models/order_service.dart';

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
      rethrow;
    }
  }
}
