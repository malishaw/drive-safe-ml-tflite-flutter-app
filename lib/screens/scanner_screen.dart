import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_mobile/clasifier.dart';
import 'package:rock_paper_scissors_mobile/image_utils.dart';
import 'package:rock_paper_scissors_mobile/screens/final_screen.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import '../classes.dart';

class ScannerScreen extends StatefulWidget {

  bool isSleepDetecterActive = false;
  bool isYawnDetecterActive = false;
  bool isHeadPosDetecterActive = false;
  bool isHandsDetecterActive = false;
  ScannerScreen({
    required this.isSleepDetecterActive,
    required this.isYawnDetecterActive,
    required this.isHeadPosDetecterActive,
    required this.isHandsDetecterActive,
  });


  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController cameraController;
  late Interpreter interpreter;
  final classifier = Classifier();

  AudioPlayer audioPlayer = AudioPlayer();

  bool initialized = false;
  DetectionClasses detected = DetectionClasses.dnormal;
  DateTime lastShot = DateTime.now();
  late bool stop = false;
  bool isSwitched = false; // Initial state of the switch

  @override
  void initState() {
    super.initState();
    if(stop){
      cameraController.stopImageStream();
      cameraController.stopVideoRecording();
      audioPlayer.stop();
    }else{
      initialize();
    }
  }


  Future<void> initialize() async {
    await classifier.loadModel();
    final cameras = await availableCameras();
      stop = true;
    // Create a CameraController object
    cameraController = CameraController(
      cameras[1], // Choose the first camera in the list
      ResolutionPreset.medium, // Choose a resolution preset
    );
    // Initialize the CameraController and start the camera preview
    await cameraController.initialize();
    // Listen for image frames
    await cameraController.startImageStream((image) {
      // Make predictions every 1 second to avoid overloading the device
      if (DateTime.now().difference(lastShot).inSeconds > 4) {
        processCameraImage(image);
      }
    });
    setState(() {
      initialized = true;
    });
  }

  Future<void> processCameraImage(CameraImage cameraImage) async {
    await classifier.loadModel();
    final convertedImage = ImageUtils.convertYUV420ToImage(cameraImage);


    var result = await classifier.predict(convertedImage);
    print("result: $result");

    setState(() {
      detected = result;

      // if(isSwitched){
      //   detected = DetectionClasses.dnormal;
      // }


      if(detected.label=="Sleeping" && widget.isSleepDetecterActive){
        playBeepSound();
      } else if(detected.label=="Yawning" && widget.isYawnDetecterActive){
        playBeepSound();
      }else if(detected.label=="Head Down" && widget.isHeadPosDetecterActive){
        playBeepSound();
      }else if(detected.label=="Hands Up" && widget.isHeadPosDetecterActive){
        playBeepSound();
      }else if(detected.label=="Head Right" && widget.isHandsDetecterActive){
        playBeepSound();
      }else if(detected.label=="Head Left" && widget.isHeadPosDetecterActive){
        playBeepSound();
      } else if(detected.label=="Head Up" && widget.isHeadPosDetecterActive){
        playBeepSound();
    }});
    lastShot = DateTime.now();
  }

  Future<void> playBeepSound() async {
    print("play sound");
    final player = AudioPlayer();

    player.play(AssetSource('alarm.wav'));
    setState(() {
      detected.label == "Normal";
    });
    player.stop();
  }

  void stopCameraAndSound() {

  }


  // void _showSnackBar(BuildContext context) {
  //   final snackBar = SnackBar(
  //       backgroundColor : isSwitched? Colors.green : Colors.red,
  //     content: isSwitched ? const Text('Head Position Checking is Enabled') :  const Text('Head Position Checking is Disabled'),
  //     action: SnackBarAction(
  //       label: 'Close',
  //       onPressed: () {
  //         // Code to execute when the user taps the "Close" action.
  //         // Typically used to dismiss the SnackBar.
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       },
  //     ),
  //   );
  //   // Show the SnackBar using the ScaffoldMessenger.
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  detected.label == "Normal" ? Colors.green :
      detected.label=="Head Down" && !widget.isHeadPosDetecterActive? Colors.green :
      detected.label=="Head Up" && !widget.isHeadPosDetecterActive? Colors.green :
      detected.label=="Head Left" && !widget.isHeadPosDetecterActive? Colors.green :
      detected.label=="Sleeping" && !widget.isSleepDetecterActive? Colors.green :
      detected.label=="Hands Up" && !widget.isHandsDetecterActive? Colors.green :
      detected.label=="Yawning" && !widget.isYawnDetecterActive? Colors.green :
      detected.label=="Head Right" && !!widget.isHeadPosDetecterActive? Colors.green : Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Drive Safe'),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FinalScreen()));
              cameraController.stopImageStream();

            },
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              margin: EdgeInsets.all(8),
              color: Colors.red,
              child: const Text("Stop", style: TextStyle(color: Colors.white),),
            ),
          ),

          // Switch(
          //   value: isSwitched,
          //   onChanged: (value) {
          //     setState(() {
          //
          //       isSwitched = value;
          //       detected.label == "Normal";
          //       // Update the state when the switch is toggled
          //     }
          //
          //     );
          //     _showSnackBar(context);
          //   },
          // ),
        ],
      ),
      body: initialized
          ? Center(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      width: MediaQuery.of(context).size.width - 10,
                      child: CameraPreview(cameraController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Result ${
                            detected.label=="Head Down" && !widget.isHeadPosDetecterActive? "Normal" :
                            detected.label=="Head Up" && !widget.isHeadPosDetecterActive? "Normal" :
                            detected.label=="Sleeping" && !widget.isSleepDetecterActive? "Normal" :
                            detected.label=="Hands Up" && !widget.isHandsDetecterActive? "Normal" :
                            detected.label=="Yawning" && !widget.isYawnDetecterActive? "Normal" :
                            detected.label=="Head Left" && !widget.isHeadPosDetecterActive? "Normal" :
                            detected.label=="Head Right" && !widget.isHeadPosDetecterActive? "Normal" : detected.label
                            }",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: detected.label != "Normal" ? FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed:(){
          cameraController.stopImageStream();
          audioPlayer.stop();
          setState(() {
            stop = false;
            detected = DetectionClasses.dnormal;
          });
        },
         // stopCameraAndSound,
        child: const Icon(Icons.refresh)
      ): Container(),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}


