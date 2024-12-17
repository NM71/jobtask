import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_profile_border.dart';

class DeliveryAddressForm extends StatefulWidget {
  final String token;
  final int userId;

  const DeliveryAddressForm({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  _DeliveryAddressFormState createState() => _DeliveryAddressFormState();
}

class _DeliveryAddressFormState extends State<DeliveryAddressForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _postalCodeController;
  late TextEditingController _cityController;
  late TextEditingController _phoneController;
  Country? _selectedCountry;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadExistingAddress();
  }

  // ... (keep existing controller initialization and loading methods)
  void _initializeControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
    _postalCodeController = TextEditingController();
    _cityController = TextEditingController();
    _phoneController = TextEditingController();
  }

  Future<void> _loadExistingAddress() async {
    try {
      final address =
          await ApiService.getDeliveryAddress(widget.token, widget.userId);
      if (address != null) {
        setState(() {
          _firstNameController.text = address['first_name'];
          _lastNameController.text = address['last_name'];
          _address1Controller.text = address['address_line1'];
          _address2Controller.text = address['address_line2'] ?? '';
          _postalCodeController.text = address['postal_code'];
          _cityController.text = address['city'];
          _phoneController.text = address['phone_number'];
          // Set country from country_code
          _selectedCountry = Country.parse(address['country_code']);
        });
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate() && _selectedCountry != null) {
      try {
        final addressData = {
          'user_id': widget.userId,
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'address_line1': _address1Controller.text,
          'address_line2': _address2Controller.text,
          'postal_code': _postalCodeController.text,
          'city': _cityController.text,
          'country': _selectedCountry!.name,
          'country_code': _selectedCountry!.countryCode,
          'phone_number': _phoneController.text,
        };

        final success =
            await ApiService.saveDeliveryAddress(widget.token, addressData);
        if (success) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving address: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xff3c76ad),
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xff3c76ad),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextField(
                      controller: _firstNameController,
                      label: 'First Name',
                      prefixIcon: Icons.person_outline,
                    ),
                    _buildTextField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      prefixIcon: Icons.person_outline,
                    ),
                    _buildTextField(
                      controller: _address1Controller,
                      label: 'Address Line 1',
                      prefixIcon: Icons.home_outlined,
                    ),
                    _buildTextField(
                      controller: _address2Controller,
                      label: 'Address Line 2 (Optional)',
                      prefixIcon: Icons.home_outlined,
                      isOptional: true,
                    ),
                    _buildTextField(
                      controller: _postalCodeController,
                      label: 'Postal Code',
                      prefixIcon: Icons.location_on_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      prefixIcon: Icons.location_city_outlined,
                    ),
                    _buildCountrySelector(),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 30),
                    _buildSaveButton(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isOptional = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          // prefixIcon: Icon(prefixIcon, color: Color(0xff3c76ad)),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   borderSide: BorderSide(color: Colors.grey.shade300),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   borderSide: BorderSide(color: Colors.grey.shade300),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          //   borderSide: BorderSide(color: Color(0xff3c76ad)),
          // ),
          border: customProfileBorder(),
          enabledBorder: customProfileBorder(),
          focusedBorder: customProfileBorder(),
          // filled: true,
          // fillColor: Colors.grey.shade50,
        ),
        validator: isOptional
            ? null
            : (value) =>
                value?.isEmpty ?? true ? 'This field is required' : null,
      ),
    );
  }

  Widget _buildCountrySelector() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            countryListTheme: CountryListThemeData(
              borderRadius: BorderRadius.circular(6),
              inputDecoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            onSelect: (Country country) {
              setState(() => _selectedCountry = country);
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey.shade50,
          ),
          child: Row(
            children: [
              Icon(Icons.public, color: Color(0xff3c76ad)),
              SizedBox(width: 12),
              Text(
                _selectedCountry?.name ?? 'Select Country',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedCountry == null ? Colors.grey : Colors.black,
                ),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _saveAddress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff3c76ad),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Add Delivery Address',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
