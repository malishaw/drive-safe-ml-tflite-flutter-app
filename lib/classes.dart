
// 0 isyawning
// 1 areeyesclosed
// 2 isfacefront
// 3 arehands


// enum DetectionClasses { isyawning, areeyesclosed, isfacefront, arehands }
//
// extension DetectionClassesExtension on DetectionClasses {
//   String get label {
//     switch (this) {
//
//       case DetectionClasses.isyawning:
//         return "Yawning";
//       case DetectionClasses.areeyesclosed:
//         return "Sleeping";
//       case DetectionClasses.isfacefront:
//         return "Face Detected";
//       case DetectionClasses.arehands:
//         return "Hands Detected";
//     }
//   }
// }




enum DetectionClasses { dhandsup, dsleep, dyawn, dheadup, dheadleft,dheadright, headdown, dnormal }

extension DetectionClassesExtension on DetectionClasses {
  String get label {
    switch (this) {
      case DetectionClasses.dhandsup:
        return "Hands Up";
      case DetectionClasses.dsleep:
        return "Sleeping";
      case DetectionClasses.dyawn:
        return "Yawning";
      case DetectionClasses.dheadup:
        return "Head Up";

      case DetectionClasses.dheadleft:
        return "Head Left";

      case DetectionClasses.dheadright:
        return "Head Right";
      case DetectionClasses.headdown:
        return "Head Down";

      case DetectionClasses.dnormal:
        return "Normal";
    }
  }
}

enum YawnDetectionClasses { yawn, no_yawn,  }

extension YawnDetectionClassesExtension on YawnDetectionClasses {
  String get label {
    switch (this) {

      case YawnDetectionClasses.yawn:
        return "Yawning";
      case YawnDetectionClasses.no_yawn:
        return "Good";
    }
  }
}

enum EyesDetectionClasses { open_eye, closed_eye,  }

extension EyesDetectionClassesExtension on EyesDetectionClasses {
String get label {
switch (this) {

case EyesDetectionClasses.closed_eye:
return "Closed Eyes";
case EyesDetectionClasses.open_eye:
return "Opened Eyes";
}
}
}

enum HandsDetectionClasses { hands, no_hands,  }

extension HandsDetectionClassesExtension on HandsDetectionClasses {
  String get label {
    switch (this) {
      case HandsDetectionClasses.no_hands:
        return "No Hands";
      case HandsDetectionClasses.hands:
        return "Hands";
    }
  }
}
  ///face
  enum FaceDetectionClasses { face, no_face,  }

extension FaceDetectionClassesExtension on FaceDetectionClasses {
  String get label {
    switch (this) {

      case FaceDetectionClasses.no_face:
        return "No Face";
      case FaceDetectionClasses.face:
        return "Face";
    }
  }
}

