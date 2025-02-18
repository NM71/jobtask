import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jobtask/models/order_receipt.dart';
import 'package:jobtask/screens/profile/country_provider.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/receipt_dialog.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<OrderReceipt>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _ordersFuture = _fetchOrders();
  }

  Future<List<OrderReceipt>> _fetchOrders() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    if (token == null) throw Exception('Authentication required');
    return ApiService.getOrderHistory(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Order History'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () => setState(() => _loadOrders()),
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        color: Color(0xff3c76ad),
        onRefresh: () async => setState(() => _loadOrders()),
        child: FutureBuilder<List<OrderReceipt>>(
          future: _ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0xff3c76ad),
              ));
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load orders',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () => setState(() => _loadOrders()),
                      child: Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            final orders = snapshot.data ?? [];
            return orders.isEmpty
                ? _buildEmptyState()
                : _buildOrdersList(orders);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No orders yet',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<OrderReceipt> orders) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index]),
    );
  }

  Widget _buildOrderCard(OrderReceipt order) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => ReceiptDialog(receipt: order),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.orderId}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusChip(order.status),
                ],
              ),
              SizedBox(height: 12),
              Text(
                DateFormat('MMM dd, yyyy').format(order.dateCreated),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                '${order.services.length} service(s)',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<CountryProvider>(
                    builder: (context, countryProvider, child) {
                      double localTotal =
                          countryProvider.convertPrice(order.totalAmount);
                      return Text(
                        countryProvider.formatPrice(localTotal),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3c76ad),
                        ),
                      );
                    },
                  ),
                  // Text(
                  //   '${order.currency.toUpperCase()} ${order.totalAmount.toStringAsFixed(2)}',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xff3c76ad),
                  //   ),
                  // ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'processing':
        color = Colors.blue;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
