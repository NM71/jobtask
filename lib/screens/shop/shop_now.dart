import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/shop/reviews_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'shop_screen.dart';

class ShopNow extends StatefulWidget {
  final double? shoeSize;
  final Service service;
  final List<Service> allServices;

  const ShopNow({
    super.key,
    required this.shoeSize,
    required this.service,
    required this.allServices,
  });

  @override
  State<ShopNow> createState() => _ShopNowState();
}

class _ShopNowState extends State<ShopNow> {
  double? _selectedSize;

  // Shoe Size Selector
  void _showSizeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Select Size',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _shoeSizes.length,
                  itemBuilder: (context, index) {
                    final size = _shoeSizes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedSize = size);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: _selectedSize == size
                              ? Color(0xff3c76ad)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            size.toString(),
                            style: TextStyle(
                              color: _selectedSize == size
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                              fontWeight: _selectedSize == size
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Add the shoe sizes list
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final similarServices = widget.allServices
        .where((s) =>
            s.id != widget.service.id &&
            s.serviceType == widget.service.serviceType)
        .take(4)
        .toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '${widget.service.name} Shoes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.network(
                    widget.service.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.service.name,
                        style: TextStyle(
                          fontFamily: 'Outfit-Bold',
                          fontSize: screenWidth * 0.085,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.service.price.toStringAsFixed(0)}\$',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontFamily: 'Outfit-Bold',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3c76ad),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.service.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xff3c76ad),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => _showSizeSelector(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedSize != null
                              ? 'Size: ${_selectedSize!}'
                              : 'Select Size',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () => _showSizeSelector(context),
                          icon: Image.asset(
                            'assets/icons/dropdown_icon.png',
                            height: 25,
                            width: 25,
                            color: Color(0xff3c76ad),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: MyButton(
                    height: 51,
                    text: "Add to Cart",
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(widget.service);

                      final count = Provider.of<CartProvider>(context,
                              listen: false)
                          .cartItems
                          .firstWhere(
                              (item) => item.service.id == widget.service.id,
                              orElse: () => CartItem(
                                  service: widget.service, quantity: 0))
                          .quantity;
                      CustomSnackbar.show(
                        context: context,
                        message:
                            '($count)  ${widget.service.name} added to cart',
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Color(0xffe4e4e4),
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: ApiService.getServiceReviews(widget.service.id),
                    builder: (context, snapshot) {
                      int reviewCount = 0;
                      double averageRating = 0;

                      if (snapshot.hasData) {
                        reviewCount = snapshot.data!.length;
                        if (reviewCount > 0) {
                          averageRating = snapshot.data!.fold(0.0,
                                  (sum, review) => sum + review['rating']) /
                              reviewCount;
                        }
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews ($reviewCount) ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                "★  " * averageRating.round(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: ReviewsScreen(
                                          serviceId: widget.service.id),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                },
                                icon: Image.asset(
                                  'assets/icons/dropdown_icon.png',
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3c76ad),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _showReviewDialog,
                  child: Text(
                    'Add Your Review',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "You Might Also Like",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: similarServices.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(service: similarServices[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewDialog() {
    int selectedRating = 5;
    final reviewController = TextEditingController();
    bool isSubmittingReview = false;
    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          title: Text('Rate & Review Service'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tap to rate:',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      icon: Icon(
                        index < selectedRating ? Icons.star : Icons.star_border,
                        color: Color(0xff3c76ad),
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() => selectedRating = index + 1);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'Share your experience for this service...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Color(0xff3c76ad)),
                    ),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3c76ad),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: isSubmittingReview
                  ? null
                  : () async {
                      setState(() => isSubmittingReview = true);
                      try {
                        final storage = FlutterSecureStorage();
                        final token = await storage.read(key: 'auth_token');

                        print('Token: $token'); // Debug token

                        if (token == null) {
                          throw Exception('Please login to rate and review');
                        }

                        final reviewData = {
                          'service_id': widget.service.id,
                          'rating': selectedRating,
                          'review_text': reviewController.text.trim(),
                        };

                        print(
                            'Sending review data: $reviewData'); // Debug request data

                        final response = await ApiService.addServiceReview(
                            token, reviewData);
                        print('API Response: $response'); // Debug response

                        Navigator.pop(context);
                        CustomSnackbar.show(
                          context: context,
                          message: 'Rating and review added successfully!',
                        );
                      } catch (e) {
                        print('Error adding review: $e'); // Debug errors
                        CustomSnackbar.show(
                          context: context,
                          message: e.toString(),
                        );
                      } finally {
                        setState(() => isSubmittingReview = false);
                      }
                    },
              child: isSubmittingReview
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
