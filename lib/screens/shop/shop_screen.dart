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


























import 'package:flutter/material.dart';
import 'package:jobtask/screens/cart/cart_provider.dart';
import 'package:jobtask/screens/cart/cart_screen.dart';
import 'package:jobtask/screens/cart/product_description.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ServicePage extends StatelessWidget {
  final List<Service> services = [
    Service(
      'ReFresh',
      30,
      'assets/images/services_images/refresh_service.jpg',
      '● Basic cleaning of shoe exterior-removes scuffs\n● Minor scratches\n● Stone and most stains\n\n 2-3 business days',
    ),
    Service(
      'ReVive',
      50,
      'assets/images/services_images/revive_service.jpg',
      '● Interior and Exterior Cleaning\n● Deodorizing\n● Minor Paint touch-ups (If needed)\n● Removes Gum\n● Removes Grass and Mud Stones\n● Removes Deep Scuffs\n● Cleans Suede\n● Lace Cleaning',
    ),
    Service(
      'ReStore',
      150,
      'assets/images/services_images/restore_service.jpg',
      '● Lace Swap (if needed)\n● Sole Swap (If needed & sole must be provided)\n● Full Repaint (if needed)\n● Replacement Parts (If needed)',
    ),
    Service(
      'Kids Shoe',
      150,
      'assets/images/services_images/kids_service.jpg',
      '● A specialized cleaning service for kids shoes, ensuring they look brand new.',
    ),
  ];

  final List<Service> individualServices = [
    Service(
      'Lace Cleaning',
      20,
      'assets/images/services_images/laceCleaning_service.jpg',
      '● Lace Cleaning\n● Lace Swap (if needed)',
    ),
    Service(
      'Lint Removal',
      20,
      'assets/images/services_images/lintRemove_service.jpg',
      '',
    ),
    Service(
      'Reglue',
      40,
      'assets/images/services_images/reglue_service.jpg',
      '',
    ),
    Service(
      'RePaint',
      70,
      'assets/images/services_images/repaint_service.jpg',
      '',
    ),
    Service(
      'Un-Yellowing',
      70,
      'assets/images/services_images/unYellowing_service.jpg',
      '',
    ),
    Service(
      'Sole-Swaps',
      80,
      'assets/images/services_images/soleSwaps_service.jpg',
      '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine crossAxisCount based on screen width
    int crossAxisCount = (screenWidth < 600) ? 2 : 3; // Adjusts number of columns

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Services'),
              ServiceGrid(services: services, crossAxisCount: crossAxisCount),
              SectionTitle(title: 'Individual Services'),
              ServiceGrid(services: individualServices, crossAxisCount: crossAxisCount),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         PageTransition(
      //           child: CartScreen(),
      //           type: PageTransitionType.bottomToTop,
      //         ));
      //   },
      //   backgroundColor: Color(0xff3c76ad),
      //   child: Icon(
      //     Icons.shopping_cart_checkout_outlined,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}

class Service {
  final String name;
  final double price;
  final String imagePath;
  final String description;

  Service(this.name, this.price, this.imagePath, this.description);
}

class ServiceGrid extends StatelessWidget {
  final List<Service> services;
  final int crossAxisCount;

  const ServiceGrid({Key? key, required this.services, required this.crossAxisCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.70, // Aspect ratio adjusted for responsiveness
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceCard(service: services[index]);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ProductDescription(service: service),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: Color(0xff3c76ad),
              width: 1,
            )),
        elevation: 0,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.asset(
                    service.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        service.name,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '\$${service.price}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff3c76ad),
                          fontWeight: FontWeight.bold),
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
                decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined,
                      size: 24, color: Color(0xff3c76ad)),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(service);
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

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}



