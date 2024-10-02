// lib/screens/email_input_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobtask/screens/code_verification_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailInputScreen extends StatefulWidget {
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/header2-2-1.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter your email to join us or sign in.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),

            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'By continuing, I agree to RFK\'s \n',
                      style: TextStyle(color: Color(0xff767676),
                        fontFamily: 'OC-Regular',)),
                  TextSpan(
                      text: 'Privacy Policy ',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                          fontSize: 16)),
                  TextSpan(text: ' and ', style: TextStyle(color: Color(0xff767676), fontFamily: 'OC-Regular')),
                  TextSpan(text: 'Terms of Use. ',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff767676),
                        fontFamily: 'OC-Regular',
                        fontSize: 16)),
                ],
              ),
            ),


            // RichText with webview Functionality
        // RichText(
        //   text: TextSpan(
        //     children: <TextSpan>[
        //       const TextSpan(
        //         text: 'By continuing, I agree to RFK\'s \n',
        //         style: TextStyle(
        //           color: Color(0xff767676),
        //           fontFamily: 'OC-Regular',
        //         ),
        //       ),
        //       TextSpan(
        //         text: 'Privacy Policy ',
        //         style: const TextStyle(
        //           decoration: TextDecoration.underline,
        //           color: Color(0xff767676),
        //           fontFamily: 'OC-Regular',
        //           fontSize: 16,
        //         ),
        //         recognizer: TapGestureRecognizer()
        //           ..onTap = () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => WebViewScreen(
        //                   url: 'https://kicks-eg.com/privacy-policy/',
        //                 ),
        //               ),
        //             );
        //           },
        //       ),
        //       const TextSpan(
        //         text: ' and ',
        //         style: TextStyle(
        //           color: Color(0xff767676),
        //           fontFamily: 'OC-Regular',
        //         ),
        //       ),
        //       const TextSpan(
        //         text: 'Terms of Use. ',
        //         style: TextStyle(
        //           decoration: TextDecoration.underline,
        //           color: Color(0xff767676),
        //           fontFamily: 'OC-Regular',
        //           fontSize: 16,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),



            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(26),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xff3c76ad),
                foregroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                if (await ApiService.submitEmail(_emailController.text)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CodeVerificationScreen(email: _emailController.text),
                    ),
                  );
                } else {}
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}




// class WebViewScreen extends StatelessWidget {
//   final String url;
//
//   WebViewScreen({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Privacy Policy'),
//         centerTitle: true,
//       ),
//       // body: WebView(
//       //   initialUrl: url,
//       //   javascriptMode: JavascriptMode.unrestricted,
//       // ),
//       body: WebViewWidget(
//         controller: WebViewController()
//           ..setJavaScriptMode(JavaScriptMode.unrestricted)
//           ..loadRequest(Uri.parse(url)),
//       ),
//     );
//   }
// }