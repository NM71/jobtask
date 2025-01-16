// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';

// class AddCardScreen extends StatefulWidget {
//   @override
//   _AddCardScreenState createState() => _AddCardScreenState();
// }

// class _AddCardScreenState extends State<AddCardScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final CardFormEditController _cardController = CardFormEditController();

//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _address1Controller = TextEditingController();
//   final _address2Controller = TextEditingController();
//   final _cityController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _postcodeController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _phoneController = TextEditingController();

//   bool _saveCard = true;
//   bool _setAsDefault = false;
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Card'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CardFormField(
//                 controller: _cardController,
//                 style: CardFormStyle(
//                   borderColor: Colors.grey,
//                   textColor: Colors.black,
//                   placeholderColor: Colors.grey,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Billing Address',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               _buildAddressForm(),
//               SizedBox(height: 20),
//               _buildOptions(),
//               SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff3c76ad),
//                     minimumSize: Size(double.infinity, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: _isLoading ? null : _handleSaveCard,
//                   child: _isLoading
//                       ? SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                       : Text(
//                           'Save Card',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressForm() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _address1Controller,
//           decoration: InputDecoration(
//             labelText: 'Address Line 1',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _address2Controller,
//           decoration: InputDecoration(
//             labelText: 'Address Line 2 (Optional)',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _cityController,
//                 decoration: InputDecoration(
//                   labelText: 'City',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _stateController,
//                 decoration: InputDecoration(
//                   labelText: 'State',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _postcodeController,
//                 decoration: InputDecoration(
//                   labelText: 'Postal Code',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _countryController,
//                 decoration: InputDecoration(
//                   labelText: 'Country',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _phoneController,
//           decoration: InputDecoration(
//             labelText: 'Phone Number',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildOptions() {
//     return Column(
//       children: [
//         CheckboxListTile(
//           value: _saveCard,
//           onChanged: (value) => setState(() => _saveCard = value ?? true),
//           title: Text('Save this card for future payments'),
//         ),
//         if (_saveCard)
//           CheckboxListTile(
//             value: _setAsDefault,
//             onChanged: (value) =>
//                 setState(() => _setAsDefault = value ?? false),
//             title: Text('Set as default payment method'),
//           ),
//       ],
//     );
//   }

//   Future<void> _handleSaveCard() async {
//     if (!_formKey.currentState!.validate() ||
//         !_cardController.details.complete) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Please fill all required fields',
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final storage = FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token != null) {
//         // Save billing address first
//         final addressData = {
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'address_1': _address1Controller.text,
//           'address_2': _address2Controller.text,
//           'city': _cityController.text,
//           'state': _stateController.text,
//           'postcode': _postcodeController.text,
//           'country': _countryController.text,
//           'phone': _phoneController.text,
//         };

//         final addressId =
//             await ApiService.saveBillingAddress(token, addressData);

//         // Create Stripe payment method
//         final paymentMethod = await Stripe.instance.createPaymentMethod(
//           params: PaymentMethodParams.card(
//             paymentMethodData: PaymentMethodData(
//               billingDetails: BillingDetails(
//                 name:
//                     '${_firstNameController.text} ${_lastNameController.text}',
//                 phone: _phoneController.text,
//                 email: null, // Will be added from user profile
//                 address: Address(
//                   city: _cityController.text,
//                   country: _countryController.text,
//                   line1: _address1Controller.text,
//                   line2: _address2Controller.text,
//                   postalCode: _postcodeController.text,
//                   state: _stateController.text,
//                 ),
//               ),
//             ),
//           ),
//         );

//         // Save card details
//         final cardData = {
//           'billing_address_id': addressId,
//           'stripe_card_id': paymentMethod.id,
//           'card_last4': _cardController.details.last4,
//           'card_brand': _cardController.details.brand,
//           'card_exp_month': _cardController.details.expiryMonth,
//           'card_exp_year': _cardController.details.expiryYear,
//           'is_default': _setAsDefault,
//         };

//         await ApiService.saveCard(token, cardData);

//         Navigator.pop(context, true);
//         CustomSnackbar.show(
//           context: context,
//           message: 'Card saved successfully',
//         );
//       }
//     } catch (e) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Failed to save card: ${e.toString()}',
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }

// --------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';

