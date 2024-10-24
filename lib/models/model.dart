import 'dart:io';
import 'package:image/image.dart' as img;
import 'modelManager.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageModel {
  final double lower = 0.2;
  final double upper = 0.8;
  final File image;
  double? output;
  int? confidence;

  ImageModel(this.image);

  List<List<List<List<double>>>> preprocessImage(File imageFile) {
    final rawImage = imageFile.readAsBytesSync();
    img.Image? image = img.decodeImage(rawImage);
    if (image == null) {
      throw Exception('Error decoding image');
    }
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224, interpolation: img.Interpolation.linear);
    List<List<List<List<double>>>> inputImage = List.generate(
      1,
          (batch) => List.generate(
        224,
            (x) => List.generate(
          224,
              (y) {
            final pixel = resizedImage.getPixel(x, y);
            final red = img.getRed(pixel) / 255.0;
            final green = img.getGreen(pixel) / 255.0;
            final blue = img.getBlue(pixel) / 255.0;
            return [red, green, blue];
          },
        ),
      ),
    );
    return inputImage;
  }

  Future<void> runModel() async {
    Interpreter? model = ModelManager().model;
    if (model == null) {
      print("Model is not loaded yet.");
      return;
    }
    final startTime = DateTime.now();
    var input = preprocessImage(image);
    var outputBuffer = List.generate(1, (i) => List.filled(1, 0.0));
    model.run(input, outputBuffer);
    final runTime = DateTime.now().difference(startTime);
    print('Model run in: ${runTime.inMilliseconds} ms');
    double probability = outputBuffer[0][0];
    this.output = probability;
    if (probability <= lower) {
      confidence = 0;
    } else if (probability > lower && probability <= upper) {
      confidence = 1;
    } else if (probability > upper) {
      confidence = 2;
    }
    print("output: $output");
    print("risk grade: $confidence");
  }
}
