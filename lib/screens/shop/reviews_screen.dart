// import 'package:flutter/material.dart';

// class ReviewsScreen extends StatelessWidget {
//   const ReviewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Reviews'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Customer Reviews",
//               style: TextStyle(fontSize: 28),
//             ),
//             Text(
//               "20 Reviews",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Row(
//               children: [
//                 Text(
//                   "4.87 Stars",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   "★ ★ ★ ★ ★",
//                   style: TextStyle(fontSize: 22),
//                 ),
//               ],
//             ),

//             // sample review 1
//             SizedBox(
//               height: 40,
//             ),
//             Text(
//               "Ahmad Ali.",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "★ ★ ★ ★ ★",
//               style: TextStyle(fontSize: 15, color: Color(0xff3c76ad)),
//             ),
//             Text(
//               "Every time I put on a pair friends think they're brand new lol. I tell them about Refresh Kicks and that they're responsible for keeping my kicks looking super fresh.",
//               style: TextStyle(fontSize: 15,),
//             ),

//             // sample review 2
//             SizedBox(
//               height: 40,
//             ),
//             Text(
//               "John Doe.",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "★ ★ ★ ★ ★",
//               style: TextStyle(fontSize: 15, color: Color(0xff3c76ad)),
//             ),
//             Text(
//               "I had no place to take my designer shoes to get cleaned and touched up until I found Refresh Kicks. I was referred to them by my coworkers and I couldn't been happier. What's a couple bucks to make a pair of shoes you spent a couple hundred dollars on to make them look brand new again?!",
//               style: TextStyle(fontSize: 15,),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:jobtask/services/api_service.dart';

// class ReviewsScreen extends StatelessWidget {
//   final int serviceId;

//   const ReviewsScreen({super.key, required this.serviceId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Reviews'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: ApiService.getServiceReviews(serviceId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Failed to load reviews'));
//           }

//           final reviews = snapshot.data ?? [];
//           final averageRating = reviews.isEmpty
//               ? 0.0
//               : reviews.fold<double>(
//                       0, (sum, review) => sum + review['rating']) /
//                   reviews.length;

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Customer Reviews",
//                   style: TextStyle(fontSize: 28),
//                 ),
//                 Text(
//                   "${reviews.length} Reviews",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "${averageRating.toStringAsFixed(2)} Stars",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       "★" * averageRating.round(),
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Color(0xff3c76ad),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: reviews.length,
//                     itemBuilder: (context, index) {
//                       final review = reviews[index];
//                       return _buildReviewItem(review);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildReviewItem(Map<String, dynamic> review) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             review['user_name'],
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "★" * review['rating'],
//             style: TextStyle(fontSize: 15, color: Color(0xff3c76ad)),
//           ),
//           Text(
//             review['review_text'],
//             style: TextStyle(fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }
// }

// reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:intl/intl.dart';

// class ReviewsScreen extends StatelessWidget {
//   final int serviceId;

//   const ReviewsScreen({super.key, required this.serviceId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Reviews'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: ApiService.getServiceReviews(serviceId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: CircularProgressIndicator(
//               color: Color(0xff3c76ad),
//             ));
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Failed to load reviews'));
//           }

//           final reviews = snapshot.data ?? [];
//           final averageRating = reviews.isEmpty
//               ? 0.0
//               : reviews.fold<double>(
//                       0, (sum, review) => sum + review['rating']) /
//                   reviews.length;

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Customer Reviews",
//                   style: TextStyle(fontSize: 28),
//                 ),
//                 Text(
//                   "${reviews.length} Reviews",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "${averageRating.toStringAsFixed(1)} Stars",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       "★" * averageRating.round(),
//                       style: TextStyle(
//                         fontSize: 22,
//                         color: Color(0xff3c76ad),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: reviews.isEmpty
//                       ? Center(child: Text('No reviews yet'))
//                       : ListView.builder(
//                           itemCount: reviews.length,
//                           itemBuilder: (context, index) {
//                             final review = reviews[index];
//                             return _buildReviewItem(review);
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildReviewItem(Map<String, dynamic> review) {
//     final date =
//         DateFormat('MMM dd, yyyy').format(DateTime.parse(review['created_at']));

//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 review['user_name'],
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(date, style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             "★" * review['rating'],
//             style: TextStyle(fontSize: 16, color: Color(0xff3c76ad)),
//           ),
//           SizedBox(height: 8),
//           Text(
//             review['review_text'],
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
