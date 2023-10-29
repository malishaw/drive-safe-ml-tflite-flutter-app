import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/screens/aggreement_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/first_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/have_safe_ride_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/scanner_screen.dart';
import 'package:rock_paper_scissors_mobile/screens/startpage.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff152a42),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: const Text("Congratulations!!! \n \n You ended your ride safely",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32, color: Color(
                0xfffaffce)),),
          ),
          const SizedBox(height: 20,),
          Container(
            width: 200,
            height: 50,// Set width to full screen width
            margin: const EdgeInsets.all(40.0),
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => HaveSafeRideScreen()));
              },
              child: Text('Start Again', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),

          Container(
            width: 200,
            height: 50,// Set width to full screen width
            margin: const EdgeInsets.all(40.0),
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FirstScreen()));
              },
              child: Text('Exit', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