// class AddCardScreen extends StatefulWidget {
//   @override
//   _AddCardScreenState createState() => _AddCardScreenState();
// }

// class _AddCardScreenState extends State<AddCardScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _address1Controller = TextEditingController();
//   final _address2Controller = TextEditingController();
//   final _cityController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _postcodeController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _phoneController = TextEditingController();

//   bool _saveCard = true;
//   bool _setAsDefault = false;
//   bool _isLoading = false;
//   CardFieldInputDetails? _card;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.white,
//         title: Text('Add New Card'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: CardField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey[300]!),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey[300]!),
//                     ),
//                   ),
//                   onCardChanged: (card) {
//                     setState(() {
//                       _card = card;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Billing Address',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               _buildAddressForm(),
//               SizedBox(height: 20),
//               _buildOptions(),
//               SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff3c76ad),
//                     minimumSize: Size(double.infinity, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: _isLoading ? null : _handleSaveCard,
//                   child: _isLoading
//                       ? SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                       : Text(
//                           'Save Card',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressForm() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _address1Controller,
//           decoration: InputDecoration(
//             labelText: 'Address Line 1',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _address2Controller,
//           decoration: InputDecoration(
//             labelText: 'Address Line 2 (Optional)',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _cityController,
//                 decoration: InputDecoration(
//                   labelText: 'City',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _stateController,
//                 decoration: InputDecoration(
//                   labelText: 'State',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: _postcodeController,
//                 decoration: InputDecoration(
//                   labelText: 'Postal Code',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: TextFormField(
//                 controller: _countryController,
//                 decoration: InputDecoration(
//                   labelText: 'Country',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value?.isEmpty ?? true ? 'Required' : null,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         TextFormField(
//           controller: _phoneController,
//           decoration: InputDecoration(
//             labelText: 'Phone Number',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildOptions() {
//     return Column(
//       children: [
//         CheckboxListTile(
//           value: _saveCard,
//           onChanged: (value) => setState(() => _saveCard = value ?? true),
//           title: Text('Save this card for future payments'),
//         ),
//         if (_saveCard)
//           CheckboxListTile(
//             value: _setAsDefault,
//             onChanged: (value) =>
//                 setState(() => _setAsDefault = value ?? false),
//             title: Text('Set as default payment method'),
//           ),
//       ],
//     );
//   }

//   Future<void> _handleSaveCard() async {
//     if (!_formKey.currentState!.validate() || _card?.complete != true) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Please fill all required fields',
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final storage = FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token != null) {
//         final addressData = {
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'address_1': _address1Controller.text,
//           'address_2': _address2Controller.text,
//           'city': _cityController.text,
//           'state': _stateController.text,
//           'postcode': _postcodeController.text,
//           'country': _countryController.text,
//           'phone': _phoneController.text,
//         };

//         final addressId =
//             await ApiService.saveBillingAddress(token, addressData);

//         final paymentMethod = await Stripe.instance.createPaymentMethod(
//           params: PaymentMethodParams.card(
//             paymentMethodData: PaymentMethodData(
//               billingDetails: BillingDetails(
//                 name:
//                     '${_firstNameController.text} ${_lastNameController.text}',
//                 phone: _phoneController.text,
//                 email: null,
//                 address: Address(
//                   city: _cityController.text,
//                   country: _countryController.text,
//                   line1: _address1Controller.text,
//                   line2: _address2Controller.text,
//                   postalCode: _postcodeController.text,
//                   state: _stateController.text,
//                 ),
//               ),
//             ),
//           ),
//         );

//         final cardData = {
//           'billing_address_id': addressId,
//           'stripe_payment_method_id': paymentMethod.id,
//           'card_last4': _card?.last4,
//           'card_brand': _card?.brand,
//           'card_exp_month': _card?.expiryMonth,
//           'card_exp_year': _card?.expiryYear,
//           'is_default': _setAsDefault,
//         };

//         await ApiService.saveCard(token, cardData);

//         Navigator.pop(context, true);
//         CustomSnackbar.show(
//           context: context,
//           message: 'Card saved successfully',
//         );
//       }
//     } catch (e) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Failed to save card: ${e.toString()}',
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }

//----------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';

// class AddCardScreen extends StatefulWidget {
//   @override
//   _AddCardScreenState createState() => _AddCardScreenState();
// }

