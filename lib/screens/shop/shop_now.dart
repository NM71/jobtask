// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/shop/reviews_screen.dart';
// import 'package:jobtask/utils/custom_buttons/my_button.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'shop_screen.dart';

// class ShopNow extends StatelessWidget {
//   final double? shoeSize;
//   final Service service;
//   final List<Service> allServices;

//   const ShopNow(
//       {super.key,
//       required this.shoeSize,
//       required this.service,
//       required this.allServices});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Filter similar services (excluding current service)
//     final similarServices = allServices
//         .where(
//             (s) => s.id != service.id && s.serviceType == service.serviceType)
//         .take(4)
//         .toList();

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           scrolledUnderElevation: 0,
//           backgroundColor: Colors.white,
//           title: Text(
//             '${service.name} Shoes',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Responsive image
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Image.network(
//                     service.imagePath,
//                     // height: screenHeight * 0.4,
//                     // width: screenWidth * 0.9,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Responsive text size
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         service.name,
//                         style: TextStyle(
//                             fontSize: screenWidth * 0.085,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         '${service.price.toStringAsFixed(0)}\$',
//                         style: TextStyle(
//                             fontSize: screenWidth * 0.07,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff3c76ad)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Responsive description text
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Text(
//                     service.description,
//                     style: TextStyle(fontSize: 16),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Select size button with dropdown icon
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 19.0),
//                   child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                           foregroundColor: Color(0xff3c76ad),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6))),
//                       onPressed: () {},
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Select Size',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       color: Colors.white,
//                                       height: 24,
//                                       width: 24,
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Select your Shoe Size: \n\n",
//                                             style: TextStyle(
//                                                 fontSize: screenWidth * 0.08,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           SizedBox(height: 20),
//                                         ],
//                                       ),
//                                     );
//                                   });
//                             },
//                             icon: Image.asset(
//                               'assets/icons/dropdown_icon.png',
//                               height: 25,
//                               width: 25,
//                               color: Color(0xff3c76ad),
//                             ),
//                           ),
//                         ],
//                       )),
//                 ),

//                 SizedBox(height: 20),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 19.0),
//                   child: MyButton(
//                       text: "Add to Cart",
//                       onTap: () {
//                         Provider.of<CartProvider>(context, listen: false)
//                             .addToCart(service);
//                         CustomSnackbar.show(
//                           context: context,
//                           message: '${service.name} added to cart',
//                         );
//                       }),
//                 ),

//                 SizedBox(height: 20),
//                 // Divider

//                 Divider(
//                   color: Color(0xffe4e4e4),
//                   thickness: 1,
//                   indent: 24,
//                   endIndent: 24,
//                 ),
//                 SizedBox(height: 10),
//                 // Reviews section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "Reviews (20)",
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "★ ★ ★ ★ ★",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 PageTransition(
//                                     child: ReviewsScreen(),
//                                     type: PageTransitionType.rightToLeft));
//                           },
//                           icon: Image.asset(
//                             'assets/icons/dropdown_icon.png',
//                             height: 24,
//                             width: 24,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40),
//                 // You Might Also Like section title
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "You Might Also Like",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 20),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.8,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                     ),
//                     itemCount: similarServices.length,
//                     itemBuilder: (context, index) {
//                       return ServiceCard(service: similarServices[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Size',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: Colors.white,
                                  height: 24,
                                  width: 24,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select your Shoe Size: \n\n",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.08,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
                    text: "Add to Cart",
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(widget.service);
                      CustomSnackbar.show(
                        context: context,
                        message: '${widget.service.name} added to cart',
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
              // onPressed: () async {
              //   try {
              //     final storage = FlutterSecureStorage();
              //     final token = await storage.read(key: 'auth_token');

              //     if (token == null) {
              //       throw Exception('Please login to rate and review');
              //     }

              //     await ApiService.addServiceReview(token, {
              //       'service_id': widget.service.id,
              //       'rating': selectedRating,
              //       'review_text': reviewController.text.trim(),
              //     });

              //     Navigator.pop(context);
              //     CustomSnackbar.show(
              //       context: context,
              //       message: 'Rating and review added successfully!',
              //     );
              //   } catch (e) {
              //     CustomSnackbar.show(
              //       context: context,
              //       message: e.toString(),
              //     );
              //   }
              // },
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

  // void _showReviewDialog() {
  //   int rating = 5;
  //   final reviewController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Rate this service'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: List.generate(
  //               5,
  //               (index) => IconButton(
  //                 icon: Icon(
  //                   index < rating ? Icons.star : Icons.star_border,
  //                   color: Color(0xff3c76ad),
  //                 ),
  //                 onPressed: () {
  //                   setState(() => rating = index + 1);
  //                 },
  //               ),
  //             ),
  //           ),
  //           TextField(
  //             controller: reviewController,
  //             decoration: InputDecoration(
  //               hintText: 'Write your review...',
  //               border: OutlineInputBorder(),
  //             ),
  //             maxLines: 3,
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Color(0xff3c76ad),
  //           ),
  //           onPressed: () async {
  //             try {
  //               final storage = FlutterSecureStorage();
  //               final token = await storage.read(key: 'auth_token');

  //               if (token == null) {
  //                 throw Exception('Please login to add a review');
  //               }

  //               await ApiService.addServiceReview(token, {
  //                 'service_id': widget.service.id,
  //                 'rating': rating,
  //                 'review_text': reviewController.text.trim(),
  //               });

  //               Navigator.pop(context);
  //               CustomSnackbar.show(
  //                 context: context,
  //                 message: 'Review added successfully!',
  //               );
  //             } catch (e) {
  //               CustomSnackbar.show(
  //                 context: context,
  //                 message: e.toString(),
  //               );
  //             }
  //           },
  //           child: Text('Submit'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
