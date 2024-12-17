// import 'package:flutter/material.dart';
//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Service> _filteredServices = [];
//   final List<String> _searchHistory = [];
//
//   final List<Service> services = [
//     Service('ReFresh', 30, 'assets/images/services_images/refresh_service.jpg'),
//     Service('ReVive', 50, 'assets/images/services_images/revive_service.jpg'),
//     Service('ReStore', 150, 'assets/images/services_images/restore_service.jpg'),
//     Service('Kids Shoe', 150, 'assets/images/services_images/kids_service.jpg'),
//     Service('Lace Cleaning', 20, 'assets/images/services_images/laceCleaning_service.jpg'),
//     Service('Lint Removal', 20, 'assets/images/services_images/lintRemove_service.jpg'),
//     Service('Reglue', 40, 'assets/images/services_images/reglue_service.jpg'),
//     Service('RePaint', 70, 'assets/images/services_images/repaint_service.jpg'),
//     Service('Un-Yellowing', 70, 'assets/images/services_images/unYellowing_service.jpg'),
//     Service('Sole-Swaps', 80, 'assets/images/services_images/soleSwaps_service.jpg'),
//   ];
//
//   void _filterServices(String query) {
//     final filtered = services.where((service) {
//       return service.name.toLowerCase().contains(query.toLowerCase());
//     }).toList();
//     setState(() {
//       _filteredServices = filtered;
//     });
//   }
//
//   void _addToSearchHistory(String query) {
//     if (!_searchHistory.contains(query)) {
//       setState(() {
//         _searchHistory.add(query);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Search'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               onChanged: (query) {
//                 _filterServices(query);
//                 if (query.isNotEmpty) {
//                   _addToSearchHistory(query);
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter service name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: [
//                   Text('History:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ..._searchHistory.map((history) {
//                     return ListTile(
//                       title: Text(history),
//                       onTap: () {
//                         _searchController.text = history;
//                         _filterServices(history);
//                       },
//                     );
//                   }),
//                   Divider(),
//                   Text('Results:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ..._filteredServices.map((service) {
//                     return ListTile(
//                       title: Text(service.name),
//                       subtitle: Text('\$${service.price}'),
//                       leading: Image.asset(service.imagePath, height: 50, width: 50),
//                       onTap: () {
//                         // Navigate to service details if necessary
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Service {
//   final String name;
//   final double price;
//   final String imagePath;
//
//   Service(this.name, this.price, this.imagePath);
// }

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Service> _filteredServices = [];
  final List<String> _searchHistory = [];
  bool _isLoading = false;

  // Add categories for better organization
  final Map<String, String> categories = {
    'Cleaning': '🧹',
    'Restoration': '🔄',
    'Customization': '🎨',
    'Repair': '🔧',
  };

  final List<Service> services = [
    Service(
      'ReFresh',
      30,
      'assets/images/services_images/refresh_service.jpg',
      'Cleaning',
      'Deep cleaning service for all types of shoes',
      ['Sneakers', 'Leather', 'Canvas'],
    ),
    Service(
      'ReVive',
      50,
      'assets/images/services_images/revive_service.jpg',
      'Restoration',
      'Restore your shoes to their former glory',
      ['Vintage', 'Designer', 'Limited Edition'],
    ),
    Service(
      'ReStore',
      50,
      'assets/images/services_images/restore_service.jpg',
      'Restoration',
      'Restore your shoes like they are new',
      ['Vintage', 'Designer', 'Limited Edition'],
    ),
    // Add the rest of your services with additional details...
  ];

  @override
  void initState() {
    super.initState();
    _filteredServices = services;
  }

  void _filterServices(String query) {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay for smooth loading animation
    Future.delayed(const Duration(milliseconds: 500), () {
      final filtered = services.where((service) {
        final nameMatch =
            service.name.toLowerCase().contains(query.toLowerCase());
        final categoryMatch =
            service.category.toLowerCase().contains(query.toLowerCase());
        final descriptionMatch =
            service.description.toLowerCase().contains(query.toLowerCase());
        final tagsMatch = service.tags
            .any((tag) => tag.toLowerCase().contains(query.toLowerCase()));

        return nameMatch || categoryMatch || descriptionMatch || tagsMatch;
      }).toList();

      setState(() {
        _filteredServices = filtered;
        _isLoading = false;
      });
    });
  }

  void _addToSearchHistory(String query) {
    if (!_searchHistory.contains(query) && query.trim().isNotEmpty) {
      setState(() {
        _searchHistory.insert(0, query); // Add to beginning of list
        if (_searchHistory.length > 5) {
          // Limit history to 5 items
          _searchHistory.removeLast();
        }
      });
    }
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Search Services',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        actions: [
          if (_searchHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all, color: Colors.black54),
              onPressed: _clearSearchHistory,
              tooltip: 'Clear search history',
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  _filterServices(query);
                  if (query.isNotEmpty) {
                    _addToSearchHistory(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search services, categories, or tags...',
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.black54),
                          onPressed: () {
                            _searchController.clear();
                            _filterServices('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
            if (_searchHistory.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Searches',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _searchHistory.map((history) {
                        return Chip(
                          label: Text(history),
                          onDeleted: () {
                            setState(() {
                              _searchHistory.remove(history);
                            });
                          },
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          deleteIconColor: Colors.blue,
                          labelStyle: const TextStyle(color: Colors.blue),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredServices.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No services found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredServices.length,
                          itemBuilder: (context, index) {
                            final service = _filteredServices[index];
                            return ServiceCard(service: service);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to service details
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Hero(
                  tag: 'service_${service.name}',
                  child: Image.asset(
                    service.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${service.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: service.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final double price;
  final String imagePath;
  final String category;
  final String description;
  final List<String> tags;

  Service(
    this.name,
    this.price,
    this.imagePath,
    this.category,
    this.description,
    this.tags,
  );
}