// class _AddCardScreenState extends State<AddCardScreen> {
//   int _currentStep = 0;
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _address1Controller = TextEditingController();
//   final _address2Controller = TextEditingController();
//   final _cityController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _postcodeController = TextEditingController();
//   final _countryController = TextEditingController();
//   final _phoneController = TextEditingController();

//   bool _saveCard = true;
//   bool _setAsDefault = false;
//   bool _isLoading = false;
//   CardFieldInputDetails? _card;

//   List<Step> get _steps => [
//         Step(
//           title: Text('Card Details'),
//           content: _buildCardForm(),
//           isActive: _currentStep >= 0,
//         ),
//         Step(
//           title: Text('Billing Address'),
//           content: _buildAddressForm(),
//           isActive: _currentStep >= 1,
//         ),
//       ];

//   Widget _buildCardForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: CardField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//             ),
//             onCardChanged: (card) {
//               setState(() {
//                 _card = card;
//               });
//             },
//           ),
//         ),
//         SizedBox(height: 20),
//         _buildOptions(),
//       ],
//     );
//   }

//   Widget _buildAddressForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _firstNameController,
//                   keyboardType: TextInputType.name,
//                   textCapitalization: TextCapitalization.words,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'First Name',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: TextFormField(
//                   controller: _lastNameController,
//                   keyboardType: TextInputType.name,
//                   textCapitalization: TextCapitalization.words,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'Last Name',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             controller: _address1Controller,
//             keyboardType: TextInputType.streetAddress,
//             textCapitalization: TextCapitalization.sentences,
//             decoration: InputDecoration(
//               labelText: 'Address Line 1',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             controller: _address2Controller,
//             keyboardType: TextInputType.streetAddress,
//             textCapitalization: TextCapitalization.sentences,
//             decoration: InputDecoration(
//               labelText: 'Address Line 2 (Optional)',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _cityController,
//                   keyboardType: TextInputType.text,
//                   textCapitalization: TextCapitalization.words,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'City',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: TextFormField(
//                   controller: _stateController,
//                   keyboardType: TextInputType.text,
//                   textCapitalization: TextCapitalization.words,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'State',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _postcodeController,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(5),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'Postal Code',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: TextFormField(
//                   controller: _countryController,
//                   keyboardType: TextInputType.text,
//                   textCapitalization: TextCapitalization.words,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: 'Country',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required' : null,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             controller: _phoneController,
//             keyboardType: TextInputType.phone,
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//               LengthLimitingTextInputFormatter(11),
//             ],
//             decoration: InputDecoration(
//               labelText: 'Phone Number',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOptions() {
//     return Column(
//       children: [
//         CheckboxListTile(
//           value: _saveCard,
//           onChanged: (value) => setState(() => _saveCard = value ?? true),
//           title: Text('Save this card for future payments'),
//         ),
//         if (_saveCard)
//           CheckboxListTile(
//             value: _setAsDefault,
//             onChanged: (value) =>
//                 setState(() => _setAsDefault = value ?? false),
//             title: Text('Set as default payment method'),
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.white,
//         title: Text('Add New Card'),
//         centerTitle: true,
//       ),
//       body: Stepper(
//         type: StepperType.horizontal,
//         currentStep: _currentStep,
//         onStepContinue: () {
//           if (_currentStep == 0 && _card?.complete != true) {
//             CustomSnackbar.show(
//               context: context,
//               message: 'Please enter valid card details',
//             );
//             return;
//           }

//           setState(() {
//             if (_currentStep < _steps.length - 1) {
//               _currentStep++;
//             } else {
//               _handleSaveCard();
//             }
//           });
//         },
//         onStepCancel: () {
//           setState(() {
//             if (_currentStep > 0) {
//               _currentStep--;
//             }
//           });
//         },
//         steps: _steps,
//         controlsBuilder: (context, details) {
//           return Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff3c76ad),
//                       minimumSize: Size(double.infinity, 45),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : details.onStepContinue,
//                     child: _isLoading
//                         ? SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : Text(
//                             _currentStep == _steps.length - 1
//                                 ? 'Save Card'
//                                 : 'Next',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                   ),
//                 ),
//                 if (_currentStep > 0) ...[
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         minimumSize: Size(double.infinity, 45),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: details.onStepCancel,
//                       child: Text('Back'),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _handleSaveCard() async {
//     if (!_formKey.currentState!.validate() || _card?.complete != true) {
//       CustomSnackbar.show(
//         context: context,
//         message: 'Please fill all required fields',
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final storage = FlutterSecureStorage();
//       final token = await storage.read(key: 'auth_token');

