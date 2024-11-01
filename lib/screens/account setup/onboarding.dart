// // import 'package:flutter/material.dart';
// //
// // class OnboardingSetup extends StatefulWidget {
// //   const OnboardingSetup({super.key});
// //
// //   @override
// //   State<OnboardingSetup> createState() => _OnboardingSetupState();
// // }
// //
// // class _OnboardingSetupState extends State<OnboardingSetup> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Image.asset(
// //               'assets/images/header2-2-1.png',
// //               height: 50,
// //               width: 50,
// //             ),
// //             Text(
// //               'Hi Nousher,\nWelcome to RFK,\nThanks for becoming\na Member!',
// //               style: TextStyle(fontSize: 40, color: Colors.white),
// //             )
// //           ],
// //         ),
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
// // -------------------------------
//
// // import 'package:flutter/material.dart';
// //
// // class OnboardingScreen extends StatefulWidget {
// //   const OnboardingScreen({super.key});
// //
// //   @override
// //   State<OnboardingScreen> createState() => _OnboardingScreenState();
// // }
// //
// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   // Current page index
// //   int _currentPage = 0;
// //
// //   // Total number of pages
// //   final int _totalPages = 5;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Background Image
// //           Container(
// //             decoration: const BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage(
// //                     'assets/images/onboarding_img.png'),
// //                 fit: BoxFit.cover,
// //                 colorFilter: ColorFilter.mode(
// //                   Colors.black26,
// //                   BlendMode.darken,
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           // Content
// //           SafeArea(
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   // Progress Bar
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
// //                     child: LinearProgressIndicator(
// //                       value: (_currentPage + 1) / _totalPages,
// //                       backgroundColor: Color(0xff5c5c5c),
// //                       valueColor:
// //                           const AlwaysStoppedAnimation<Color>(Colors.white),
// //                       borderRadius: BorderRadius.circular(15),
// //                       minHeight: 4,
// //                     ),
// //                   ),
// //
// //                   // Main Content
// //                   Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         'To personalize your\nexperience and\nconnect you to sport,\nwe\'ve got a few\nquestions for you.',
// //                         style: TextStyle(
// //                           fontSize: 32,
// //                           color: Colors.white,
// //                           height: 1.2,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 40),
// //                     ],
// //                   ),
// //                   Column(
// //                     children: [
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           setState(() {
// //                             if (_currentPage < _totalPages - 1) {
// //                               _currentPage++;
// //                             }
// //                           });
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Color(0xff3c76ad),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                         ),
// //                         child: const Text(
// //                           'Get Started',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
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
//
// // Model class for onboarding pages
// class OnboardingPage {
//   final String title;
//   final String? description;
//   final String? buttonText;
//
//   OnboardingPage({
//     required this.title,
//     this.description,
//     this.buttonText,
//   });
// }
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   // List of onboarding pages
//   final List<OnboardingPage> _pages = [
//     OnboardingPage(
//       title: 'To personalize your\nexperience and\nconnect you to sport,\nwe\'ve got a few\nquestions for you.',
//       buttonText: 'Get Started',
//     ),
//     OnboardingPage(
//       title: 'What sports do\nyou play?',
//       description: 'Select all that apply',
//       buttonText: 'Continue',
//     ),
//     OnboardingPage(
//       title: 'What\'s your skill\nlevel?',
//       buttonText: 'Next',
//     ),
//     OnboardingPage(
//       title: 'What are your\nfitness goals?',
//       description: 'Choose your primary focus',
//       buttonText: 'Continue',
//     ),
//     OnboardingPage(
//       title: 'Almost done!\nLet\'s set up your\nprofile.',
//       buttonText: 'Finish',
//     ),
//   ];
//
//   void _nextPage() {
//     if (_currentPage < _pages.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       // Handle completion - navigate to home screen or next flow
//       debugPrint('Onboarding Complete');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/onboarding_img.png'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black26,
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//           ),
//
//           // Content
//           SafeArea(
//             child: Column(
//               children: [
//                 // Progress Bar
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 60,
//                     vertical: 20,
//                   ),
//                   child: LinearProgressIndicator(
//                     value: (_currentPage + 1) / _pages.length,
//                     backgroundColor: const Color(0xff5c5c5c),
//                     valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                     borderRadius: BorderRadius.circular(15),
//                     minHeight: 4,
//                   ),
//                 ),
//
//                 // PageView for screens
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     physics: const NeverScrollableScrollPhysics(), // Disable swipe
//                     itemCount: _pages.length,
//                     itemBuilder: (context, index) {
//                       return _buildPage(_pages[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPage(OnboardingPage page) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Main Content
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 page.title,
//                 style: const TextStyle(
//                   fontSize: 32,
//                   color: Colors.white,
//                   height: 1.2,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               if (page.description != null) ...[
//                 const SizedBox(height: 16),
//                 Text(
//                   page.description!,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//
//           // Button
//           ElevatedButton(
//             onPressed: _nextPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xff3c76ad),
//               minimumSize: const Size(120, 48),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             child: Text(
//               page.buttonText ?? 'Continue',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }











// services/onboarding_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const String _dataKey = 'onboarding_data';
  static const String _completionKey = 'onboarding_complete';

  Future<void> saveOnboardingData(OnboardingData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_dataKey, jsonEncode(data.toJson()));
      await prefs.setBool(_completionKey, true);
    } catch (e) {
      throw OnboardingException('Failed to save onboarding data: $e');
    }
  }

  Future<OnboardingData?> getOnboardingData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dataString = prefs.getString(_dataKey);
      if (dataString != null) {
        return OnboardingData.fromJson(jsonDecode(dataString));
      }
      return null;
    } catch (e) {
      throw OnboardingException('Failed to retrieve onboarding data: $e');
    }
  }

  Future<bool> isOnboardingComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_completionKey) ?? false;
    } catch (e) {
      return false;
    }
  }
}

