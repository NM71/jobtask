class DeliveryAddress {
  final String addressType;
  final String firstName;
  final String lastName;
  final String address1;
  final String? address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  DeliveryAddress({
    required this.addressType,
    required this.firstName,
    required this.lastName,
    required this.address1,
    this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      addressType: json['address_type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      address1: json['address_1'],
      address2: json['address_2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
