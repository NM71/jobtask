// // // import 'package:flutter/material.dart';
// // //
// // // void showCheckoutBottomSheet(BuildContext context) {
// // //   showModalBottomSheet(
// // //     context: context,
// // //     shape: RoundedRectangleBorder(
// // //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// // //     ),
// // //     builder: (context) {
// // //       return Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             Text(
// // //               "ReFresh",
// // //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //             ),
// // //             SizedBox(height: 20),
// // //             Divider(),
// // //             _buildOptionRow(context, "Delivery", "Select Delivery"),
// // //             Divider(),
// // //             _buildOptionRow(context, "Payment", "Select Payment"),
// // //             SizedBox(height: 20),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 // Handle submit payment logic
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 minimumSize: Size(double.infinity, 50), backgroundColor: Color(0xff3c76ad), // Button color matching the image
// // //               ),
// // //               child: Text("Submit Payment"),
// // //             ),
// // //             SizedBox(height: 10),
// // //           ],
// // //         ),
// // //       );
// // //     },
// // //   );
// // // }
// // //
// // // Widget _buildOptionRow(BuildContext context, String title, String actionText) {
// // //   return Padding(
// // //     padding: const EdgeInsets.symmetric(vertical: 10.0),
// // //     child: Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: [
// // //         Text(
// // //           title,
// // //           style: TextStyle(fontSize: 16),
// // //         ),
// // //         Row(
// // //           children: [
// // //             Text(
// // //               actionText,
// // //               style: TextStyle(fontSize: 16, color: Colors.red),
// // //             ),
// // //             Icon(Icons.add, color: Colors.grey),
// // //           ],
// // //         ),
// // //       ],
// // //     ),
// // //   );
// // // }
// // //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:jobtask/screens/cart/cart_provider.dart';
// //
// // class CheckoutBottomSheet extends StatefulWidget {
// //   final List<CartItem> cartItems;
// //
// //   const CheckoutBottomSheet({Key? key, required this.cartItems}) : super(key: key);
// //
// //   @override
// //   _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
// // }
// //
// // class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
// //   String? selectedDelivery;
// //   String? selectedPayment;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: widget.cartItems.length,
// //               itemBuilder: (context, index) {
// //                 final cartItem = widget.cartItems[index];
// //                 return Padding(
// //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                   child: Row(
// //                     children: [
// //                       Image.asset(
// //                         cartItem.service.imagePath,
// //                         height: 50,
// //                         width: 50,
// //                         fit: BoxFit.cover,
// //                       ),
// //                       SizedBox(width: 16),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               cartItem.service.name,
// //                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                             ),
// //                             SizedBox(height: 4),
// //                             Text(
// //                               "Quantity: ${cartItem.quantity}",
// //                               style: TextStyle(fontSize: 14, color: Colors.grey),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Text(
// //                         "\$${cartItem.service.price.toStringAsFixed(2)}",
// //                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           Divider(),
// //           _buildOptionRow(context, "Delivery", selectedDelivery ?? "Select Delivery", () {
// //             // Handle delivery type selection
// //           }),
// //           Divider(),
// //           _buildOptionRow(context, "Payment", selectedPayment ?? "Select Payment", () {
// //             // Handle payment type selection
// //           }),
// //           SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () {
// //               // Handle submit payment logic
// //             },
// //             style: ElevatedButton.styleFrom(
// //               minimumSize: Size(double.infinity, 50),
// //               backgroundColor: Color(0xff3c76ad),
// //             ),
// //             child: Text("Submit Payment"),
// //           ),
// //           SizedBox(height: 10),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildOptionRow(BuildContext context, String title, String actionText, VoidCallback onTap) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 10.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             title,
// //             style: TextStyle(fontSize: 16),
// //           ),
// //           GestureDetector(
// //             onTap: onTap,
// //             child: Row(
// //               children: [
// //                 Text(
// //                   actionText,
// //                   style: TextStyle(fontSize: 16, color: Colors.red),
// //                 ),
// //                 Icon(Icons.add, color: Colors.grey),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/confirmation_screen.dart';
// import 'package:provider/provider.dart';
// import 'cart_provider.dart'; // Ensure this is correctly imported for accessing CartProvider.
//
// class CheckoutWidget extends StatefulWidget {
//   @override
//   _CheckoutWidgetState createState() => _CheckoutWidgetState();
// }
//
// class _CheckoutWidgetState extends State<CheckoutWidget> {
//   // Track each step in the checkout process
//   int _currentStep = 0;
//   String? _deliveryType;
//   String? _paymentType;
//   String _deliveryAddress = '';
//
//   // CartProvider is used to access cart details
//   late CartProvider _cartProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the provider here if needed
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (_currentStep == 0) _selectDeliveryType(),
//           if (_currentStep == 1) _selectPaymentType(),
//           if (_currentStep == 2) _addDeliveryAddress(),
//           if (_currentStep == 3) _confirmationSummary(),
//         ],
//       ),
//     );
//   }
//
//   // Step 1: Select Delivery Type
//   Widget _selectDeliveryType() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Select Delivery Type",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         ListTile(
//           title: Text("Standard Delivery"),
//           leading: Radio<String>(
//             value: "Standard",
//             groupValue: _deliveryType,
//             onChanged: (value) {
//               setState(() {
//                 _deliveryType = value;
//                 _currentStep++;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: Text("Express Delivery"),
//           leading: Radio<String>(
//             value: "Express",
//             groupValue: _deliveryType,
//             onChanged: (value) {
//               setState(() {
//                 _deliveryType = value;
//                 _currentStep++;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Step 2: Select Payment Type
//   Widget _selectPaymentType() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Select Payment Type",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         ListTile(
//           title: Text("Credit Card"),
//           leading: Radio<String>(
//             value: "Credit Card",
//             groupValue: _paymentType,
//             onChanged: (value) {
//               setState(() {
//                 _paymentType = value;
//                 _currentStep++;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: Text("Cash on Delivery"),
//           leading: Radio<String>(
//             value: "Cash on Delivery",
//             groupValue: _paymentType,
//             onChanged: (value) {
//               setState(() {
//                 _paymentType = value;
//                 _currentStep++;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Step 3: Add Delivery Address
//   Widget _addDeliveryAddress() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Enter Delivery Address",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         TextField(
//           onChanged: (value) {
//             _deliveryAddress = value;
//           },
//           decoration: InputDecoration(
//             hintText: "Enter your delivery address",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             if (_deliveryAddress.isNotEmpty) {
//               setState(() {
//                 _currentStep++;
//               });
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Please enter a valid address")),
//               );
//             }
//           },
//           child: Text("Continue"),
//         ),
//       ],
//     );
//   }
//
//   // Step 4: Confirmation Summary
//   Widget _confirmationSummary() {
//     final totalPrice = _cartProvider.getTotalPrice();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Order Summary",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text("Delivery Type: $_deliveryType"),
//         Text("Payment Type: $_paymentType"),
//         Text("Delivery Address: $_deliveryAddress"),
//         SizedBox(height: 10),
//         Text("Total Price: \$${totalPrice.toStringAsFixed(2)}"),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => ConfirmationScreen()),
//             );
//           },
//           child: Text("Proceed to Confirmation"),
//         ),
//       ],
//     );
//   }
// }
//


