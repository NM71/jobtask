import 'package:jobtask/models/billing_address.dart';

class SavedCard {
  final int id;
  final String stripeCardId;
  final String last4;
  final String brand;
  final int expMonth;
  final int expYear;
  final bool isDefault;
  final String cardholderName;
  final String? cardFingerprint;
  final String? cardFunding;
  final BillingAddress billingAddress;
  final String createdAt;
  final String? updatedAt;

  SavedCard({
    required this.id,
    required this.stripeCardId,
    required this.last4,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.isDefault,
    required this.cardholderName,
    this.cardFingerprint,
    this.cardFunding,
    required this.billingAddress,
    required this.createdAt,
    this.updatedAt,
  });

  factory SavedCard.fromJson(Map<String, dynamic> json) {
    return SavedCard(
      id: json['id'],
      stripeCardId: json['stripe_card_id'],
      last4: json['card_last4'],
      brand: json['card_brand'],
      expMonth: int.parse(json['card_exp_month'].toString()),
      expYear: int.parse(json['card_exp_year'].toString()),
      isDefault: json['is_default'] == 1,
      cardholderName: json['card_holder_name'] ?? '',
      cardFingerprint: json['card_fingerprint'],
      cardFunding: json['card_funding'],
      billingAddress: BillingAddress.fromJson(json),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


// -----------------------------------------------------------------


// import 'package:jobtask/models/billing_address.dart';

// class SavedCard {
//   final int id;
//   final String stripeCardId;
//   final String last4;
//   final String brand;
//   final int expMonth;
//   final int expYear;
//   final bool isDefault;
//   final String cardholderName;
//   final String? cardFingerprint;
//   final String? cardFunding;
//   final BillingAddress billingAddress;
//   final String createdAt;
//   final String? updatedAt;

//   SavedCard({
//     required this.id,
//     required this.stripeCardId,
//     required this.last4,
//     required this.brand,
//     required this.expMonth,
//     required this.expYear,
//     required this.isDefault,
//     required this.cardholderName,
//     this.cardFingerprint,
//     this.cardFunding,
//     required this.billingAddress,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   factory SavedCard.fromJson(Map<String, dynamic> json) {
//     return SavedCard(
//       id: json['id'],
//       stripeCardId: json['stripe_card_id'],
//       last4: json['card_last4'],
//       brand: json['card_brand'],
//       expMonth: int.parse(json['card_exp_month'].toString()),
//       expYear: int.parse(json['card_exp_year'].toString()),
//       isDefault: json['is_default'] == 1,
//       cardholderName: json['card_holder_name'] ?? '',
//       cardFingerprint: json['card_fingerprint'],
//       cardFunding: json['card_funding'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       billingAddress: BillingAddress.fromJson(json),
//     );
//   }
// }
// --------------------------------------------------------------------
// class SavedCard {
//   final int id;
//   final String stripeCardId;
//   final String last4;
//   final String brand;
//   final int expMonth;
//   final int expYear;
//   final bool isDefault;
//   final String cardholderName;
//   final BillingAddress billingAddress;
//   final String createdAt;

//   SavedCard({
//     required this.id,
//     required this.stripeCardId,
//     required this.last4,
//     required this.brand,
//     required this.expMonth,
//     required this.expYear,
//     required this.isDefault,
//     required this.cardholderName,
//     required this.billingAddress,
//     required this.createdAt,
//   });

//   factory SavedCard.fromJson(Map<String, dynamic> json) {
//     return SavedCard(
//       id: json['id'],
//       stripeCardId: json['stripe_card_id'],
//       last4: json['card_last4'],
//       brand: json['card_brand'],
//       expMonth: int.parse(json['card_exp_month'].toString()),
//       expYear: int.parse(json['card_exp_year'].toString()),
//       isDefault: json['is_default'] == 1,
//       cardholderName: '${json['first_name']} ${json['last_name']}',
//       createdAt: json['created_at'],
//       billingAddress: BillingAddress.fromJson({
//         'first_name': json['first_name'],
//         'last_name': json['last_name'],
//         'address_1': json['address_1'],
//         'address_2': json['address_2'],
//         'city': json['city'],
//         'state': json['state'],
//         'postcode': json['postcode'],
//         'country': json['country'],
//         'phone': json['phone'],
//       }),
//     );
//   }
// }

// class SavedCard {
//   final int id;
//   final String stripeCardId;
//   final String last4;
//   final String brand;
//   final int expMonth;
//   final int expYear;
//   final bool isDefault;
//   final BillingAddress billingAddress;

//   SavedCard({
//     required this.id,
//     required this.stripeCardId,
//     required this.last4,
//     required this.brand,
//     required this.expMonth,
//     required this.expYear,
//     required this.isDefault,
//     required this.billingAddress,
//   });

//   factory SavedCard.fromJson(Map<String, dynamic> json) {
//     return SavedCard(
//       id: json['id'],
//       stripeCardId: json['stripe_card_id'],
//       last4: json['card_last4'] ?? '',
//       brand: json['card_brand'] ?? 'unknown',
//       expMonth: int.parse(json['card_exp_month'].toString()),
//       expYear: int.parse(json['card_exp_year'].toString()),
//       isDefault: json['is_default'] == 1,
//       billingAddress: BillingAddress.fromJson(json),
//     );
//   }
// }

// class SavedCard {
//   final int id;
//   final String stripeCardId;
//   final String last4;
//   final String brand;
//   final int expMonth;
//   final int expYear;
//   final bool isDefault;
//   final BillingAddress billingAddress;

//   SavedCard({
//     required this.id,
//     required this.stripeCardId,
//     required this.last4,
//     required this.brand,
//     required this.expMonth,
//     required this.expYear,
//     required this.isDefault,
//     required this.billingAddress,
//   });

//   factory SavedCard.fromJson(Map<String, dynamic> json) {
//     return SavedCard(
//       id: json['id'],
//       stripeCardId: json['stripe_card_id'],
//       last4: json['card_last4'],
//       brand: json['card_brand'],
//       expMonth: json['card_exp_month'],
//       expYear: json['card_exp_year'],
//       isDefault: json['is_default'] == 1,
//       billingAddress: BillingAddress.fromJson(json),
//     );
//   }
// }
