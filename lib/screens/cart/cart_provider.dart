import 'package:flutter/foundation.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Service service, {int quantity = 1}) {
    // Check if the service is already in the cart
    for (var item in _cartItems) {
      if (item.service.name == service.name) {
        item.quantity += quantity;
        notifyListeners();
        return;
      }
    }

    // If not in cart, add new cart item
    _cartItems.add(CartItem(service: service, quantity: quantity));
    notifyListeners();
  }

  void removeFromCart(Service service) {
    _cartItems.removeWhere((item) => item.service.name == service.name);
    notifyListeners();
  }

  void updateQuantity(Service service, int newQuantity) {
    for (var item in _cartItems) {
      if (item.service.name == service.name) {
        item.quantity = newQuantity;
        notifyListeners();
        break;
      }
    }
  }

  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + (item.service.price * item.quantity));
  }
}

// Create a CartItem class to track service and quantity
class CartItem {
  Service service;
  int quantity;

  CartItem({required this.service, this.quantity = 1});
}