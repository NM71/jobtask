import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/animations/rfkicks_animation.dart';
import 'package:jobtask/screens/dashboard_screen.dart';
import 'package:jobtask/screens/profile/country_provider.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/services/currency_service.dart';
import 'package:jobtask/utils/currency_mapping.dart';
import 'package:provider/provider.dart';

class OnboardingFlow extends StatefulWidget {
  final String userName;
  const OnboardingFlow({required this.userName, super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final storage = const FlutterSecureStorage();
  int _currentPage = 0;
  String? _selectedCategory;
  double? _selectedShoeSize;
  bool _isLoading = false;

  Future<bool> _onWillPop() async {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false;
    }
    return true;
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);
    try {
      final token = await storage.read(key: 'auth_token');
      if (token != null && _selectedShoeSize != null) {
        final countryProvider =
            Provider.of<CountryProvider>(context, listen: false);
        final success = await ApiService.completeOnboarding(token, {
          'shoe_size': _selectedShoeSize.toString(),
          'category': _selectedCategory,
          'country_code': countryProvider.countryCode,
          'currency_code': countryProvider.currencyCode,
        });

        if (success) {
          await storage.write(key: 'onboarding_completed', value: 'true');
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RfkicksAnimation(
                  targetScreen: DashboardScreen(token: token),
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving preferences: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  // Future<void> _completeOnboarding() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     final token = await storage.read(key: 'auth_token');
  //     if (token != null && _selectedShoeSize != null) {
  //       final success = await ApiService.completeOnboarding(token, {
  //         'shoe_size': _selectedShoeSize.toString(),
  //         'category': _selectedCategory,
  //       });

  //       if (success) {
  //         await storage.write(key: 'onboarding_completed', value: 'true');

  //         if (mounted) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => RfkicksAnimation(
  //                 targetScreen: DashboardScreen(token: token),
  //               ),
  //             ),
  //           );
  //         }
  //       } else {
  //         throw Exception('Failed to save onboarding data');
  //       }
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error saving preferences: $e')),
  //       );
  //     }
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildWelcomeScreen(),
                _buildIntroScreen(),
                _buildCategoryScreen(),
                _buildShoeSizeScreen(),
                _buildCountryScreen(),
              ],
            ),
            if (_currentPage > 0)
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  child: LinearProgressIndicator(
                    value: (_currentPage + 1) / 5,
                    backgroundColor: const Color(0xff5c5c5c),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    minHeight: 4,
                  ),
                ),
              ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/header2-2-1.png",
              height: 36,
              width: 52,
            ),
            const SizedBox(height: 10),
            Text(
              'Hi ${widget.userName},',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            // const SizedBox(height: 1),
            const Text(
              'Welcome to RFK.\nThanks for becoming\na Member!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            // const Spacer(),
            SizedBox(height: 40),
            Center(
              child: _buildActionButton(
                'Continue',
                () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            // Center(child: _buildNextButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroScreen() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/onboarding_img.png'),
          opacity: 0.75,
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Spacer(),
              SizedBox(
                height: 40,
              ),
              const Text(
                'To personalize your experience and\nconnect you to sport, we\'ve got a few questions for you.',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // const SizedBox(height: 40),
              Spacer(),
              Center(child: _buildNextButton()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'First up, which product do you use the most?',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            _buildCategoryOption('Men'),
            _buildCategoryOption('Women'),
            const SizedBox(height: 20),
            const Text(
              'Any others?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            _buildCategoryOption('Boys'),
            _buildCategoryOption('Girls'),
            const Spacer(),
            if (_selectedCategory != null)
              Center(
                child: _buildActionButton('Continue', () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildShoeSizeScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'What\'s your shoe size?',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  height: 1.2,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _shoeSizes.length,
                itemBuilder: (context, index) {
                  final size = _shoeSizes[index];
                  return _buildSizeButton(size);
                },
              ),
            ),
            const SizedBox(height: 20),
            // Center(
            //   child: _buildActionButton(
            //     _selectedShoeSize == null ? 'Skip' : 'Next',
            //     _completeOnboarding,
            //     color: _selectedShoeSize == null
            //         ? const Color(0xFF1F1F1F)
            //         : const Color(0xff3c76ad),
            //   ),
            // ),
            Center(
              child: _buildActionButton(
                _selectedShoeSize == null ? 'Skip' : 'Next',
                () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                color: _selectedShoeSize == null
                    ? const Color(0xFF1F1F1F)
                    : const Color(0xff3c76ad),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOption(String category) {
    final isSelected = _selectedCategory == category;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Circle Image
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/categories/$category.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Category Name
          Expanded(
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Circular Checkbox
          GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.white24,
                  width: 1,
                ),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Color(0xff3c76ad),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Choose your region',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Consumer<CountryProvider>(
              builder: (context, countryProvider, child) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    title: Text(
                      countryProvider.countryName ?? 'Select Country',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: countryProvider.currencyCode != null
                        ? Text(
                            'Currency: ${countryProvider.currencyCode}',
                            style: TextStyle(color: Colors.white70),
                          )
                        : null,
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        countryListTheme: CountryListThemeData(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(color: Colors.white),
                          searchTextStyle: TextStyle(color: Colors.white),
                          bottomSheetHeight: 500,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        onSelect: (Country country) async {
                          String currencyCode = CurrencyMapping.getCurrencyCode(
                              country.countryCode);
                          double rate = await CurrencyService.getExchangeRate(
                              currencyCode);
                          countryProvider.setCountry(
                            country.countryCode,
                            country.name,
                            currencyCode,
                            rate,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
            Spacer(),
            Center(
              child: _buildActionButton(
                'Complete Setup',
                _completeOnboarding,
                color: Color(0xff3c76ad),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeButton(double size) {
    final isSelected = _selectedShoeSize == size;
    return GestureDetector(
      onTap: () => setState(() => _selectedShoeSize = size),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff3c76ad)
              : Color(
                  0xff1F1F1F,
                ),
          borderRadius: BorderRadius.circular(6),
          // border: Border.all(
          //   color: isSelected ? Colors.white : Colors.white24,
          // ),
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

  Widget _buildActionButton(String text, VoidCallback onPressed,
      {Color? color}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xff3c76ad),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      // width: double.infinity,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () => _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff3c76ad),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )),
        child: const Text(
          'Continue',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static const _shoeSizes = [
    4.0,
    4.5,
    5.0,
    5.5,
    6.0,
    6.5,
    7.0,
    7.5,
    8.0,
    8.5,
    9.0,
    9.5,
    10.0,
    10.5,
    11.0,
    11.5,
    12.0,
    12.5,
    13.0,
    13.5,
    14.0,
    14.5,
    15.0,
    16.0,
  ];
}
