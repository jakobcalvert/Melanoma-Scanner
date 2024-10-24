import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../views/results_view.dart';
import '../views/instructions_view.dart';
import '../views/confirmation_view.dart';
import '../views/results_list_view.dart';
import '../models/modelManager.dart';
import '../models/server.dart';
import '/views/home_view.dart';

class ServerController {

  Future<void> saveResultsToServer() async {
    ModelManager.saveInstance();
  }

  Future<List<Map<String, dynamic>>> retrieveResultsFromServer() async {
    try {
      List<Map<String, dynamic>> results = await ServerManager
          .retrieveFromMongoDB();
      print(
          'Successfully retrieved ${results.length} results from the server.');
      return results;
    } catch (e) {
      print('Error retrieving results from the server: $e');
      return [];
    }
  }

  bool serverStatus() {
    return ServerManager.isConnected();
  }

  Future<void> saveResults(BuildContext context) async {
    await saveResultsToServer();
    viewSavedResults(context);
  }
  Future<void> viewSavedResults(BuildContext context) async {
    final startTime = DateTime.now();

    List<Map<String, dynamic>> savedResults = await retrieveResultsFromServer();
    List<File> images = [];
    List<Color> colors = [];
    List<String> messages = [];

    for (var result in savedResults) {
      File imageFile = result['image'];
      images.add(imageFile);
      int confidence = result['confidence'];
      if (confidence == 2) {
        colors.add(Colors.red);
        messages.add('High likelihood of melanoma. Consult a healthcare professional.');
      } else if (confidence == 1) {
        colors.add(Colors.orange);
        messages.add('Medium likelihood. Further testing is recommended.');
      } else if (confidence == 0) {
        colors.add(Colors.green);
        messages.add('Low likelihood of melanoma.');
      } else {
        colors.add(Colors.grey);
        messages.add('Unknown');
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsListView(
          images: images.map((image) => image.readAsBytesSync()).toList(),
          colors: colors,
          messages: messages,
        ),
      ),
    );
    final runTime = DateTime.now().difference(startTime);
    print('Retrieved results in: ${runTime.inMilliseconds} ms');
  }
}