//
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:rock_paper_scissors_mobile/clasifier.dart';
// import 'package:rock_paper_scissors_mobile/image_utils.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// import '../classes.dart';
//
// class ScannerScreen extends StatefulWidget {
//   @override
//   _ScannerScreenState createState() => _ScannerScreenState();
// }
//
// class _ScannerScreenState extends State<ScannerScreen> {
//   late CameraController cameraController;
//   late Interpreter interpreter;
//   final classifier = Classifier();
//   final classifierEyes = Classifier();
//   final classifierYawn = Classifier();
//   final classifierHands = Classifier();
//   final classifierFace = Classifier();
//
//   AudioPlayer audioPlayer = AudioPlayer();
//
//   bool initialized = false;
//   DetectionClasses detected = DetectionClasses.dsleep;
//   EyesDetectionClasses detectedClosedEye = EyesDetectionClasses.closed_eye;
//   YawnDetectionClasses detectedYawning = YawnDetectionClasses.yawn;
//   HandsDetectionClasses detectedNoHands = HandsDetectionClasses.no_hands;
//   FaceDetectionClasses detectedNoFace = FaceDetectionClasses.no_face;
//   DateTime lastShot = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//     initialize();
//   }
//
//   Future<void> initialize() async {
//     // await classifierEyes.loadModelEyes();
//     // await classifierYawn.loadModelYawn();
//     // await classifierHands.loadModelHands();
//     // await classifierFace.loadModelFace();
//     await classifier.loadModel();
//
//     final cameras = await availableCameras();
//     // Create a CameraController object
//     cameraController = CameraController(
//       cameras[1], // Choose the first camera in the list
//       ResolutionPreset.medium, // Choose a resolution preset
//     );
//
//     // Initialize the CameraController and start the camera preview
//     await cameraController.initialize();
//     // Listen for image frames
//     await cameraController.startImageStream((image) {
//       // Make predictions every 1 second to avoid overloading the device
//       if (DateTime.now().difference(lastShot).inSeconds > 1) {
//         processCameraImage(image);
//       }
//     });
//
//     setState(() {
//       initialized = true;
//     });
//   }
//
//   Future<void> processCameraImage(CameraImage cameraImage) async {
//     await classifier.loadModel();
//     // await classifierEyes.loadModelEyes();
//     // await classifierYawn.loadModelYawn();
//     // await classifierHands.loadModelHands();
//     // await classifierFace.loadModelFace();
//     final convertedImage = ImageUtils.convertYUV420ToImage(cameraImage);
//
//     var result = await classifier.predict(convertedImage);
//     // final resultEye = await classifierEyes.predictEyes(convertedImage);
//     // final resultYawn = await classifierYawn.predictYawn(convertedImage);
//     // final resultHands = await classifierHands.predictHands(convertedImage);
//     // final resultFace = await classifierFace.predictFace(convertedImage);
//     // print("resultEye: $resultEye");
//     // print("resultYawn: $resultYawn");
//     // print("resultHands: $resultHands");
//     // print("resultFace: $resultFace");
//
//
//
//     print("result: $result");
//
//     Duration delayDuration = Duration(seconds: 3);
//
//     setState(() {
//
//       var previousResult = result;
//
//       Future.delayed(delayDuration, () {
//         if (result == previousResult ) {
//           detected = result;
//         }
//       });
//
//       detected = result;
//     });
//     // if (detectedClosedEye != resultEye) {
//     //   setState((){
//     //     detectedClosedEye = resultEye;
//     //
//     //     if(detectedClosedEye.label=="Closed Eyes"){
//     //       playBeepSound();
//     //     }
//     //
//     //     if(detectedYawning.label == "Yawning"){
//     //       playBeepSound();
//     //     }
//     //
//     //     if(detectedNoHands.label == "No Hands"){
//     //       playBeepSound();
//     //     }
//     //
//     //   });
//     // }
//
//     lastShot = DateTime.now();
//   }
//
//   Future<void> playBeepSound() async {
//     final player = AudioPlayer();
//     player.play(AssetSource('beep-05.wav'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//       // detected.label == "" ? Colors.red : Colors.green,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         title: const Text('Drive Safe'),
//       ),
//       body: initialized
//           ? Center(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height - 150,
//                 width: MediaQuery.of(context).size.width - 10,
//                 child: CameraPreview(cameraController),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(
//                 child: Text(
//                   "Result ${detected.label}",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   @override
//   void dispose() {
//     cameraController.dispose();
//     super.dispose();
//   }
// }