//       if (token != null) {
//         // Log address data
//         final addressData = {
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'address_1': _address1Controller.text,
//           'address_2': _address2Controller.text,
//           'city': _cityController.text,
//           'state': _stateController.text,
//           'postcode': _postcodeController.text,
//           'country': _countryController.text,
//           'phone': _phoneController.text,
//         };
//         print('Address Data: $addressData');

//         final addressId =
//             await ApiService.saveBillingAddress(token, addressData);
//         print('Address ID received: $addressId');

//         final paymentMethod = await Stripe.instance.createPaymentMethod(
//           params: PaymentMethodParams.card(
//             paymentMethodData: PaymentMethodData(
//               billingDetails: BillingDetails(
//                 name:
//                     '${_firstNameController.text} ${_lastNameController.text}',
//                 phone: _phoneController.text,
//                 email: null,
//                 address: Address(
//                   city: _cityController.text,
//                   country: _countryController.text,
//                   line1: _address1Controller.text,
//                   line2: _address2Controller.text,
//                   postalCode: _postcodeController.text,
//                   state: _stateController.text,
//                 ),
//               ),
//             ),
//           ),
//         );
//         print('Payment Method ID: ${paymentMethod.id}');

//         final cardData = {
//           'billing_address_id': addressId,
//           'stripe_payment_method_id': paymentMethod.id,
//           'card_last4': _card?.last4,
//           'card_brand': _card?.brand,
//           'card_exp_month': _card?.expiryMonth,
//           'card_exp_year': _card?.expiryYear,
//           'is_default': _setAsDefault,
//         };
//         print('Card Data: $cardData');

//         await ApiService.saveCard(token, cardData);
//         print('Card saved successfully');

//         Navigator.pop(context, true);
//         CustomSnackbar.show(
//           context: context,
//           message: 'Card saved successfully',
//         );
//       }
//     } catch (e) {
//       print('Error details: $e');
//       CustomSnackbar.show(
//         context: context,
//         message: 'Failed to save card: ${e.toString()}',
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   // Future<void> _handleSaveCard() async {
//   //   if (!_formKey.currentState!.validate() || _card?.complete != true) {
//   //     CustomSnackbar.show(
//   //       context: context,
//   //       message: 'Please fill all required fields',
//   //     );
//   //     return;
//   //   }

//   //   setState(() => _isLoading = true);

//   //   try {
//   //     final storage = FlutterSecureStorage();
//   //     final token = await storage.read(key: 'auth_token');

//   //     if (token != null) {
//   //       final addressData = {
//   //         'first_name': _firstNameController.text,
//   //         'last_name': _lastNameController.text,
//   //         'address_1': _address1Controller.text,
//   //         'address_2': _address2Controller.text,
//   //         'city': _cityController.text,
//   //         'state': _stateController.text,
//   //         'postcode': _postcodeController.text,
//   //         'country': _countryController.text,
//   //         'phone': _phoneController.text,
//   //       };

//   //       final addressId =
//   //           await ApiService.saveBillingAddress(token, addressData);

//   //       final paymentMethod = await Stripe.instance.createPaymentMethod(
//   //         params: PaymentMethodParams.card(
//   //           paymentMethodData: PaymentMethodData(
//   //             billingDetails: BillingDetails(
//   //               name:
//   //                   '${_firstNameController.text} ${_lastNameController.text}',
//   //               phone: _phoneController.text,
//   //               email: null,
//   //               address: Address(
//   //                 city: _cityController.text,
//   //                 country: _countryController.text,
//   //                 line1: _address1Controller.text,
//   //                 line2: _address2Controller.text,
//   //                 postalCode: _postcodeController.text,
//   //                 state: _stateController.text,
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       );

//   //       final cardData = {
//   //         'billing_address_id': addressId,
//   //         'stripe_payment_method_id': paymentMethod.id,
//   //         'card_last4': _card?.last4,
//   //         'card_brand': _card?.brand,
//   //         'card_exp_month': _card?.expiryMonth,
//   //         'card_exp_year': _card?.expiryYear,
//   //         'is_default': _setAsDefault,
//   //       };

