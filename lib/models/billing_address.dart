class BillingAddress {
  final String firstName;
  final String lastName;
  final String address1;
  final String? address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String phone;
  final String? email;
  final bool? isDefault;

  BillingAddress({
    required this.firstName,
    required this.lastName,
    required this.address1,
    this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
    this.email,
    this.isDefault,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'],
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      isDefault: json['address_is_default'] == 1,
    );
  }
}