// Old Checkout
/*
import 'package:flutter/material.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_buttons/my_button_outlined.dart';
import 'package:provider/provider.dart';

class CheckoutFlow extends StatefulWidget {
  @override
  _CheckoutFlowState createState() => _CheckoutFlowState();
}

class _CheckoutFlowState extends State<CheckoutFlow> {
  bool isDeliveryExpanded = false;
  bool isPaymentExpanded = false;
  bool isFreeDeliverySelected = false;
  bool isPickupSelected = false;
  String selectedDeliveryType = '';
  late CartProvider cartProvider;

  // Address form controllers
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _streetController = TextEditingController();
  final _optionalController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCountry = 'US';

  bool showAddressForm = false;
  bool showDeliveryDetails = false;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Total: \$${cart.getTotalPrice().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // _buildRefreshButton(),
                      _buildDeliverySection(),
                      _buildPaymentSection(),
                      if (!showAddressForm && !showDeliveryDetails)
                        _buildContinueButton(),
                      if (showAddressForm) _buildAddressForm(),
                      if (showDeliveryDetails) _buildDeliveryDetails(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _buildRefreshButton() {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(vertical: 12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border(
  //         top: BorderSide(color: Colors.grey[300]!),
  //         bottom: BorderSide(color: Colors.grey[300]!),
  //       ),
  //     ),
  //     child: Center(
  //       child: Text(
  //         'ReFresh',
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDeliverySection() {
    return Column(
      children: [
        ListTile(
          title: Text('Delivery'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Delivery',
                style: TextStyle(color: Colors.red),
              ),
              Icon(
                isDeliveryExpanded ? Icons.remove : Icons.add,
                color: Colors.red,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              isDeliveryExpanded = !isDeliveryExpanded;
            });
          },
        ),
        if (isDeliveryExpanded) ...[
          ListTile(
            leading: Radio<String>(
              value: 'free',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                  isFreeDeliverySelected = true;
                  isPickupSelected = false;
                });
              },
            ),
            title: Text('Free Delivery'),
            subtitle: Text('Arrives Wed, 11 May to Fri, 13 May'),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'pickup',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                  isFreeDeliverySelected = false;
                  isPickupSelected = true;
                });
              },
            ),
            title: Text('Pick-Up'),
            subtitle: Text('Find a Location'),
            trailing: TextButton(
              onPressed: () {},
              child: Text('More Options'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      children: [
        ListTile(
          title: Text('Payment'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Payment',
                style: TextStyle(color: Colors.red),
              ),
              Icon(
                isPaymentExpanded ? Icons.remove : Icons.add,
                color: Colors.red,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              isPaymentExpanded = !isPaymentExpanded;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddressForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Delivery Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _line1Controller,
            decoration: InputDecoration(
              hintText: 'Lorem',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _line2Controller,
            decoration: InputDecoration(
              hintText: 'Ipsum',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _streetController,
            decoration: InputDecoration(
              hintText: '2950 S 108th St',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _optionalController,
            decoration: InputDecoration(
              hintText: 'Address Line 2 (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _zipController,
            decoration: InputDecoration(
              hintText: '53227',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'West Allis',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 100,
                child: DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'US', child: Text('US')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: '652-858-0392',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'United States',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              setState(() {
                showAddressForm = false;
                showDeliveryDetails = true;
              });
            },
            child: Text('Add Delivery Address'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text('Delivery Details'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_line1Controller.text}, ${_phoneController.text}'),
              Text(
                  '${_streetController.text}, ${_cityController.text}, United States'),
            ],
          ),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                showDeliveryDetails = false;
                showAddressForm = true;
              });
            },
            child: Text('Edit'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton(text: "Continue", onTap: () {}),
          // child: ElevatedButton(
          //   onPressed: () {
          //     // Handle continue
          //   },
          //   child: Text('Continue'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blue,
          //     padding: EdgeInsets.symmetric(vertical: 16),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ElevatedButton(
          //   onPressed: selectedDeliveryType.isNotEmpty ? () {
          //     setState(() {
          //       showAddressForm = true;
          //     });
          //   } : null,
          //   child: Text('Continue'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blue,
          //     padding: EdgeInsets.symmetric(vertical: 16),
          //   ),
          // ),

          MyButton(
            text: "Continue",
            onTap: () => selectedDeliveryType.isNotEmpty
                ? () {
                    setState(() {
                      showAddressForm = true;
                    });
                  }
                : null,
          ),

          if (selectedDeliveryType.isNotEmpty)
            // TextButton(
            //   onPressed: () {
            //     setState(() {
            //       showAddressForm = true;
            //     });
            //   },
            //   child: Text('Add Address'),
            // ),
            MyButtonOutlined(
              text: "Add Address",
              onTap: () {
                setState(() {
                  showAddressForm = true;
                });
              },
              textStyle: TextStyle(color: Color(0xff3c76ad)),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _streetController.dispose();
    _optionalController.dispose();
    _zipController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

 */




