import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Reviews'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Reviews",
              style: TextStyle(fontSize: 28),
            ),
            Text(
              "20 Reviews",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "4.87 Stars",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "★ ★ ★ ★ ★",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),

            // sample review 1
            SizedBox(
              height: 40,
            ),
            Text(
              "Ahmad Ali.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "★ ★ ★ ★ ★",
              style: TextStyle(fontSize: 15, color: Color(0xff3c76ad)),
            ),
            Text(
              "Every time I put on a pair friends think they're brand new lol. I tell them about Refresh Kicks and that they're responsible for keeping my kicks looking super fresh.",
              style: TextStyle(fontSize: 15,),
            ),


            // sample review 2
            SizedBox(
              height: 40,
            ),
            Text(
              "John Doe.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "★ ★ ★ ★ ★",
              style: TextStyle(fontSize: 15, color: Color(0xff3c76ad)),
            ),
            Text(
              "I had no place to take my designer shoes to get cleaned and touched up until I found Refresh Kicks. I was referred to them by my coworkers and I couldn't been happier. What's a couple bucks to make a pair of shoes you spent a couple hundred dollars on to make them look brand new again?!",
              style: TextStyle(fontSize: 15,),
            ),
          ],
        ),
      ),
    );
  }
}
