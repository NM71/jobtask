import 'package:flutter/material.dart';
import 'package:jobtask/utils/expandable_card.dart';

class FAQS extends StatelessWidget {
  const FAQS({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/rfk_preview.png",
                color: Color(0xff3c76ad),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: const TextSpan(
                  text: '\nFrequently Asked Questions\n',
                  style: TextStyle(
                      color: Color(0xff3c76ad),
                      fontFamily: 'OC-Regular',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ReusableExpandableCard(
                  title: "How does it work? ",
                  content:
                      "Our process is very simple. First, you order a service of your choice. The next step is to box up your shoes along with our prepaid shipping label (yes, it’s on us!) and ship them off to us. Once we receive your order, you can now sit back and relax and let us go to work. Upon completion, you will receive an email notifying you that your order is completed and being shipped back to your doorstep (don’t worry we’ll cover the shipping as well)."),
              SizedBox(
                height: 10,
              ),


              ReusableExpandableCard(
                  title: "How long does each restoration or cleaning take?",
                  content:
                  "On average, a cleaning may take up to two to three business days to be completed. For more intricate services such as re-glues, re-dyes, re-paints, and sole swaps may take a minimum of a week (in most cases, these services are completed sooner). Please remember these processes can be complex and we want pure perfection."),
              SizedBox(
                height: 10,
              ),

              ReusableExpandableCard(
                  title: "Are the material used on my shoes safe?",
                  content:
                  "Yes, of course! We proudly utilize eco-friendly products, championing sustainability while enhancing the confidence of footwear enthusiasts with love and care."),
              SizedBox(
                height: 10,
              ),

              ReusableExpandableCard(
                  title: "Do you provide shoe repair services? ",
                  content:
                  "Yes, in addition to our cleaning services, we provide expert sneaker repair options. These include regluing, patching holes (for shoes made from canvas or flyknit material), and professional repainting. "),
              SizedBox(
                height: 10,
              ),

              ReusableExpandableCard(
                  title: "What type of shoes do you clean? ",
                  content:
                  "We clean a wide variety of shoes, including sneakers, dress shoes, boots, and athletic shoes. Our specialized cleaning techniques ensure that your shoes receive the best care, regardless of their material or style."),
              SizedBox(
                height: 10,
              ),

              ReusableExpandableCard(
                  title: "How much does Refresh Kicks services costs? ",
                  content:
                  "We offer four different price tiers along with additional services that may be needed which are listed our services. You may choose your desired option at checkout."),
              SizedBox(
                height: 10,
              ),

              ReusableExpandableCard(
                  title: "How do I order a RFK service? ",
                  content:
                  "Currently, there are TWO ways that can be possible. You may order via our website www.Rfkicks.com or through our RFK App. Once you’re logged into either or you may carefully browse which services best fit your needs and order. After that, let us take it from there. We will be offering in person drop offs momentarily."),
              SizedBox(
                height: 10,
              ),
              RichText(text: const TextSpan(
                text:
                '\nStill you have any questions? Please contact our team at info@rfkicks.com\n\n',
                style: TextStyle(
                  color: Color(0xff767676),
                  fontFamily: 'OC-Regular',
                ),
              ),)

            ],
          ),
        ),
      ),
    ));
  }
}
