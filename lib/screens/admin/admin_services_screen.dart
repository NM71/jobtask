import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobtask/models/admin_services.dart';
import 'package:jobtask/screens/admin/admin_reviews_screen.dart';
import 'package:jobtask/screens/shop/reviews_screen.dart';
import 'package:jobtask/services/admin_api_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class AdminServicesScreen extends StatefulWidget {
  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoading = true;
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadServices();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadServices() async {
    try {
      final services = await AdminApiService.getServices();

      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      setState(() => _isLoading = false);
    }
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 6, // Show 6 skeleton items while loading
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[900]!,
          highlightColor: Colors.grey[700]!,
          child: Card(
            margin: EdgeInsets.only(bottom: 16),
            color: Colors.white.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Image placeholder
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title placeholder
                        Container(
                          width: 150,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        // Price placeholder
                        Container(
                          width: 80,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        // Description placeholder
                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 200,
                          height: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  // Action buttons placeholder
                  Container(
                    width: 80,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainServices =
        _services.where((s) => s.serviceType == 'main').toList();
    final individualServices =
        _services.where((s) => s.serviceType == 'individual').toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  image: AssetImage('assets/images/rfkicks_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _isLoading
                      ? _buildLoadingShimmer()
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            RefreshIndicator(
                              onRefresh: _loadServices,
                              color: Color(0xff3c76ad),
                              child: ListView.builder(
                                padding: EdgeInsets.all(16),
                                itemCount: mainServices.length,
                                itemBuilder: (context, index) =>
                                    _buildServiceCard(mainServices[index]),
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: _loadServices,
                              color: Color(0xff3c76ad),
                              child: ListView.builder(
                                padding: EdgeInsets.all(16),
                                itemCount: individualServices.length,
                                itemBuilder: (context, index) =>
                                    _buildServiceCard(
                                        individualServices[index]),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditServiceDialog(),
        backgroundColor: Color(0xff3c76ad),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     padding: EdgeInsets.all(20),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           onPressed: () => Navigator.pop(context),
  //           icon: Icon(Icons.arrow_back_ios, color: Colors.white),
  //         ),
  //         SizedBox(width: 8),
  //         Text(
  //           'Manage Services',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Manage Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Main Services'),
            Tab(text: 'Individual Services'),
          ],
          indicatorColor: Color(0xff3c76ad),
          labelColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildServiceCard(Service service) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminReviewsScreen(serviceId: service.id),
            ),
          );
        },
        contentPadding: EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            service.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60,
              height: 60,
              color: Colors.grey,
              child: Icon(Icons.error),
            ),
          ),
        ),
        title: Text(
          service.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${service.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Color(0xff3c76ad),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (service.description != null)
              Text(
                service.description!,
                style: TextStyle(color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, color: Colors.white),
              onPressed: () => _showAddEditServiceDialog(service),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _showDeleteDialog(service),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(Service service) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xccf2f2f2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        title: Text('Delete Service'),
        content: Text('Are you sure you want to delete ${service.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel',
                style: TextStyle(color: Colors.black, fontSize: 17)),
          ),

          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text('Delete'),
          ),
          // TextButton(
          //   onPressed: () => Navigator.pop(context, true),
          //   child: Text('Delete', style: TextStyle(color: Colors.red)),
          // ),
        ],
      ),
    );

    // if (confirmed == true) {
    //   try {
    //     await AdminApiService.deleteService(service.id);
    //     _loadServices();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Service deleted successfully')),
    //     );
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(e.toString())),
    //     );
    //   }
    // }

    if (confirmed == true) {
      try {
        await AdminApiService.deleteService(service.id);
        setState(() {
          _services.removeWhere((s) => s.id == service.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  // Future<void> _showAddEditServiceDialog([Service? service]) async {
  //   final nameController = TextEditingController(text: service?.name);
  //   final priceController =
  //       TextEditingController(text: service?.price.toStringAsFixed(2));
  //   final descriptionController =
  //       TextEditingController(text: service?.description);
  //   // final imagePathController = TextEditingController(text: service?.imagePath);
  //   String serviceType = service?.serviceType ?? 'main';

  //   // Image Picking
  //   File? _imageFile;
  //   String? _imageUrl = service?.imagePath;
  //   String? _existingImageUrl = service?.imagePath; // Store existing image URL

  //   Future<void> _pickImage() async {
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //     if (image != null) {
  //       setState(() {
  //         _imageFile = File(image.path);
  //       });

  //       // Upload image and get URL
  //       try {
  //         final url = await AdminApiService.uploadServiceImage(_imageFile!);
  //         setState(() {
  //           _imageUrl = url;
  //         });
  //       } catch (e) {
  //         // Handle error
  //       }
  //     }
  //   }

  //   final result = await showDialog<Map<String, dynamic>>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: Colors.black87,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(6),
  //         side: BorderSide(color: Color(0xff3c76ad), width: 1),
  //       ),
  //       insetPadding: EdgeInsets.symmetric(horizontal: 15),
  //       contentPadding: EdgeInsets.all(18),
  //       title: Text(
  //         service == null ? 'Add Service' : 'Edit Service',
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //       content: SizedBox(
  //         width: double.maxFinite,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(height: 10),
  //               // image
  //               GestureDetector(
  //                 onTap: _pickImage,
  //                 child: Container(
  //                   width: 100,
  //                   height: 100,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     border: Border.all(color: Color(0xff3c76ad), width: 2),
  //                     image: _imageFile != null
  //                         ? DecorationImage(
  //                             image: FileImage(_imageFile!),
  //                             fit: BoxFit.cover,
  //                           )
  //                         : _existingImageUrl != null
  //                             ? DecorationImage(
  //                                 // image: NetworkImage(_existingImageUrl!),
  //                                 image: NetworkImage(_existingImageUrl),
  //                                 fit: BoxFit.cover,
  //                               )
  //                             : null,
  //                   ),
  //                   child: (_imageFile == null && _existingImageUrl == null)
  //                       ? Icon(
  //                           Icons.camera_alt,
  //                           color: Color(0xff3c76ad),
  //                           size: 40,
  //                         )
  //                       : null,
  //                 ),
  //               ),

  //               SizedBox(height: 16),

  //               TextField(
  //                 controller: nameController,
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                   labelText: 'Name',
  //                   labelStyle: TextStyle(color: Colors.white70),
  //                   enabledBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.white30),
  //                   ),
  //                   focusedBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Color(0xff3c76ad)),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               TextField(
  //                 controller: priceController,
  //                 style: TextStyle(color: Colors.white),
  //                 keyboardType: TextInputType.number,
  //                 decoration: InputDecoration(
  //                   labelText: 'Price',
  //                   labelStyle: TextStyle(color: Colors.white70),
  //                   enabledBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.white30),
  //                   ),
  //                   focusedBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Color(0xff3c76ad)),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               TextField(
  //                 controller: descriptionController,
  //                 style: TextStyle(color: Colors.white),
  //                 maxLines: 3,
  //                 decoration: InputDecoration(
  //                   labelText: 'Description',
  //                   labelStyle: TextStyle(color: Colors.white70),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.white30),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Color(0xff3c76ad)),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               // TextField(
  //               //   controller: imagePathController,
  //               //   style: TextStyle(color: Colors.white),
  //               //   decoration: InputDecoration(
  //               //     labelText: 'Image Path',
  //               //     labelStyle: TextStyle(color: Colors.white70),
  //               //     enabledBorder: UnderlineInputBorder(
  //               //       borderSide: BorderSide(color: Colors.white30),
  //               //     ),
  //               //     focusedBorder: UnderlineInputBorder(
  //               //       borderSide: BorderSide(color: Color(0xff3c76ad)),
  //               //     ),
  //               //   ),
  //               // ),

  //               // ElevatedButton(
  //               //   onPressed: _pickImage,
  //               //   child: Text('Choose Image'),
  //               // ),
  //               // if (_imageFile != null) Image.file(_imageFile!, height: 100),

  //               DropdownButtonFormField<String>(
  //                 value: serviceType,
  //                 dropdownColor: Colors.black87,
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                   labelText: 'Service Type',
  //                   labelStyle: TextStyle(color: Colors.white70),
  //                   enabledBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.white30),
  //                   ),
  //                   focusedBorder: UnderlineInputBorder(
  //                     borderSide: BorderSide(color: Color(0xff3c76ad)),
  //                   ),
  //                 ),
  //                 items: ['main', 'individual'].map((type) {
  //                   return DropdownMenuItem(
  //                     value: type,
  //                     child: Text(type, style: TextStyle(color: Colors.white)),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) => serviceType = value!,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text(
  //             'Cancel',
  //             style: TextStyle(color: Colors.white70),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             Navigator.pop(context, {
  //               'name': nameController.text,
  //               'price': priceController.text,
  //               'description': descriptionController.text,
  //               // 'image_path': imagePathController.text,
  //               'image_path': _imageUrl ?? '',

  //               'service_type': serviceType,
  //             });
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Color(0xff3c76ad),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           child: Text(
  //             service == null ? 'Add' : 'Update',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   // if (result != null) {
  //   //   try {
  //   //     if (service == null) {
  //   //       await AdminApiService.addService(result);
  //   //     } else {
  //   //       await AdminApiService.updateService(service.id, result);
  //   //     }
  //   //     _loadServices();
  //   //     ScaffoldMessenger.of(context).showSnackBar(
  //   //       SnackBar(
  //   //           content: Text(service == null
  //   //               ? 'Service added successfully'
  //   //               : 'Service updated successfully')),
  //   //     );
  //   //   } catch (e) {
  //   //     ScaffoldMessenger.of(context).showSnackBar(
  //   //       SnackBar(content: Text(e.toString())),
  //   //     );
  //   //   }
  //   // }

  //   if (result != null) {
  //     try {
  //       if (service == null) {
  //         final newService = await AdminApiService.addService(result);
  //         print('New service added: ${newService.id}');

  //         setState(() {
  //           _services.add(newService);
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Service added successfully')),
  //         );
  //       } else {
  //         final updatedService =
  //             await AdminApiService.updateService(service.id, result);
  //         setState(() {
  //           final index = _services.indexWhere((s) => s.id == service.id);
  //           if (index != -1) {
  //             _services[index] = updatedService;
  //           }
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Service updated successfully')),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(e.toString())),
  //       );
  //     }
  //   }
  // }

  Future<void> _showAddEditServiceDialog([Service? service]) async {
    final nameController = TextEditingController(text: service?.name);
    final priceController =
        TextEditingController(text: service?.price.toStringAsFixed(2));
    final descriptionController =
        TextEditingController(text: service?.description);
    String serviceType = service?.serviceType ?? 'main';

    File? _imageFile;
    String? _imageUrl = service?.imagePath;
    String? _existingImageUrl = service?.imagePath;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: Color(0xff3c76ad), width: 1),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          contentPadding: EdgeInsets.all(18),
          title: Text(
            service == null ? 'Add Service' : 'Edit Service',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        setState(() {
                          _imageFile = File(image.path);
                        });

                        try {
                          final url = await AdminApiService.uploadServiceImage(
                              _imageFile!);
                          setState(() {
                            _imageUrl = url;
                            _existingImageUrl = url;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to upload image')),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff3c76ad), width: 2),
                        image: _imageFile != null
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              )
                            : _existingImageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(_existingImageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                      child: (_imageFile == null && _existingImageUrl == null)
                          ? Icon(
                              Icons.camera_alt,
                              color: Color(0xff3c76ad),
                              size: 40,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3c76ad)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: priceController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3c76ad)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3c76ad)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: serviceType,
                    dropdownColor: Colors.black87,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Service Type',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3c76ad)),
                      ),
                    ),
                    items: ['main', 'individual'].map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child:
                            Text(type, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) => serviceType = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'price': priceController.text,
                  'description': descriptionController.text,
                  'image_path': _imageUrl ?? '',
                  'service_type': serviceType,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3c76ad),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                service == null ? 'Add' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      try {
        if (service == null) {
          final newService = await AdminApiService.addService(result);
          setState(() {
            _services.add(newService);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Service added successfully')),
          );
        } else {
          final updatedService =
              await AdminApiService.updateService(service.id, result);
          setState(() {
            final index = _services.indexWhere((s) => s.id == service.id);
            if (index != -1) {
              _services[index] = updatedService;
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Service updated successfully')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
