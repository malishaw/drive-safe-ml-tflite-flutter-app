import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/screens/have_safe_ride_screen.dart';

class AggreementScreen extends StatelessWidget {
  const AggreementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233756),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const   Text("Safe Ride",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32, color: Color(
              0xfffaffce)),),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(10),
            color: Color(0xffe0d9b5),
            child: const Text(
                'The mobile application made to avoid vehicle Accidents due to Driver drowsiness and dstraction. \n\nYou can experience a safe ride by using this application. \n\nHere we are capturing your eye, hands, face and head positions. \n\nIf you are interested please click agree annd enjoy a safe ride'),
          ),

          Container(
            width: 200,
            height: 50,// Set width to full screen width
            margin: EdgeInsets.all(15.0),
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => HaveSafeRideScreen()));
              },
              child: Text('Agree', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),

          Container(
            width: 200,
            height: 50,// Set width to ful
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop();
              },
              child: Text('Back', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
