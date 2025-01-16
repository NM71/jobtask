import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/cart/delivery_address_form.dart';
import 'package:jobtask/services/api_service.dart';

class DeliverySelectionSheet extends StatefulWidget {
  final Map<String, dynamic>? initialAddress;
  final String? initialDeliveryType;
  final bool hasDeliveryAddress;

  const DeliverySelectionSheet({
    Key? key,
    this.initialAddress,
    this.initialDeliveryType,
    this.hasDeliveryAddress = false,
  }) : super(key: key);

  @override
  _DeliverySelectionSheetState createState() => _DeliverySelectionSheetState();
}

class _DeliverySelectionSheetState extends State<DeliverySelectionSheet> {
  String? selectedDeliveryType;
  Map<String, dynamic>? deliveryAddress;
  bool hasAddress = false;
  bool isLoadingAddress = true; // Added this line

  @override
  void initState() {
    super.initState();
    selectedDeliveryType = widget.initialDeliveryType;
    deliveryAddress = widget.initialAddress;
    hasAddress = widget.hasDeliveryAddress;
    _loadDeliveryAddress(); // Added this line
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
            hasAddress = true;
            isLoadingAddress = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingAddress = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Divider(
              color: Color(0xffe4e4e4),
            ),
            _buildDeliveryTypes(),
            Divider(
              color: Color(0xffe4e4e4),
            ),
            _buildDeliveryDetails(),
            SizedBox(height: 24),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Delivery',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
          icon: Text('-', style: TextStyle(fontSize: 24)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildDeliveryTypes() {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Free Delivery',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000)),
          ),
          leading: selectedDeliveryType == 'Free Delivery'
              ? Icon(
                  Icons.check_circle,
                  color: Color(0xff3c76ad),
                  size: 24,
                )
              : Icon(
                  Icons.circle_outlined,
                  color: Color(0xffCDCDCD),
                  size: 24,
                ),
          onTap: () {
            setState(() {
              selectedDeliveryType = 'Free Delivery';
            });
          },
        ),
        Divider(
          color: Color(0xffe4e4e4),
        ),
        ListTile(
          title: Text(
            'Pick-Up',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000)),
          ),
          leading: selectedDeliveryType == 'Pick-Up'
              ? Icon(
                  Icons.check_circle,
                  color: Color(0xff3c76ad),
                  size: 24,
                )
              : Icon(
                  Icons.circle_outlined,
                  color: Color(0xffCDCDCD),
                  size: 24,
                ),
          onTap: () {
            setState(() {
              selectedDeliveryType = 'Pick-Up';
            });
          },
        ),
      ],
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Delivery Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          color: Color(0xffe4e4e4),
        ),
        ListTile(
          title: isLoadingAddress
              ? Row(
                  children: [
                    Text(
                      'Fetching Address...',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff3c76ad)),
                      ),
                    ),
                  ],
                )
              : Text(
                  hasAddress
                      ? '${deliveryAddress?['first_name']} ${deliveryAddress?['last_name']}, ${deliveryAddress?['phone_number']}'
                      : 'Enter Delivery Address',
                  style: TextStyle(
                      color: hasAddress ? Colors.black : Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
          subtitle: hasAddress
              ? Text(
                  '${deliveryAddress?['address_line1']}, ${deliveryAddress?['city']}, ${deliveryAddress?['country_code'].toString().toUpperCase()}',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                )
              : null,
          trailing: TextButton(
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => _editAddress(context),
          ),
        ),
      ],
    );
  }
  // Widget _buildDeliveryDetails() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 16.0),
  //         child: Text(
  //           'Delivery Details',
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //       Divider(
  //         color: Color(0xffe4e4e4),
  //       ),
  //       ListTile(
  //         title: Text(
  //           hasAddress
  //               ? '${deliveryAddress?['first_name']} ${deliveryAddress?['last_name']}, ${deliveryAddress?['phone_number']}'
  //               : 'Enter Delivery Address',
  //           style: TextStyle(
  //               color: hasAddress ? Colors.black : Color(0xffCA462A),
  //               fontWeight: FontWeight.w400,
  //               fontSize: 15),
  //         ),
  //         subtitle: hasAddress
  //             ? Text(
  //                 '${deliveryAddress?['address_line1']}, ${deliveryAddress?['city']}, ${deliveryAddress?['country_code'].toString().toUpperCase()}',
  //                 style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
  //               )
  //             : null,
  //         trailing: TextButton(
  //           child: Text(
  //             'Edit',
  //             style: TextStyle(color: Colors.black),
  //           ),
  //           onPressed: () => _editAddress(context),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildContinueButton() {
    bool isEnabled = selectedDeliveryType != null && hasAddress;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff3c76ad),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: isEnabled
          ? () {
              Navigator.pop(context, {
                'deliveryType': selectedDeliveryType,
                'address': deliveryAddress,
              });
            }
          : null,
      child: Text(
        'Continue',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Future<void> _editAddress(BuildContext context) async {
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
        final address = await ApiService.getDeliveryAddress(token, userId);
        setState(() {
          deliveryAddress = address;
          hasAddress = true;
        });
      }
    }
  }
}
