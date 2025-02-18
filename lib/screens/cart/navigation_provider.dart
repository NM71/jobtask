import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  final PageController pageController = PageController();

  void jumpToPage(int page) {
    pageController.jumpToPage(page);
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
