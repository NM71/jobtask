// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/cart/cart_screen.dart';
// import 'package:jobtask/screens/cart/product_description.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
//
// class ServicePage extends StatelessWidget {
//   final List<Service> services = [
//     Service(
//       'ReFresh',
//       30,
//       'assets/images/services_images/refresh_service.jpg',
//       '● Basic cleaning of shoe exterior-removes scuffs\n● Minor scratches\n● Stone and most stains\n\n 2-3 business days',
//     ),
//     Service(
//       'ReVive',
//       50,
//       'assets/images/services_images/revive_service.jpg',
//       '● Interior and Exterior Cleaning\n● Deodorizing\n● Minor Paint touch-ups (If needed)\n● Removes Gum\n● Removes Grass and Mud Stones\n● Removes Deep Scuffs\n● Cleans Suede\n● Lace Cleaning',
//     ),
//     Service(
//       'ReStore',
//       150,
//       'assets/images/services_images/restore_service.jpg',
//       '● Lace Swap (if needed)\n● Sole Swap (If needed & sole must be provided)\n● Full Repaint (if needed)\n● Replacement Parts (If needed)',
//     ),
//     Service(
//       'Kids Shoe',
//       150,
//       'assets/images/services_images/kids_service.jpg',
//       '● A specialized cleaning service for kids shoes, ensuring they look brand new.',
//     ),
//   ];
//
//   final List<Service> individualServices = [
//     Service(
//       'Lace Cleaning',
//       20,
//       'assets/images/services_images/laceCleaning_service.jpg',
//       '● Lace Cleaning\n● Lace Swap (if needed)',
//     ),
//     Service(
//       'Lint Removal',
//       20,
//       'assets/images/services_images/lintRemove_service.jpg',
//       '',
//     ),
//     Service(
//       'Reglue',
//       40,
//       'assets/images/services_images/reglue_service.jpg',
//       '',
//     ),
//     Service(
//       'RePaint',
//       70,
//       'assets/images/services_images/repaint_service.jpg',
//       '',
//     ),
//     Service(
//       'Un-Yellowing',
//       70,
//       'assets/images/services_images/unYellowing_service.jpg',
//       '',
//     ),
//     Service(
//       'Sole-Swaps',
//       80,
//       'assets/images/services_images/soleSwaps_service.jpg',
//       '',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SectionTitle(title: 'Services'),
//               ServiceGrid(services: services),
//               SectionTitle(title: 'Individual Services'),
//               ServiceGrid(services: individualServices),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Navigator.push(
//       //         context,
//       //         PageTransition(
//       //           child: CartScreen(),
//       //           type: PageTransitionType.bottomToTop,
//       //         ));
//       //   },
//       //   backgroundColor: Color(0xff3c76ad),
//       //   child: Icon(
//       //     Icons.shopping_cart_checkout_outlined,
//       //     color: Colors.white,
//       //   ),
//       // ),
//     );
//   }
// }
//
// class Service {
//   final String name;
//   final double price;
//   final String imagePath;
//   final String description;
//
//   Service(this.name, this.price, this.imagePath, this.description);
// }
//
// class ServiceGrid extends StatelessWidget {
//   final List<Service> services;
//
//   const ServiceGrid({Key? key, required this.services}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: services.length,
//       itemBuilder: (context, index) {
//         return ServiceCard(service: services[index]);
//       },
//     );
//   }
// }
//
// class ServiceCard extends StatelessWidget {
//   final Service service;
//
//   const ServiceCard({Key? key, required this.service}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: ProductDescription(service: service),
//           ),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(2),
//             side: BorderSide(
//               color: Color(0xff3c76ad),
//               width: 1,
//             )),
//         elevation: 0,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: Image.asset(
//                     service.imagePath,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         service.name,
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     Text(
//                       '\$${service.price}',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xff3c76ad),
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 8,
//               right: 6,
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration:
//                     BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                 child: IconButton(
//                   icon: Icon(Icons.shopping_cart_outlined,
//                       size: 24, color: Color(0xff3c76ad)),
//                   onPressed: () {
//                     // Here Implement the add to cart functionality here
//                     Provider.of<CartProvider>(context, listen: false).addToCart(service);
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //     SnackBar(content: Text('${service.name} added to cart')),);
//                     CustomSnackbar.show(
//                       context: context,
//                       message: '${service.name} added to cart',
//                     );
//
//                     // Navigator.push(
//                     //   context,
//                     //   PageTransition(
//                     //     type: PageTransitionType.rightToLeft,
//                     //     child: ShopNow(
//                     //       service: service,
//                     //       shoeSize: null,
//                     //     ),
//                     //   ),
//                     // );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//   final String title;
//
//   const SectionTitle({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//       child: Text(
//         title,
//         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
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

//---------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:jobtask/screens/cart/cart_provider.dart';
// import 'package:jobtask/screens/cart/product_description.dart';
// import 'package:jobtask/services/api_service.dart';
// import 'package:jobtask/utils/custom_buttons/my_button.dart';
// import 'package:jobtask/utils/custom_snackbar.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Static Service Page
// // class ServicePage extends StatelessWidget {
// //   final List<Service> services = [
// //     Service(
// //       'ReFresh',
// //       30,
// //       'assets/images/services_images/refresh_service.jpg',
// //       '● Basic cleaning of shoe exterior-removes scuffs\n● Minor scratches\n● Stone and most stains\n\n 2-3 business days',
// //     ),
// //     Service(
// //       'ReVive',
// //       50,
// //       'assets/images/services_images/revive_service.jpg',
// //       '● Interior and Exterior Cleaning\n● Deodorizing\n● Minor Paint touch-ups (If needed)\n● Removes Gum\n● Removes Grass and Mud Stones\n● Removes Deep Scuffs\n● Cleans Suede\n● Lace Cleaning',
// //     ),
// //     Service(
// //       'ReStore',
// //       150,
// //       'assets/images/services_images/restore_service.jpg',
// //       '● Lace Swap (if needed)\n● Sole Swap (If needed & sole must be provided)\n● Full Repaint (if needed)\n● Replacement Parts (If needed)',
// //     ),
// //     Service(
// //       'Kids Special',
// //       150,
// //       'assets/images/services_images/kids_service.jpg',
// //       '● A specialized cleaning service for kids shoes, ensuring they look brand new.',
// //     ),
// //   ];
// //
// //   final List<Service> individualServices = [
// //     Service(
// //       'Lace Cleaning',
// //       20,
// //       'assets/images/services_images/laceCleaning_service.jpg',
// //       '● Lace Cleaning\n● Lace Swap (if needed)',
// //     ),
// //     Service(
// //       'Lint Removal',
// //       20,
// //       'assets/images/services_images/lintRemove_service.jpg',
// //       '',
// //     ),
// //     Service(
// //       'Reglue',
// //       40,
// //       'assets/images/services_images/reglue_service.jpg',
// //       '',
// //     ),
// //     Service(
// //       'RePaint',
// //       70,
// //       'assets/images/services_images/repaint_service.jpg',
// //       '',
// //     ),
// //     Service(
// //       'Un-Yellowing',
// //       70,
// //       'assets/images/services_images/unYellowing_service.jpg',
// //       '',
// //     ),
// //     Service(
// //       'Sole-Swaps',
// //       80,
// //       'assets/images/services_images/soleSwaps_service.jpg',
// //       '',
// //     ),
// //   ];
// //
// //   ServicePage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Get screen width
// //     final screenWidth = MediaQuery.of(context).size.width;
// //
// //     // Determine crossAxisCount based on screen width
// //     int crossAxisCount =
// //         (screenWidth < 600) ? 2 : 3; // Adjusts number of columns
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SectionTitle(title: 'Services'),
// //
// //               // Auth Button
// //               Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text("Authentication Service", style: TextStyle(fontSize: 14),),
// //                           Text("! You need to login on rfkicks.com also to make some features work", style: TextStyle(fontSize: 8, color: Color(0xff3c76ad)),),
// //                         ],
// //                       ),
// //                     ),
// //                     MyButton(
// //                         text: "Check",
// //                         onTap: () async {
// //                           Uri url = Uri.parse('https://rfkicks.com/authentication/');
// //                           if (await canLaunchUrl(url)) {
// //                             await launchUrl(url);
// //                           } else {
// //                             throw 'Could not launch $url';
// //                           }
// //                         }),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: 20,),
// //
// //
// //               ServiceGrid(services: services, crossAxisCount: crossAxisCount),
// //               SectionTitle(title: 'Individual Services'),
// //               ServiceGrid(
// //                   services: individualServices, crossAxisCount: crossAxisCount),
// //             ],
// //           ),
// //         ),
// //       ),
// //       // floatingActionButton: FloatingActionButton(
// //       //   onPressed: () {
// //       //     Navigator.push(
// //       //         context,
// //       //         PageTransition(
// //       //           child: CartScreen(),
// //       //           type: PageTransitionType.bottomToTop,
// //       //         ));
// //       //   },
// //       //   backgroundColor: Color(0xff3c76ad),
// //       //   child: Icon(
// //       //     Icons.shopping_cart_checkout_outlined,
// //       //     color: Colors.white,
// //       //   ),
// //       // ),
// //     );
// //   }
// // }
//
//
// // Dynamic Service Page:
//
// class ServicePage extends StatefulWidget {
//   ServicePage({super.key});
//
//   @override
//   State<ServicePage> createState() => _ServicePageState();
// }
//
// class _ServicePageState extends State<ServicePage> {
//   List<Service> mainServices = [];
//   List<Service> individualServices = [];
//   bool isLoading = true;
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadServices();
//   }
//
//   Future<void> _loadServices() async {
//     try {
//       final services = await ApiService.getServices();
//       setState(() {
//         mainServices = services['main'] ?? [];
//         individualServices = services['individual'] ?? [];
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     int crossAxisCount = (screenWidth < 600) ? 2 : 3;
//
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     if (error != null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(error!),
//               ElevatedButton(
//                 onPressed: _loadServices,
//                 child: Text('Retry'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SectionTitle(title: 'Services'),
//
//               // Auth Button
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Authentication Service", style: TextStyle(fontSize: 12),),
//                           Text("! You need to login on rfkicks.com also to make some features work", style: TextStyle(fontSize: 7, color: Color(0xff3c76ad)),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 10,),
//                     MyButton(
//                         text: "Check",
//                         onTap: () async {
//                           Uri url = Uri.parse('https://rfkicks.com/authentication/');
//                           if (await canLaunchUrl(url)) {
//                             await launchUrl(url);
//                           } else {
//                             throw 'Could not launch $url';
//                           }
//                         }),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//               ServiceGrid(services: mainServices, crossAxisCount: crossAxisCount),
//               SectionTitle(title: 'Individual Services'),
//               ServiceGrid(
//                   services: individualServices, crossAxisCount: crossAxisCount),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/cart/product_description.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<Service> mainServices = [];
  List<Service> individualServices = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final services = await ApiService.getServices();
      if (mounted) {
        // Add this check
        Provider.of<ServiceProvider>(context, listen: false)
            .setServices(services);
        setState(() {
          mainServices = services['main'] ?? [];
          individualServices = services['individual'] ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // Add this check
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
    }
  }

  // Future<void> _loadServices() async {
  //   try {
  //     final services = await ApiService.getServices();
  //     setState(() {
  //       mainServices = services['main'] ?? [];
  //       individualServices = services['individual'] ?? [];
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       error = e.toString();
  //       isLoading = false;
  //     });
  //   }
  // }
  // load services from backend
  // Future<void> _loadServices() async {
  //   try {
  //     final services = await ApiService.getServices();
  //     Provider.of<ServiceProvider>(context, listen: false)
  //         .setServices(services);
  //     setState(() {
  //       mainServices = services['main'] ?? [];
  //       individualServices = services['individual'] ?? [];
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       error = e.toString();
  //       isLoading = false;
  //     });
  //   }
  // }

  Widget _buildShimmerEffect() {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth < 600) ? 2 : 3;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerTitle(),
            _buildShimmerAuthButton(),
            SizedBox(height: 20),
            _buildShimmerGrid(crossAxisCount),
            _buildShimmerTitle(),
            _buildShimmerGrid(crossAxisCount),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 150,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerAuthButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            elevation: 0,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                      Container(
                        width: 40,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth < 600) ? 2 : 3;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: _buildShimmerEffect(),
      );
    }

    if (error != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Services could not be fetched, Please load the page again',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              // Text(error!, textAlign: TextAlign.center),

              SizedBox(
                height: 40,
              ),

              // MyButton(text: 'Retry', onTap: _loadServices),
              // ElevatedButton(
              //   onPressed: _loadServices,
              //   child: Text('Retry'),
              // ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Services'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Authentication Service",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "! You need to login on rfkicks.com also to make some features work",
                            style: TextStyle(
                                fontSize: 7, color: Color(0xff3c76ad)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyButton(
                        text: "Check",
                        onTap: () async {
                          Uri url =
                              Uri.parse('https://rfkicks.com/authentication/');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ServiceGrid(
                  services: mainServices, crossAxisCount: crossAxisCount),
              SectionTitle(title: 'Individual Services'),
              ServiceGrid(
                  services: individualServices, crossAxisCount: crossAxisCount),
            ],
          ),
        ),
      ),
    );
  }
}

