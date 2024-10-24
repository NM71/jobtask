import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/screens/auth/sign_in_screen.dart';
import 'package:jobtask/startup_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String token;

  const DashboardScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        actions: [
          GestureDetector(
            // onTap: () {
            //   Navigator.pop(context);
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => StartupScreen()));
            // },
            onTap: () async {
              final storage = FlutterSecureStorage();
              await storage.delete(key: 'auth_token'); // Clear the stored token
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => StartupScreen()),
                    (route) => false,
              );
            },

            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/rfk_preview.png', height: 200, width: 200,),
            SizedBox(height: 20,),
            RichText(
                  text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Welcome to\n\n',
                style: TextStyle(
                  color: Color(0xff767676),
                  fontSize: 20,
                  fontFamily: 'OC-Regular',
                ),
              ),
              TextSpan(
                text: 'RefreshKicks.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Color(0xffffffff),
                  fontFamily: 'OC-Regular',
                ),
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





