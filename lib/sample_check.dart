// import 'package:before_after/before_after.dart';
// import 'package:flutter/material.dart';
//
// class SampleCheck extends StatefulWidget {
//   const SampleCheck({super.key});
//
//   @override
//   State<SampleCheck> createState() => _SampleCheckState();
// }
//
// class _SampleCheckState extends State<SampleCheck> {
//   double _value1 = 0.5;
//   double _value2 = 0.5;
//   double _value3 = 0.5;
//   double _value4 = 0.5;
//   double _value5 = 0.5;
//   double _value6 = 0.5;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Before vs After section
//               Text("Before vs After", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
//               Text("\nOur past services that we’ve completed for customers.\n\nYes, each shoe you see is the exact same shoe. No switcharoos, no photoshopping , no editing!"),
//               SizedBox(height: 20,),
//
//               // Containers
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value1,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value1 = newValue;
//                     });
//                   },
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value2,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/14e23d6237f7be41b044165aa78b5c18.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/06/0e1409954f44139dab295c7af08eb4be.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value2 = newValue;
//                     });
//                   },
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value3,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/be380a92f52107ef9405ceb3d623244b-1.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/d6fc6ffd15e9709c3263a08702f6b02b-1.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value3 = newValue;
//                     });
//                   },
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value4,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/dd50c8e77f3e3d3d0756a097b65953b5.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/before.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value4 = newValue;
//                     });
//                   },
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value5,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/after.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/851d27e601f12c3f43851b78020fb18b.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value5 = newValue;
//                     });
//                   },
//                 ),
//               ),
//
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: BeforeAfter(
//                   thumbColor: Color(0xff3c76ad),
//                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
//                   value: _value6,
//                   before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/a.jpeg'),
//                   after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/b.jpeg'),
//                   onValueChanged: (newValue) {
//                     setState(() {
//                       _value6 = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// //
// // class SampleCheck extends StatelessWidget {
// //   const SampleCheck({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Lottie.network('https://lottiefiles.com/free-animation/cart-checkout-fast-gHqTaBD6Mo'),
// //       ),
// //     );
// //   }
// // }
//
//
//
// // using cached network image
//
// // import 'package:before_after/before_after.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// //
// // class SampleCheck extends StatefulWidget {
// //   const SampleCheck({super.key});
// //
// //   @override
// //   State<SampleCheck> createState() => _SampleCheckState();
// // }
// //
// // class _SampleCheckState extends State<SampleCheck> {
// //   double _value1 = 0.5;
// //   double _value2 = 0.5;
// //   double _value3 = 0.5;
// //   double _value4 = 0.5;
// //   double _value5 = 0.5;
// //   double _value6 = 0.5;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         body: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               // Before vs After section
// //               Text("Before vs After", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
// //               Text("\nOur past services that we’ve completed for customers.\n\nYes, each shoe you see is the exact same shoe. No switcharoos, no photoshopping , no editing!"),
// //               SizedBox(height: 20,),
// //
// //               // Containers
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value1,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg',
// //                   ),
// //
// //                   // before: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/da8d6cffe369c1546147c5e8dae78b29.jpeg'),
// //                   // after: Image.network('https://rfkicks.com/wp-content/uploads/2024/08/ba6980d2fe6a9d9f89a8d36400d5b3cf.jpeg'),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value1 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value2,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/14e23d6237f7be41b044165aa78b5c18.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/06/0e1409954f44139dab295c7af08eb4be.jpeg',
// //                   ),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value2 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value3,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/be380a92f52107ef9405ceb3d623244b-1.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/d6fc6ffd15e9709c3263a08702f6b02b-1.jpeg',
// //                   ),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value3 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value4,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/dd50c8e77f3e3d3d0756a097b65953b5.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/before.jpeg',
// //                   ),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value4 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value5,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/after.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/851d27e601f12c3f43851b78020fb18b.jpeg',
// //                   ),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value5 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //
// //               Container(
// //                 padding: EdgeInsets.all(25),
// //                 child: BeforeAfter(
// //                   thumbColor: Color(0xff3c76ad),
// //                   overlayColor: WidgetStatePropertyAll(Color(0xff3c76ad)),
// //                   value: _value6,
// //                   before: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/a.jpeg',
// //                   ),
// //                   after: CachedNetworkImage(
// //                     imageUrl: 'https://rfkicks.com/wp-content/uploads/2024/08/b.jpeg',
// //                   ),
// //                   onValueChanged: (newValue) {
// //                     setState(() {
// //                       _value6 = newValue;
// //                     });
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//











import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}
class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://rfkicks.com/'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TextConstants.appBarTitle"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}