//   //       await ApiService.saveCard(token, cardData);

//   //       Navigator.pop(context, true);
//   //       CustomSnackbar.show(
//   //         context: context,
//   //         message: 'Card saved successfully',
//   //       );
//   //     }
//   //   } catch (e) {
//   //     CustomSnackbar.show(
//   //       context: context,
//   //       message: 'Failed to save card: ${e.toString()}',
//   //     );
//   //   } finally {
//   //     setState(() => _isLoading = false);
//   //   }
//   // }
// }

// ------------------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _saveCard = true;
  bool _setAsDefault = false;
  bool _isLoading = false;
  CardFieldInputDetails? _card;

  List<Step> get _steps => [
        Step(
          title: Text('Card Details'),
          content: _buildCardForm(),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: Text('Billing Address'),
          content: _buildAddressForm(),
          isActive: _currentStep >= 1,
        ),
      ];

  Widget _buildCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CardField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            onCardChanged: (card) {
              setState(() {
                _card = card;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        _buildOptions(),
      ],
    );
  }

  Widget _buildAddressForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _address1Controller,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Address Line 1',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _address2Controller,
            keyboardType: TextInputType.streetAddress,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Address Line 2 (Optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _stateController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _postcodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _countryController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        CheckboxListTile(
          value: _saveCard,
          onChanged: (value) => setState(() => _saveCard = value ?? true),
          title: Text('Save this card for future payments'),
        ),
        if (_saveCard)
          CheckboxListTile(
            value: _setAsDefault,
            onChanged: (value) =>
                setState(() => _setAsDefault = value ?? false),
            title: Text('Set as default payment method'),
          ),
      ],
    );
  }

  Future<void> _handleSaveCard() async {
    if (!_formKey.currentState!.validate() || _card?.complete != true) {
      CustomSnackbar.show(
        context: context,
        message: 'Please fill all required fields',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final addressData = {
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'address_1': _address1Controller.text,
          'address_2': _address2Controller.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'postcode': _postcodeController.text,
          'country': _countryController.text,
          'phone': _phoneController.text,
          'is_default': _setAsDefault,
        };

        final addressId =
            await ApiService.saveBillingAddress(token, addressData);

        final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
              billingDetails: BillingDetails(
                name:
                    '${_firstNameController.text} ${_lastNameController.text}',
                phone: _phoneController.text,
                email: null,
                address: Address(
                  city: _cityController.text,
                  country: _countryController.text,
                  line1: _address1Controller.text,
                  line2: _address2Controller.text,
                  postalCode: _postcodeController.text,
                  state: _stateController.text,
                ),
              ),
            ),
          ),
        );

        final cardData = {
          'billing_address_id': addressId,
          'stripe_payment_method_id': paymentMethod.id,
          'card_last4': _card?.last4,
          'card_brand': _card?.brand,
          'card_exp_month': _card?.expiryMonth,
          'card_exp_year': _card?.expiryYear,
          'is_default': _setAsDefault,
          'card_holder_name':
              '${_firstNameController.text} ${_lastNameController.text}',
          'card_funding': 'credit',
          'card_fingerprint': paymentMethod.id.split('_').last
          // 'card_funding': _card?.funding ?? 'unknown',
          // 'card_fingerprint': _card?.fingerprint ?? ''
        };

        await ApiService.saveCard(token, cardData);

        Navigator.pop(context, true);
        CustomSnackbar.show(
          context: context,
          message: 'Card saved successfully',
        );
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Failed to save card: ${e.toString()}',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Add New Card'),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && _card?.complete != true) {
            CustomSnackbar.show(
              context: context,
              message: 'Please enter valid card details',
            );
            return;
          }

          setState(() {
            if (_currentStep < _steps.length - 1) {
              _currentStep++;
            } else {
              _handleSaveCard();
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            }
          });
        },
        steps: _steps,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3c76ad),
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _isLoading ? null : details.onStepContinue,
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _currentStep == _steps.length - 1
                                ? 'Save Card'
                                : 'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                if (_currentStep > 0) ...[
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: details.onStepCancel,
                      child: Text('Back'),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
