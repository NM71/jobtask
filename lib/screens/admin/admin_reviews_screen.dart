import 'package:flutter/material.dart';
import 'package:jobtask/services/admin_api_service.dart';
import 'package:intl/intl.dart';

class AdminReviewsScreen extends StatefulWidget {
  final int serviceId;

  const AdminReviewsScreen({super.key, required this.serviceId});

  @override
  State<AdminReviewsScreen> createState() => _AdminReviewsScreenState();
}

class _AdminReviewsScreenState extends State<AdminReviewsScreen> {
  int? selectedRating;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       foregroundColor: Colors.white,
  //       title: Text('Service Reviews'),
  //       centerTitle: true,
  //     ),
  //     body: Stack(
  //       children: [
  //         const Positioned.fill(
  //           child: DecoratedBox(
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 opacity: 0.3,
  //                 image: AssetImage('assets/images/rfkicks_bg.jpg'),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         ),
  //         FutureBuilder<List<Map<String, dynamic>>>(
  //           future: AdminApiService.getServiceReviews(widget.serviceId),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(
  //                   child: CircularProgressIndicator(
  //                 color: Colors.white,
  //               ));
  //             }

  //             if (snapshot.hasError) {
  //               return Center(
  //                 child: Text(
  //                   'Failed to load reviews',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               );
  //             }

  //             final reviews = snapshot.data ?? [];
  //             final averageRating = reviews.isEmpty
  //                 ? 0.0
  //                 : reviews.fold<double>(
  //                         0, (sum, review) => sum + review['rating']) /
  //                     reviews.length;

  //             return Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Customer Reviews",
  //                     style: TextStyle(
  //                       fontSize: 28,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Row(
  //                     children: [
  //                       Text(
  //                         "${reviews.length} Reviews",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                       SizedBox(width: 16),
  //                       Text(
  //                         "${averageRating.toStringAsFixed(1)} ★",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 20),
  //                   Expanded(
  //                     child: reviews.isEmpty
  //                         ? Center(
  //                             child: Text(
  //                               'No reviews yet',
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                           )
  //                         : ListView.builder(
  //                             itemCount: reviews.length,
  //                             itemBuilder: (context, index) {
  //                               final review = reviews[index];
  //                               return _buildReviewItem(review);
  //                             },
  //                           ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Service Reviews'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // const Positioned.fill(
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         opacity: 0.3,
          //         image: AssetImage('assets/images/rfkicks_bg.jpg'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: AdminApiService.getServiceReviews(widget.serviceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text('Failed to load reviews',
                        style: TextStyle(color: Colors.white)));
              }

              final allReviews = snapshot.data ?? [];
              final reviews = selectedRating == null
                  ? allReviews
                  : allReviews
                      .where((review) => review['rating'] == selectedRating)
                      .toList();

              final averageRating = reviews.isEmpty
                  ? 0.0
                  : reviews.fold<double>(
                          0, (sum, review) => sum + review['rating']) /
                      reviews.length;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Reviews",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${reviews.length} Reviews",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "${averageRating.toStringAsFixed(1)} ★",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(null, 'All Reviews'),
                          ...List.generate(
                              5,
                              (index) => _buildFilterChip(
                                  5 - index, '${5 - index} ★')),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: reviews.isEmpty
                          ? Center(
                              child: Text(
                                selectedRating == null
                                    ? 'No reviews yet'
                                    : 'No $selectedRating-star reviews',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              itemCount: reviews.length,
                              itemBuilder: (context, index) =>
                                  _buildReviewItem(reviews[index]),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(int? rating, String label) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selectedRating == rating,
        onSelected: (_) => setState(() => selectedRating = rating),
        backgroundColor: Colors.white.withOpacity(0.1),
        selectedColor: Color(0xff3c76ad),
        labelStyle: TextStyle(
            color: selectedRating == rating ? Colors.white : Colors.black,
            fontSize: 12),
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    final date =
        DateFormat('MMM dd, yyyy').format(DateTime.parse(review['created_at']));

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review['user_name'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "★" * review['rating'],
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3c76ad),
                ),
              ),
              Text(
                " (${review['rating']}.0)",
                style: TextStyle(
                  color: Color(0xff3c76ad),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            review['review_text'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