import 'package:flutter/material.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_buttons/my_button_outlined.dart';
import 'package:provider/provider.dart';

class CheckoutFlow extends StatefulWidget {
  @override
  _CheckoutFlowState createState() => _CheckoutFlowState();
}

class _CheckoutFlowState extends State<CheckoutFlow> {
  bool isDeliveryExpanded = false;
  bool isPaymentExpanded = false;
  bool isFreeDeliverySelected = false;
  bool isPickupSelected = false;
  String selectedDeliveryType = '';
  late CartProvider cartProvider;

  // Address form controllers
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _streetController = TextEditingController();
  final _optionalController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCountry = 'US';

  bool showAddressForm = false;
  bool showDeliveryDetails = false;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Total: \$${cart.getTotalPrice().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildDeliverySection(),
                      _buildPaymentSection(),
                      if (!showAddressForm && !showDeliveryDetails)
                        _buildContinueButton(),
                      if (showAddressForm) _buildAddressForm(),
                      if (showDeliveryDetails) _buildDeliveryDetails(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeliverySection() {
    return Column(
      children: [
        ListTile(
          title: Text('Delivery'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Delivery',
                style: TextStyle(color: Colors.red),
              ),
              Icon(
                isDeliveryExpanded ? Icons.remove : Icons.add,
                color: Colors.red,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              isDeliveryExpanded = !isDeliveryExpanded;
            });
          },
        ),
        if (isDeliveryExpanded) ...[
          ListTile(
            leading: Radio<String>(
              value: 'free',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                  isFreeDeliverySelected = true;
                  isPickupSelected = false;
                });
              },
            ),
            title: Text('Free Delivery'),
            subtitle: Text('Arrives Wed, 11 May to Fri, 13 May'),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'pickup',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                  isFreeDeliverySelected = false;
                  isPickupSelected = true;
                });
              },
            ),
            title: Text('Pick-Up'),
            subtitle: Text('Find a Location'),
            trailing: TextButton(
              onPressed: () {},
              child: Text('More Options'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      children: [
        ListTile(
          title: Text('Payment'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Payment',
                style: TextStyle(color: Colors.red),
              ),
              Icon(
                isPaymentExpanded ? Icons.remove : Icons.add,
                color: Colors.red,
              ),
            ],
          ),
          onTap: () {
            setState(() {
              isPaymentExpanded = !isPaymentExpanded;
            });
          },
        ),
        if (isPaymentExpanded) ...[
          ListTile(
            leading: Radio<String>(
              value: 'paypal',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                });
              },
            ),
            title: Text('PayPal'),
          ),
          ListTile(
            leading: Radio<String>(
              value: 'credit_card',
              groupValue: selectedDeliveryType,
              onChanged: (value) {
                setState(() {
                  selectedDeliveryType = value!;
                });
              },
            ),
            title: Text('Credit Card'),
          ),
        ],
      ],
    );
  }

  Widget _buildAddressForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Delivery Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _line1Controller,
            decoration: InputDecoration(
              hintText: 'Lorem',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _line2Controller,
            decoration: InputDecoration(
              hintText: 'Ipsum',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _streetController,
            decoration: InputDecoration(
              hintText: '2950 S 108th St',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _optionalController,
            decoration: InputDecoration(
              hintText: 'Address Line 2 (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _zipController,
            decoration: InputDecoration(
              hintText: '53227',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'West Allis',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 100,
                child: DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'US', child: Text('US')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: '652-858-0392',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'United States',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              setState(() {
                showAddressForm = false;
                showDeliveryDetails = true;
              });
            },
            child: Text('Add Delivery Address'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text('Delivery Details'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_line1Controller.text}, ${_phoneController.text}'),
              Text(
                  '${_streetController.text}, ${_cityController.text}, United States'),
            ],
          ),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                showDeliveryDetails = false;
                showAddressForm = true;
              });
            },
            child: Text('Edit'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton(text: "Continue", onTap: () {}),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyButton(
            text: "Continue",
            onTap: () => selectedDeliveryType.isNotEmpty
                ? () {
              setState(() {
                showAddressForm = true;
              });
            }
                : null,
          ),
          if (selectedDeliveryType.isNotEmpty)
            MyButtonOutlined(
              text: "Add Address",
              onTap: () {
                setState(() {
                  showAddressForm = true;
                });
              },
              textStyle: TextStyle(color: Color(0xff3c76ad)),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _streetController.dispose();
    _optionalController.dispose();
    _zipController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}