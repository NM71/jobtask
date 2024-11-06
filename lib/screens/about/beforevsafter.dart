// import 'package:before_after/before_after.dart';
// import 'package:flutter/material.dart';
//
// class BeforeAfterComparison extends StatefulWidget {
//   const BeforeAfterComparison({super.key});
//
//   @override
//   State<BeforeAfterComparison> createState() => _BeforeAfterComparisonState();
// }
//
// class _BeforeAfterComparisonState extends State<BeforeAfterComparison> {
//   // Constants
//   static const double _defaultValue = 0.5;
//   static const Color _themeColor = Color(0xff3c76ad);
//
//   // Data structure for before/after images
//   final List<ImagePair> _imagePairs = [
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg',
//     ),
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/14e23d6237f7be41b044165aa78b5c18.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/06/0e1409954f44139dab295c7af08eb4be.jpeg',
//     ),
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/be380a92f52107ef9405ceb3d623244b-1.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/08/d6fc6ffd15e9709c3263a08702f6b02b-1.jpeg',
//     ),
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/dd50c8e77f3e3d3d0756a097b65953b5.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/08/before.jpeg',
//     ),
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/after.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/08/851d27e601f12c3f43851b78020fb18b.jpeg',
//     ),
//     ImagePair(
//       before: 'https://rfkicks.com/wp-content/uploads/2024/08/a.jpeg',
//       after: 'https://rfkicks.com/wp-content/uploads/2024/08/b.jpeg',
//     ),
//   ];
//
//   // State management
//   late final List<double> _sliderValues;
//
//   @override
//   void initState() {
//     super.initState();
//     _sliderValues = List.filled(_imagePairs.length, _defaultValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 20),
//                   ..._buildImageComparisons(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//       child: Column(
//         children: const [
//           Text(
//             "Before vs After",
//             style: TextStyle(
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Our past services that we've completed for customers.\n\n"
//                 "Yes, each shoe you see is the exact same shoe. No switcharoos, "
//                 "no photoshopping, no editing!",
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildImageComparisons() {
//     return List.generate(
//       _imagePairs.length,
//           (index) => Padding(
//         padding: const EdgeInsets.all(25),
//         child: BeforeAfter(
//           thumbColor: _themeColor,
//           trackColor: Color(0xff3c76ad),
//           overlayColor: const WidgetStatePropertyAll(_themeColor),
//           value: _sliderValues[index],
//           before: Image.network(
//             _imagePairs[index].before,
//             loadingBuilder: _handleImageLoading,
//             errorBuilder: _handleImageError,
//           ),
//           after: Image.network(
//             _imagePairs[index].after,
//             loadingBuilder: _handleImageLoading,
//             errorBuilder: _handleImageError,
//           ),
//           onValueChanged: (value) => setState(() => _sliderValues[index] = value),
//         ),
//       ),
//     );
//   }
//
//   Widget _handleImageLoading(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//     if (loadingProgress == null) return child;
//     return Center(
//       child: CircularProgressIndicator(
//         value: loadingProgress.expectedTotalBytes != null
//             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//             : null,
//       ),
//     );
//   }
//
//   Widget _handleImageError(BuildContext context, Object error, StackTrace? stackTrace) {
//     return const Center(
//       child: Icon(
//         Icons.error_outline,
//         color: Colors.red,
//         size: 48,
//       ),
//     );
//   }
// }
//
// // Data model for image pairs
// class ImagePair {
//   final String before;
//   final String after;
//
//   const ImagePair({
//     required this.before,
//     required this.after,
//   });
// }
//







































import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';

class BeforeAfterComparison extends StatefulWidget {
  const BeforeAfterComparison({super.key});

  @override
  State<BeforeAfterComparison> createState() => _BeforeAfterComparisonState();
}

class _BeforeAfterComparisonState extends State<BeforeAfterComparison> {
  static const double _defaultValue = 0.5;
  static const Color _themeColor = Color(0xff3c76ad);

  final List<ImagePair> _imagePairs = [
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/14e23d6237f7be41b044165aa78b5c18.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/06/0e1409954f44139dab295c7af08eb4be.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/be380a92f52107ef9405ceb3d623244b-1.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/d6fc6ffd15e9709c3263a08702f6b02b-1.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/dd50c8e77f3e3d3d0756a097b65953b5.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/before.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/after.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/851d27e601f12c3f43851b78020fb18b.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/a.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/b.jpeg',
    ),
  ];

  late final List<double> _sliderValues;

  @override
  void initState() {
    super.initState();
    _sliderValues = List.filled(_imagePairs.length, _defaultValue);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(screenWidth),
            const SizedBox(height: 20),
            ..._buildImageComparisons(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Column(
        children: [
          Text(
            "Before vs After",
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Our past services that we've completed for customers.\n\n"
                "Yes, each shoe you see is the exact same shoe. No switcharoos, "
                "no photoshopping, no editing!",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageComparisons(double screenWidth) {
    return List.generate(
      _imagePairs.length,
          (index) => Padding(
        padding: const EdgeInsets.all(15),
        child: FractionallySizedBox(
          widthFactor: screenWidth > 600 ? 0.7 : 1.0,
          child: BeforeAfter(
            thumbColor: _themeColor,
            trackColor: _themeColor,
            value: _sliderValues[index],
            before: Image.network(
              _imagePairs[index].before,
              fit: BoxFit.cover,
              loadingBuilder: _handleImageLoading,
              errorBuilder: _handleImageError,
            ),
            after: Image.network(
              _imagePairs[index].after,
              fit: BoxFit.cover,
              loadingBuilder: _handleImageLoading,
              errorBuilder: _handleImageError,
            ),
            onValueChanged: (value) => setState(() => _sliderValues[index] = value),
          ),
        ),
      ),
    );
  }

  Widget _handleImageLoading(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

  Widget _handleImageError(BuildContext context, Object error, StackTrace? stackTrace) {
    return const Center(
      child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 48,
      ),
    );
  }
}

class ImagePair {
  final String before;
  final String after;

  const ImagePair({
    required this.before,
    required this.after,
  });
}
