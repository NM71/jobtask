import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageCarousel extends StatefulWidget {
  final List<String>? imageUrls; // Optional list of network image URLs
  final List<String>? assetImagePaths; // Optional list of local asset image paths

  ImageCarousel({this.imageUrls, this.assetImagePaths});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<File> _localImages = [];
  List<Widget> _carouselItems = [];

  @override
  void initState() {
    super.initState();
    _prepareCarouselItems();
  }

  Future<void> _prepareCarouselItems() async {
    // Download and cache network images if imageUrls is not null
    if (widget.imageUrls != null) {
      await _downloadAndCacheImages();
    }

    // Add local asset images if assetImagePaths is not null
    if (widget.assetImagePaths != null) {
      for (String assetPath in widget.assetImagePaths!) {
        _carouselItems.add(
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        );
      }
    }

    // Add cached network images if any
    for (File file in _localImages) {
      _carouselItems.add(
        Image.file(
          file,
          fit: BoxFit.cover,
        ),
      );
    }

    setState(() {});
  }

  Future<void> _downloadAndCacheImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<File> images = [];

    for (String url in widget.imageUrls!) {
      final filename = url.split('/').last;
      final file = File('${directory.path}/$filename');

      if (await file.exists()) {
        images.add(file);
      } else {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          images.add(file);
        }
      }
    }

    _localImages = images;
  }

  @override
  Widget build(BuildContext context) {
    return _carouselItems.isEmpty
        ? Center(child: CircularProgressIndicator())
        : CarouselSlider(
      items: _carouselItems,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height*0.35,
        autoPlay: true,
        clipBehavior: Clip.none,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
      ),
    );
  }
}
