// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../shop/shop_screen.dart';

// class CartProvider extends ChangeNotifier {
//   List<CartItem> _cartItems = [];
//   SharedPreferences? _prefs;
//   bool _isInitialized = false;

//   CartProvider() {
//     _initializeCart();
//   }

//   Future<void> _initializeCart() async {
//     if (!_isInitialized) {
//       _prefs = await SharedPreferences.getInstance();
//       String? cartData = _prefs?.getString('cart');
//       if (cartData != null) {
//         List<dynamic> decodedData = json.decode(cartData);
//         _cartItems =
//             decodedData.map((item) => CartItem.fromJson(item)).toList();
//         notifyListeners();
//       }
//       _isInitialized = true;
//     }
//   }

//   List<CartItem> get cartItems => _cartItems;

//   void clearCart() {
//     _cartItems.clear();
//     _saveCart();
//     notifyListeners();
//   }

//   void _saveCart() async {
//     if (_prefs != null) {
//       List<Map<String, dynamic>> cartData =
//           _cartItems.map((item) => item.toJson()).toList();
//       await _prefs!.setString('cart', json.encode(cartData));
//     }
//   }

//   void addToCart(Service service, {int quantity = 1}) {
//     for (var item in _cartItems) {
//       if (item.service.id == service.id) {
//         item.quantity += quantity;
//         _saveCart();
//         notifyListeners();
//         return;
//       }
//     }

//     final newItem = CartItem(service: service, quantity: quantity);
//     _cartItems.add(newItem);
//     _saveCart();
//     notifyListeners();
//   }

//   void removeFromCart(Service service) {
//     _cartItems.removeWhere((item) => item.service.id == service.id);
//     _saveCart();
//     notifyListeners();
//   }

//   void updateQuantity(Service service, int newQuantity) {
//     for (var item in _cartItems) {
//       if (item.service.id == service.id) {
//         item.quantity = newQuantity;
//         _saveCart();
//         notifyListeners();
//         break;
//       }
//     }
//   }

//   double getTotalPrice() {
//     return _cartItems.fold(
//         0, (total, item) => total + (item.service.price * item.quantity));
//   }

//   int get itemCount {
//     return _cartItems.fold(0, (sum, item) => sum + item.quantity);
//   }
// }

// class CartItem {
//   final Service service;
//   int quantity;

//   CartItem({required this.service, this.quantity = 1});

//   Map<String, dynamic> toJson() {
//     return {
//       'service': service.toJson(),
//       'quantity': quantity,
//     };
//   }

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       service: Service.fromJson(json['service']),
//       quantity: json['quantity'],
//     );
//   }
// }

// extension ServiceJson on Service {
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'image_path': imagePath,
//       'description': description,
//       'service_type': serviceType,
//     };
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shop/shop_screen.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  SharedPreferences? _prefs;
  bool _isInitialized = false;
  String? _userId;

  CartProvider() {
    _initializeCart();
  }

  void setUserId(String? userId) {
    _userId = userId;
    _initializeCart();
  }

  Future<void> _initializeCart() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      if (_userId != null) {
        String? cartData = _prefs?.getString('cart_${_userId}');
        if (cartData != null) {
          List<dynamic> decodedData = json.decode(cartData);
          _cartItems =
              decodedData.map((item) => CartItem.fromJson(item)).toList();
          notifyListeners();
        }
      }
      _isInitialized = true;
    }
  }

  List<CartItem> get cartItems => _cartItems;

  void clearCart() {
    _cartItems.clear();
    _saveCart();
    notifyListeners();
  }

  void clearUserCart() {
    if (_userId != null && _prefs != null) {
      _prefs!.remove('cart_${_userId}');
      _cartItems.clear();
      notifyListeners();
    }
  }

  void _saveCart() async {
    if (_prefs != null && _userId != null) {
      List<Map<String, dynamic>> cartData =
          _cartItems.map((item) => item.toJson()).toList();
      await _prefs!.setString('cart_${_userId}', json.encode(cartData));
    }
  }

  void addToCart(Service service, {int quantity = 1}) {
    for (var item in _cartItems) {
      if (item.service.id == service.id) {
        item.quantity += quantity;
        _saveCart();
        notifyListeners();
        return;
      }
    }

    final newItem = CartItem(service: service, quantity: quantity);
    _cartItems.add(newItem);
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(Service service) {
    _cartItems.removeWhere((item) => item.service.id == service.id);
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(Service service, int newQuantity) {
    for (var item in _cartItems) {
      if (item.service.id == service.id) {
        item.quantity = newQuantity;
        _saveCart();
        notifyListeners();
        break;
      }
    }
  }

  double getTotalPrice() {
    return _cartItems.fold(
        0, (total, item) => total + (item.service.price * item.quantity));
  }

  int get itemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}

class CartItem {
  final Service service;
  int quantity;

  CartItem({required this.service, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'service': service.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      service: Service.fromJson(json['service']),
      quantity: json['quantity'],
    );
  }
}

extension ServiceJson on Service {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_path': imagePath,
      'description': description,
      'service_type': serviceType,
    };
  }
}
