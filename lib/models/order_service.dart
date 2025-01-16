// class OrderService {
//   final int id;
//   final String name;
//   final double price;
//   final int quantity;

//   OrderService({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });

//   factory OrderService.fromJson(Map<String, dynamic> json) {
//     return OrderService(
//       id: json['id'],
//       name: json['name'],
//       price: double.parse(json['price'].toString()),
//       quantity: json['quantity'],
//     );
//   }
// }

// class OrderService {
//   final int id;
//   final String name;
//   final String? description;
//   final double price;
//   final int quantity;

//   OrderService({
//     required this.id,
//     required this.name,
//     this.description,
//     required this.price,
//     required this.quantity,
//   });

//   factory OrderService.fromJson(Map<String, dynamic> json) {
//     return OrderService(
//       id: int.parse(json['id']),
//       name: json['name'],
//       description: json['description'],
//       price: double.parse(json['price']),
//       quantity: int.parse(json['quantity'].toString()),
//     );
//   }
// }

// class OrderService {
//   final int id;
//   final String name;
//   final String? description;
//   final double price;
//   final int quantity;

//   OrderService({
//     required this.id,
//     required this.name,
//     this.description,
//     required this.price,
//     required this.quantity,
//   });

//   factory OrderService.fromJson(Map<String, dynamic> json) {
//     return OrderService(
//       id: int.parse(json['id']),
//       name: json['name'],
//       description: json['description'], // Already nullable
//       price: double.parse(json['price']),
//       quantity: int.parse(json['quantity']),
//     );
//   }
// }
class OrderService {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderService({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderService.fromJson(Map<String, dynamic> json) {
    try {
      return OrderService(
        id: int.parse(json['id']?.toString() ?? '0'),
        name: json['name'] ?? 'Unknown Service',
        description: json['description'],
        price: double.parse(json['price']?.toString() ?? '0.0'),
        quantity: int.parse(json['quantity']?.toString() ?? '1'),
        imageUrl: json['image_url'] ?? '',
      );
    } catch (e) {
      print('Error parsing service: $e');
      print('Service JSON data: $json');
      rethrow;
    }
  }
}
