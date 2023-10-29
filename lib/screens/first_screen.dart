import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/screens/aggreement_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff152a42),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          Text("Safe Ride",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32, color: Color(
              0xfffaffce)),),
          SizedBox(height: 20,),
          Container(
            width: 200,
            height: 50,// Set width to full screen width
            margin: EdgeInsets.all(40.0),
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AggreementScreen()));
              },
              child: Text('Get Start', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }
}