// class Service {
//   final String name;
//   final double price;
//   final String imagePath;
//   final String description;
//
//   Service(this.name, this.price, this.imagePath, this.description);
// }

// Services Model
class Service {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final String description;
  final String serviceType;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.serviceType,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imagePath: json['image_path'],
      description: json['description'] ?? '',
      serviceType: json['service_type'],
    );
  }
}
// class Service {
//   final int id;
//   final String name;
//   final double price;
//   final String imagePath;
//   final String description;
//   final String serviceType;
//   final int ordersCount;
//   final double totalRevenue;
//   final double averageRating;
//   final int reviewsCount;
//   final DateTime? lastOrderedAt;

//   Service({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.imagePath,
//     required this.description,
//     required this.serviceType,
//     this.ordersCount = 0,
//     this.totalRevenue = 0.0,
//     this.averageRating = 0.0,
//     this.reviewsCount = 0,
//     this.lastOrderedAt,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       id: json['id'],
//       name: json['name'],
//       price: double.parse(json['price'].toString()),
//       imagePath: json['image_path'],
//       description: json['description'] ?? '',
//       serviceType: json['service_type'],
//       ordersCount: json['orders_count'] ?? 0,
//       totalRevenue: double.parse(json['total_revenue']?.toString() ?? '0.0'),
//       averageRating: double.parse(json['average_rating']?.toString() ?? '0.0'),
//       reviewsCount: json['reviews_count'] ?? 0,
//       lastOrderedAt: json['last_ordered_at'] != null
//           ? DateTime.parse(json['last_ordered_at'])
//           : null,
//     );
//   }
// }

