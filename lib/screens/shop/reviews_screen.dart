import 'package:flutter/material.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:intl/intl.dart';

class ReviewsScreen extends StatefulWidget {
  final int serviceId;
  const ReviewsScreen({super.key, required this.serviceId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int? selectedRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Reviews',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ApiService.getServiceReviews(widget.serviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0xff3c76ad),
              ));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Failed to load reviews'));
            }

            final allReviews = snapshot.data ?? [];
            final reviews = selectedRating == null
                ? allReviews
                : allReviews
                    .where((review) => review['rating'] == selectedRating)
                    .toList();

            final averageRating = allReviews.isEmpty
                ? 0.0
                : allReviews.fold<double>(
                        0, (sum, review) => sum + review['rating']) /
                    allReviews.length;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Reviews",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "${allReviews.length} Reviews",
                    style: TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        "${averageRating.toStringAsFixed(1)} Stars",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "★ " * averageRating.round(),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(null, 'All'),
                        ...List.generate(
                            5,
                            (index) =>
                                _buildFilterChip(5 - index, '${5 - index} ★')),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: reviews.isEmpty
                        ? Center(
                            child: Text(selectedRating == null
                                ? 'No reviews yet'
                                : 'No $selectedRating-star reviews'))
                        : ListView.builder(
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              return _buildReviewItem(reviews[index]);
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
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
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
        side: BorderSide(
          color: selectedRating == rating ? Color(0xff3c76ad) : Colors.grey,
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          color: selectedRating == rating ? Color(0xff3c76ad) : Colors.black,
        ),
        checkmarkColor: Color(0xff3c76ad),
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    final date =
        DateFormat('MMM dd, yyyy').format(DateTime.parse(review['created_at']));

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review['user_name'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(date, style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "★" * review['rating'],
            style: TextStyle(fontSize: 14, color: Color(0xff3c76ad)),
          ),
          SizedBox(height: 8),
          Text(
            review['review_text'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
