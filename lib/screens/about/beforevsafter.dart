import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
      before:
          'https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg',
      after:
          'https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg',
    ),
    ImagePair(
      before:
          'https://rfkicks.com/wp-content/uploads/2024/08/14e23d6237f7be41b044165aa78b5c18.jpeg',
      after:
          'https://rfkicks.com/wp-content/uploads/2024/06/0e1409954f44139dab295c7af08eb4be.jpeg',
    ),
    ImagePair(
      before:
          'https://rfkicks.com/wp-content/uploads/2024/08/be380a92f52107ef9405ceb3d623244b-1.jpeg',
      after:
          'https://rfkicks.com/wp-content/uploads/2024/08/d6fc6ffd15e9709c3263a08702f6b02b-1.jpeg',
    ),
    ImagePair(
      before:
          'https://rfkicks.com/wp-content/uploads/2024/08/dd50c8e77f3e3d3d0756a097b65953b5.jpeg',
      after: 'https://rfkicks.com/wp-content/uploads/2024/08/before.jpeg',
    ),
    ImagePair(
      before: 'https://rfkicks.com/wp-content/uploads/2024/08/after.jpeg',
      after:
          'https://rfkicks.com/wp-content/uploads/2024/08/851d27e601f12c3f43851b78020fb18b.jpeg',
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              children: [
                Text(
                  "Before vs After",
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Text(
                    "Our past services that we've completed for customers.\n"
                    "Yes, each shoe you see is the exact same shoe. No switcharoos, "
                    "no photoshopping, no editing!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Color(0xff767676),
                      fontFamily: 'Outfit-ExtraLight',
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.02,
              ),
              itemCount: _imagePairs.length,
              itemBuilder: (context, index) =>
                  _buildComparisonCard(index, screenWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(int index, double screenWidth) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade100],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              children: [
                BeforeAfter(
                  thumbColor: Color(0xff3c76ad),
                  trackColor: Color(0xff3c76ad),
                  overlayColor: WidgetStateProperty.all(Colors.black12),
                  direction: SliderDirection.horizontal,
                  value: _sliderValues[index],
                  before: _buildCachedImage(_imagePairs[index].before),
                  after: _buildCachedImage(_imagePairs[index].after),
                  onValueChanged: (value) =>
                      setState(() => _sliderValues[index] = value),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  "Slide to compare",
                  style: TextStyle(
                    color: _themeColor,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCachedImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildShimmerEffect(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: _themeColor, size: 40),
          SizedBox(height: 8),
          Text(
            'Image failed to load',
            style: TextStyle(color: _themeColor),
          ),
        ],
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
