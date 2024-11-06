import 'package:flutter/material.dart';

class OrderRefundPolicy extends StatelessWidget {
  const OrderRefundPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Color(0xff3c76ad),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image.asset(
                "assets/images/rfk_preview.png",
                color: Color(0xff3c76ad),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(height: 20,),

              RichText(text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: '\nRefund and Order Policies at Refresh Kicks\n\n',
                    style: TextStyle(
                      color: Color(0xff3c76ad),
                      fontFamily: 'OC-Regular',
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const TextSpan(
                    text:
                    'At Refresh Kicks, all sales are FINAL and cannot be returned, credited, or refunded. We reserve the right to deny unreasonable repair requests or orders.\n\nWe’ve made every effort to accurately display our services, complete with before-and-after pictures. The colors of the products on our site are not altered in any way. However, please note that variations may occur due to differences in computer monitor displays.\n\nIf you encounter any issues with your order, such as tracking problems or shipping delays, feel free to reach out to us at orders@rfkicks.com. Be sure to include your order number in the subject line.\n\nThank you for choosing ',
                    style: TextStyle(
                      color: Color(0xff767676),
                      fontFamily: 'OC-Regular',
                    ),
                  ),
                  const TextSpan(
                    text: 'REFRESH KICKS!',
                    style: TextStyle(
                        color: Color(0xff3c76ad),
                        fontFamily: 'OC-Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
