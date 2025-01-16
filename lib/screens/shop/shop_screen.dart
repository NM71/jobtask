import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
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
                            "Login on Rfkicks.com to use this feature.",
                            style: TextStyle(
                                fontSize: 8, color: Color(0xff3c76ad)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyButton(
                        text: "Check",
                        height: 40,
                        width: 100,
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
        elevation: 3,
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
                    HapticFeedback.lightImpact();
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(service);

                    final count =
                        Provider.of<CartProvider>(context, listen: false)
                            .cartItems
                            .firstWhere((item) => item.service.id == service.id,
                                orElse: () =>
                                    CartItem(service: service, quantity: 0))
                            .quantity;
                    CustomSnackbar.show(
                      context: context,
                      message: '($count)  ${service.name} added to cart',
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
