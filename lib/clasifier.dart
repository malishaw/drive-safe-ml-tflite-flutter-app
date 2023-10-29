import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:rock_paper_scissors_mobile/classes.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  /// Instance of Interpreter
  late Interpreter _interpreter;
  late Interpreter _interpreterEyes;
  late Interpreter _interpreterYawn;
  late Interpreter _interpreterHands;
  late Interpreter _interpreterFace;

  static const String modelFile = "models/model_unquant.tflite";
  static const String modelFileYawn = "models/model_yawn.tflite";
  static const String modelFileEye = "models/model_eye.tflite";
  static const String modelFileHands = "models/model_hands.tflite";
  static const String modelFileFace = "models/model_face.tflite";



  /// Loads interpreter from asset
  Future<void> loadModel({Interpreter? interpreter}) async {
    try {

      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            modelFile,
            options: InterpreterOptions()..threads = 4,
          );

      _interpreter.allocateTensors();
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  /// Gets the interpreter instance
  Interpreter get interpreter => _interpreter;

  Future<DetectionClasses> predict(img.Image image) async {
    img.Image resizedImage = img.copyResize(image, width: 150, height: 150);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 150 * 150 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    final output = Float32List(1 * 8).reshape([1, 8]);

    // Reshape to input format specific for model. 1 item in list with pixels 150x150 and 3 layers for RGB
    final input = inputBytes.reshape([1, 150, 150, 3]);

    interpreter.run(input, output);

    final predictionResult = output[0] as List<double>;
    double maxElement = predictionResult.reduce(
      (double maxElement, double element) =>
          element > maxElement ? element : maxElement,
    );


    return DetectionClasses.values[predictionResult.indexOf(maxElement)];
  }

  // /// Loads interpreter from asset
  // Future<void> loadModel({Interpreter? interpreter}) async {
  //   try {
  //
  //     _interpreter = interpreter ??
  //         await Interpreter.fromAsset(
  //           modelFileEye,
  //           options: InterpreterOptions()..threads = 4,
  //         );
  //
  //     _interpreter.allocateTensors();
  //   } catch (e) {
  //     print("Error while creating interpreter: $e");
  //   }
  // }

  /// Gets the interpreter instance
  // Interpreter get interpretereyes => _interpreter;
  Interpreter get interpreterEyes => _interpreterEyes;
  Interpreter get interpreterYawn => _interpreterYawn;
  Interpreter get interpreterHands => _interpreterHands;
  Interpreter get interpreterFace => _interpreterFace;

  ///Predict Eyes open
  Future<EyesDetectionClasses> predictEyes(img.Image image) async {
    img.Image resizedImage = img.copyResize(image, width: 150, height: 150);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 150 * 150 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    final output = Float32List(1 * 2).reshape([1, 2]);

    // Reshape to input format specific for model. 1 item in list with pixels 150x150 and 3 layers for RGB
    final input = inputBytes.reshape([1, 150, 150, 3]);

    interpreterEyes.run(input, output);

    final predictionResult = output[0] as List<double>;
    double maxElement = predictionResult.reduce(
          (double maxElement, double element) =>
      element > maxElement ? element : maxElement,
    );


    return EyesDetectionClasses.values[predictionResult.indexOf(maxElement)];
  }

  /// Loads interpreter from asset
  Future<void> loadModelEyes({Interpreter? interpreter}) async {
    try {

      _interpreterEyes = interpreter ??
          await Interpreter.fromAsset(
            modelFileEye,
            options: InterpreterOptions()..threads = 4,
          );

      _interpreterEyes.allocateTensors();
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  ///Yawn Predict
  Future<YawnDetectionClasses> predictYawn(img.Image image) async {
    img.Image resizedImage = img.copyResize(image, width: 150, height: 150);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 150 * 150 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    final output = Float32List(1 * 2).reshape([1, 2]);

    // Reshape to input format specific for model. 1 item in list with pixels 150x150 and 3 layers for RGB
    final input = inputBytes.reshape([1, 150, 150, 3]);

    interpreterYawn.run(input, output);

    final predictionResult = output[0] as List<double>;
    double maxElement = predictionResult.reduce(
          (double maxElement, double element) =>
      element > maxElement ? element : maxElement,
    );


    return YawnDetectionClasses.values[predictionResult.indexOf(maxElement)];
  }

  /// Loads interpreter from asset
  Future<void> loadModelYawn({Interpreter? interpreter}) async {
    try {

      _interpreterYawn = interpreter ??
          await Interpreter.fromAsset(
            modelFileYawn,
            options: InterpreterOptions()..threads = 4,
          );

      _interpreterYawn.allocateTensors();
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }




///Hands Predict
  Future<HandsDetectionClasses> predictHands(img.Image image) async {
    img.Image resizedImage = img.copyResize(image, width: 150, height: 150);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 150 * 150 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    final output = Float32List(1 * 2).reshape([1, 2]);

    // Reshape to input format specific for model. 1 item in list with pixels 150x150 and 3 layers for RGB
    final input = inputBytes.reshape([1, 150, 150, 3]);

    interpreterHands.run(input, output);

    final predictionResult = output[0] as List<double>;
    double maxElement = predictionResult.reduce(
          (double maxElement, double element) =>
      element > maxElement ? element : maxElement,
    );


    return HandsDetectionClasses.values[predictionResult.indexOf(maxElement)];
  }

  /// Loads interpreter from asset
  Future<void> loadModelHands({Interpreter? interpreter}) async {
    try {

      _interpreterHands = interpreter ??
          await Interpreter.fromAsset(
            modelFileHands,
            options: InterpreterOptions()..threads = 4,
          );

      _interpreterHands.allocateTensors();
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }



  ///Face Position Predict
  Future<HandsDetectionClasses> predictFace(img.Image image) async {
    img.Image resizedImage = img.copyResize(image, width: 150, height: 150);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 150 * 150 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    final output = Float32List(1 * 2).reshape([1, 2]);

    // Reshape to input format specific for model. 1 item in list with pixels 150x150 and 3 layers for RGB
    final input = inputBytes.reshape([1, 150, 150, 3]);

    _interpreterFace.run(input, output);

    final predictionResult = output[0] as List<double>;
    double maxElement = predictionResult.reduce(
          (double maxElement, double element) =>
      element > maxElement ? element : maxElement,
    );


    return HandsDetectionClasses.values[predictionResult.indexOf(maxElement)];
  }

  /// Loads interpreter from asset
  Future<void> loadModelFace({Interpreter? interpreter}) async {
    try {

      _interpreterFace = interpreter ??
          await Interpreter.fromAsset(
            modelFileFace,
            options: InterpreterOptions()..threads = 4,
          );

      _interpreterFace.allocateTensors();
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }
}
