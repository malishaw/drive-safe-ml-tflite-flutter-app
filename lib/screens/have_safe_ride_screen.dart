import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/screens/scanner_screen.dart';

class HaveSafeRideScreen extends StatefulWidget {
  const HaveSafeRideScreen({Key? key}) : super(key: key);

  @override
  State<HaveSafeRideScreen> createState() => _HaveSafeRideScreenState();
}

class _HaveSafeRideScreenState extends State<HaveSafeRideScreen> {

   bool _isSleepDetect= false;
   bool _isYawnDetect= false;
   bool _isHandsDetect= false;
   bool _isHeadDetect= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const  Color(0xff293242),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity,),
          Container(
            width: 250,
            height: 60,// Set width to full screen width
            margin: const EdgeInsets.all(10.0),
            child: ElevatedButton(   // <-- ElevatedButton
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xA59DCBFF),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ScannerScreen(
                     isSleepDetecterActive : _isSleepDetect,
                     isYawnDetecterActive : _isYawnDetect,
                     isHeadPosDetecterActive : _isHeadDetect,
                     isHandsDetecterActive : _isHandsDetect,
                )));
              },
              child: const Text('Have a Safe Ride', style: TextStyle(color: Colors.black, fontSize: 18),),
            ),
          ),


          const  SizedBox(
            height: 20,
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value:_isSleepDetect ,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isSleepDetect = newValue!;
                    print(_isSleepDetect);
                  });
                },
                activeColor: Colors.green, // Border color
                visualDensity:const  VisualDensity(horizontal: 2, vertical: 2), // Increase size
                side:const  BorderSide(width: 2, color: Colors.green), // Border thickness
                checkColor: Colors.green, // Checkmark color
                fillColor: MaterialStateProperty.all(Colors.white), // Background color
              ),
              const SizedBox(width: 20,),
              const Text('Sleep Detection',style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          ),
            const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Checkbox(
                  value:_isYawnDetect ,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isYawnDetect = newValue!;
                      print(_isYawnDetect);
                    });
                  },
                  activeColor: Colors.green, // Border color
                  visualDensity: VisualDensity(horizontal: 2, vertical: 2), // Increase size
                  side: BorderSide(width: 2, color: Colors.green), // Border thickness
                  checkColor: Colors.green, // Checkmark color
                  fillColor: MaterialStateProperty.all(Colors.white), // Background color
                ),
              const    SizedBox(width: 20,),
              const    Text('Yawn Detection',style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          ),
            const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value:_isHandsDetect ,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isHandsDetect = newValue!;
                    print(_isHandsDetect);
                  });
                },
                activeColor: Colors.green, // Border color
                visualDensity: const VisualDensity(horizontal: 2, vertical: 2), // Increase size
                side: const BorderSide(width: 2, color: Colors.green), // Border thickness
                checkColor: Colors.green, // Checkmark color
                fillColor: MaterialStateProperty.all(Colors.white), // Background color
              ),
              const  SizedBox(width: 20,),
              const   Text('Hands Detection',style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value:_isHeadDetect ,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isHeadDetect = newValue!;
                    print(_isHeadDetect);
                  });
                },
                activeColor: Colors.green, // Border color
                visualDensity: const VisualDensity(horizontal: 2, vertical: 2), // Increase size
                side: const BorderSide(width: 2, color: Colors.green), // Border thickness
                checkColor: Colors.green, // Checkmark color
                fillColor: MaterialStateProperty.all(Colors.white), // Background color
              ),
              const SizedBox(width: 20,),
              const Text('Head Pose Detection',style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          )
        ],),)
        ],
      ),
    );
  }
}
