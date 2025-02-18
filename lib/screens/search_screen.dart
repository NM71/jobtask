import 'package:flutter/material.dart';
import 'package:jobtask/screens/shop/shop_now.dart';
import 'package:jobtask/screens/shop/shop_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Service> _searchResults = [];
  List<String> _recentSearches = [];
  static const String recentSearchesKey = 'recent_searches';

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final services = await ApiService.getServices();
    if (!mounted) return;
    Provider.of<ServiceProvider>(context, listen: false).setServices(services);
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList(recentSearchesKey) ?? [];
    });
  }

  Future<void> _addToRecentSearches(String query) async {
    if (query.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    Set<String> searches = Set.from(_recentSearches);
    searches = {query, ...searches.take(9)};
    _recentSearches = searches.toList();
    await prefs.setStringList(recentSearchesKey, _recentSearches);
    setState(() {});
  }

  Future<void> _clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(recentSearchesKey);
    setState(() {
      _recentSearches = [];
    });
  }

  void _filterServices(String query) {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final allServices =
        Provider.of<ServiceProvider>(context, listen: false).getAllServices();

    setState(() {
      _searchResults = allServices.where((service) {
        return service.name.toLowerCase().contains(query.toLowerCase()) ||
            service.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty || _searchController.text.isNotEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _clearRecentSearches,
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _recentSearches.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.history),
              title: Text(_recentSearches[index]),
              trailing: IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _recentSearches.removeAt(index);
                  });
                  await prefs.setStringList(recentSearchesKey, _recentSearches);
                },
              ),
              onTap: () {
                _searchController.text = _recentSearches[index];
                _filterServices(_recentSearches[index]);
              },
            );
          },
        ),
      ],
    );
  }

  // Widget _buildRecentSearches() {
  //   if (_recentSearches.isEmpty || _searchController.text.isNotEmpty) {
  //     return SizedBox.shrink();
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Recent Searches',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: _clearRecentSearches,
  //               child: Text(
  //                 'Clear',
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: _recentSearches.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             leading: Icon(Icons.history),
  //             title: Text(_recentSearches[index]),
  //             onTap: () {
  //               _searchController.text = _recentSearches[index];
  //               _filterServices(_recentSearches[index]);
  //             },
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Icon(Icons.search, color: Color(0xff3c76ad)),
        leading: Image.asset(
          'assets/icons/MagnifyingGlass.png',
          height: 24,
          width: 24,
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search services...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _filterServices('');
                    },
                  )
                : null,
          ),
          onChanged: _filterServices,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _searchResults.isEmpty
                ? _buildRecentSearches()
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final service = _searchResults[index];
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            service.imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          service.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          service.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          '\$${service.price}',
                          style: TextStyle(
                            color: Color(0xff3c76ad),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          _addToRecentSearches(_searchController.text);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ShopNow(
                                service: service,
                                shoeSize: null,
                                allServices: Provider.of<ServiceProvider>(
                                        context,
                                        listen: false)
                                    .getAllServices(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
