import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/cart/delivery_address_form.dart';
import 'package:jobtask/services/api_service.dart';

class DeliveryInformationScreen extends StatefulWidget {
  @override
  _DeliveryInformationScreenState createState() =>
      _DeliveryInformationScreenState();
}

class _DeliveryInformationScreenState extends State<DeliveryInformationScreen> {
  Map<String, dynamic>? deliveryAddress;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeliveryAddress();
  }

  Future<void> _loadDeliveryAddress() async {
    try {
      final storage = const FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final userProfile = await ApiService.getUserProfile(token);
        final userId = userProfile['ID'];
        final address = await ApiService.getDeliveryAddress(token, userId);

        if (mounted) {
          setState(() {
            deliveryAddress = address;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _editAddress() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');

    if (token != null) {
      final userProfile = await ApiService.getUserProfile(token);
      final userId = userProfile['ID'];

      final result = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => DeliveryAddressForm(
          token: token,
          userId: userId,
        ),
      );

      if (result == true) {
        await _loadDeliveryAddress();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Delivery Information'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xff3c76ad)))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (deliveryAddress != null) ...[
                    _buildAddressSection(),
                  ] else ...[
                    Center(
                      child: Text('No delivery address found'),
                    ),
                  ],
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3c76ad),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: _editAddress,
                      child: Text(
                        deliveryAddress != null
                            ? 'Update Address'
                            : 'Add Address',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAddressSection() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Color(0xff3c76ad).withOpacity(0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressRow('Name',
                '${deliveryAddress!['first_name']} ${deliveryAddress!['last_name']}'),
            _buildDivider(),
            _buildAddressRow('Phone', deliveryAddress!['phone_number']),
            _buildDivider(),
            _buildAddressRow('Address', deliveryAddress!['address_line1']),
            if (deliveryAddress!['address_line2']?.isNotEmpty ?? false) ...[
              _buildDivider(),
              _buildAddressRow('Address 2', deliveryAddress!['address_line2']),
            ],
            _buildDivider(),
            _buildAddressRow('City', deliveryAddress!['city']),
            _buildDivider(),
            _buildAddressRow('State', deliveryAddress!['state'].toString()),
            _buildDivider(),
            _buildAddressRow('Postal Code', deliveryAddress!['postal_code']),
            _buildDivider(),
            _buildAddressRow('Country',
                deliveryAddress!['country_code'].toString().toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[300]);
  }
}