class ServiceGrid extends StatelessWidget {
  final List<Service> services;
  final int crossAxisCount;

  const ServiceGrid(
      {super.key, required this.services, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8, // Aspect ratio adjusted for responsiveness
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: ServiceCard(service: services[index]),
        );
      },
    );
  }
}

// class ServiceCard extends StatelessWidget {
//   final Service service;
//
//   const ServiceCard({super.key, required this.service});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           PageTransition(
//             type: PageTransitionType.rightToLeft,
//             child: ProductDescription(service: service),
//           ),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(2),
//             side: BorderSide(
//               color: Color(0xff3c76ad),
//               width: 1,
//             )),
//         elevation: 0,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   // child: Image.asset(
//                   //   service.imagePath,
//                   //   fit: BoxFit.fill,
//                   // ),
//                   child: Image.network(
//                     service.imagePath,
//                     fit: BoxFit.fill,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) {
//                         return child;
//                       }
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: Color(0xff3c76ad),
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                               loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       );
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[200],
//                         child: Icon(Icons.error_outline, color: Colors.grey),
//                       );
//                     },
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         service.name,
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                     Text(
//                       '\$${service.price}',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xff3c76ad),
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 8,
//               right: 6,
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration:
//                     BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                 child: IconButton(
//                   icon: Icon(Icons.shopping_cart_outlined,
//                       size: 25, color: Color(0xff3c76ad)),
//                   onPressed: () {
//                     Provider.of<CartProvider>(context, listen: false)
//                         .addToCart(service);
//                     CustomSnackbar.show(
//                       context: context,
//                       message: '${service.name} added to cart',
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeft,
        //     child: ProductDescription(service: service),
        //   ),
        // );

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ProductDescription(
              service: service,
              // shoeSize: null,
              // allServices: mainServices + individualServices, // Pass all services
              allServices: Provider.of<ServiceProvider>(context, listen: false)
                  .getAllServices(),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: BorderSide(
            color: Color(0xff3c76ad),
            width: 1,
          ),
        ),
        elevation: 0,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.network(
                    service.imagePath,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.error_outline, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        service.name,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      '\$${service.price}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff3c76ad),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 6,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 25,
                    color: Color(0xff3c76ad),
                  ),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(service);
                    CustomSnackbar.show(
                      context: context,
                      message: '${service.name} added to cart',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ServiceProvider with ChangeNotifier {
  List<Service> _mainServices = [];
  List<Service> _individualServices = [];

  List<Service> get mainServices => _mainServices;
  List<Service> get individualServices => _individualServices;

  void setServices(Map<String, List<Service>> services) {
    _mainServices = services['main'] ?? [];
    _individualServices = services['individual'] ?? [];
    notifyListeners();
  }

  List<Service> getAllServices() {
    return [..._mainServices, ..._individualServices];
  }
}
