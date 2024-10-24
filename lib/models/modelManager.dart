import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'Model.dart';
import 'server.dart';

class ModelManager {
  static final ModelManager _instance = ModelManager._internal();
  static Interpreter? _model;
  static ImageModel? _currentImageModel;

  factory ModelManager() {
    return _instance;
  }

  ModelManager._internal();

  static Future<void> saveInstance() async {

    try {
      await ServerManager.saveToMongoDB(
          getImage(),
          getModelOutput(),
          getModelConfidence()
      );
      print('Image and results successfully saved to the server.');
    } catch (e) {
      print('Error saving image and results to the server: $e');
    }

  }

  static Future<void> loadModel() async {
    if (_model == null) {
      try {
        final startTime = DateTime.now();
        _model = await Interpreter.fromAsset('assets/model.tflite');
        final loadTime = DateTime.now().difference(startTime);
        print('Model loaded in: ${loadTime.inMilliseconds} ms');
      } catch (e) {
        print('Failed to load model: $e');
      }
    } else {
      print('Model already loaded.');
    }

  }

  static Future<void> createImageModel(File imageFile) async {
    _currentImageModel = ImageModel(imageFile);
    print('ImageModel created.');
  }

  static Future<void> runImageModel() async {
    if (_currentImageModel == null) {
      print('No ImageModel has been set.');
      return;
    }
    await _currentImageModel!.runModel();
  }

  static double? getModelOutput() {
    if (_currentImageModel == null) {
      print('No ImageModel available.');
      return null;
    }
    return _currentImageModel!.output;
  }

  static int? getModelConfidence() {
    if (_currentImageModel == null) {
      print('No ImageModel available.');
      return null;
    }
    return _currentImageModel!.confidence;
  }

  static File getImage() {
    if (_currentImageModel == null) {
      throw Exception('No ImageModel available.');
    }
    return _currentImageModel!.image;
  }

  Interpreter? get model => _model;
}