class OnboardingException implements Exception {
  final String message;
  OnboardingException(this.message);
}

// models/onboarding_data.dart
class OnboardingData {
  final String? name;
  final String? selectedProduct;
  final double? shoeSize;
  final bool notificationsEnabled;
  final List<String>? selectedCategories;

  OnboardingData({
    this.name,
    this.selectedProduct,
    this.shoeSize,
    this.notificationsEnabled = false,
    this.selectedCategories,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'selectedProduct': selectedProduct,
    'shoeSize': shoeSize,
    'notificationsEnabled': notificationsEnabled,
    'selectedCategories': selectedCategories,
  };

  factory OnboardingData.fromJson(Map<String, dynamic> json) => OnboardingData(
    name: json['name'],
    selectedProduct: json['selectedProduct'],
    shoeSize: json['shoeSize']?.toDouble(),
    notificationsEnabled: json['notificationsEnabled'] ?? false,
    selectedCategories: List<String>.from(json['selectedCategories'] ?? []),
  );

  OnboardingData copyWith({
    String? name,
    String? selectedProduct,
    double? shoeSize,
    bool? notificationsEnabled,
    List<String>? selectedCategories,
  }) =>
      OnboardingData(
        name: name ?? this.name,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        shoeSize: shoeSize ?? this.shoeSize,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        selectedCategories: selectedCategories ?? this.selectedCategories,
      );
}

// screens/onboarding_screen.dart

class OnboardingScreen extends StatefulWidget {
  final String userName;
  const OnboardingScreen({required this.userName, super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnboardingService _onboardingService = OnboardingService();
  late OnboardingData _onboardingData;
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _onboardingData = OnboardingData(
      name: widget.userName,
      selectedCategories: [],
    );
  }

  Future<void> _handleCompletion() async {
    setState(() => _isLoading = true);
    try {
      await _onboardingService.saveOnboardingData(_onboardingData);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save preferences: $e'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _handleCompletion,
            ),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<Widget> get _pages => [
    WelcomePage(name: widget.userName, onNext: _nextPage,),
    IntroPage(onNext: _nextPage,),
    ProductSelectionPage(
      selectedProduct: _onboardingData.selectedProduct,
      onSelect: (product) {
        setState(() {
          _onboardingData = _onboardingData.copyWith(
            selectedProduct: product,
          );
        });
        _nextPage();
      },
    ),
    ShoeSizePage(
      selectedSize: _onboardingData.shoeSize,
      onSelect: (size) {
        setState(() {
          _onboardingData = _onboardingData.copyWith(shoeSize: size);
        });
        _nextPage();
      },
    ),
    NotificationPage(
      onSelect: (enabled) async {
        if (enabled) {
          final status = await Permission.notification.request();
          enabled = status.isGranted;
        }
        setState(() {
          _onboardingData = _onboardingData.copyWith(
            notificationsEnabled: enabled,
          );
        });
        await _handleCompletion();
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / _pages.length,
                backgroundColor: const Color(0xff5c5c5c),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                borderRadius: BorderRadius.circular(15),
                minHeight: 4,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

// screens/shoe_size_page.dart
class ShoeSizePage extends StatelessWidget {
  final double? selectedSize;
  final ValueChanged<double> onSelect;

  const ShoeSizePage({
    this.selectedSize,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            const Text(
              'What\'s your shoe size?',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _shoeSizes.length,
                itemBuilder: (context, index) {
                  final size = _shoeSizes[index];
                  final isSelected = size == selectedSize;
                  return _SizeButton(
                    size: size,
                    isSelected: isSelected,
                    onTap: () => onSelect(size),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _shoeSizes = [
    4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5,
    8.0, 8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5,
    12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0, 16.0,
  ];
}

class _SizeButton extends StatelessWidget {
  final double size;
  final bool isSelected;
  final VoidCallback onTap;

  const _SizeButton({
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff3c76ad) : Colors.black54,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            size.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// screens/notification_page.dart
class NotificationPage extends StatelessWidget {
  final ValueChanged<bool> onSelect;

  const NotificationPage({required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            const Text(
              'Stay in the know with\nnotifications',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Get updates about:\nFirst Access to products\nInvites to experiences\nPersonalized offers\nOrder updates',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSelect(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                    ),
                    child: const Text('Don\'t Allow'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSelect(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3c76ad),
                    ),
                    child: const Text('Allow',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// screens/welcome_page.dart
class WelcomePage extends StatelessWidget {
  final String name;
  final VoidCallback onNext;

  const WelcomePage({
    required this.name,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text(
              'Welcome,\n$name',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Get ready to personalize your experience with us. We\'ll help you set up your preferences in just a few steps.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3c76ad),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Get Started',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// screens/intro_page.dart
class IntroPage extends StatelessWidget {
  final VoidCallback onNext;

  const IntroPage({required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            const Text(
              'Let\'s get started',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We\'ll ask you a few questions to help personalize your experience:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            _IntroItem(
              icon: Icons.shopping_bag_outlined,
              title: 'Product Preferences',
              description: 'Select your preferred product type',
            ),
            _IntroItem(
              icon: Icons.straighten,
              title: 'Size Information',
              description: 'Tell us your shoe size for better recommendations',
            ),
            _IntroItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              description: 'Choose how you want to stay updated',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3c76ad),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Continue', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _IntroItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// screens/product_selection_page.dart
class ProductSelectionPage extends StatelessWidget {
  final String? selectedProduct;
  final ValueChanged<String> onSelect;

  const ProductSelectionPage({
    this.selectedProduct,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            const Text(
              'What brings you here?',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select the product category you\'re most interested in',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _products.map((product) {
                  final isSelected = product == selectedProduct;
                  return _ProductCard(
                    product: product,
                    isSelected: isSelected,
                    onTap: () => onSelect(product),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _products = [
    'Running',
    'Training',
    'Basketball',
    'Lifestyle',
    'Soccer',
    'Tennis',
  ];
}

class _ProductCard extends StatelessWidget {
  final String product;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff3c76ad) : Colors.black54,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            product,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}