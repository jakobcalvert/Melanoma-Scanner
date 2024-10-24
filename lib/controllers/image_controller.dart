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

class ImageController {
  void handleImageSelection(ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      await ModelManager.createImageModel(image);
      print('Image selected: ${ModelManager.getImage()}');
      if (_getImage() != null) {
        showConfirmationScreen(context);
      } else {
        print('Image not found in ModelManager');
      }
    } else {
      print('No image selected.');
    }
  }

  Future<int?> getConfidence() async {
    await ModelManager.loadModel();
    await ModelManager.runImageModel();
    return ModelManager.getModelConfidence();
  }

  File _getImage() {
    return ModelManager.getImage();
  }

  Future<void> returnHome(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(controller: this),
      ),
    );
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
          controller: this,
          images: images.map((image) => image.readAsBytesSync()).toList(),
          colors: colors,
          messages: messages,
        ),
      ),
    );
    final runTime = DateTime.now().difference(startTime);
    print('Retrieved results in: ${runTime.inMilliseconds} ms');
  }

  Future<void> saveResults(BuildContext context) async {
    await saveResultsToServer();
    viewSavedResults(context);
  }

  void cancel(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> confirmImage(BuildContext context) async {
    int? confidence = await getConfidence();
    String confidenceMessage = 'Error';
    Color confidenceColor = Colors.grey;

    if (confidence == 2) {
      confidenceMessage = 'This spot has been flagged a high risk and there is a high chance that this spot could be melanoma for further checks please contact your local GP or contact Melanoma NZ info@melanoma.org.nz or 09 449 2342';
      confidenceColor = Colors.red;
    } else if (confidence == 1) {
      confidenceMessage = 'This spot has been flagged a medium risk and there is a chance that this spot could be melanoma for further checks please contact your local GP or contact Melanoma NZ info@melanoma.org.nz or 09 449 2342';
      confidenceColor = Colors.orange;
    } else if (confidence == 0) {
      confidenceMessage = 'This spot has been flagged a low risk if still suspicious for further checks please contact your local GP or contact Melanoma NZ info@melanoma.org.nz or 09 449 2342';
      confidenceColor = Colors.green;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsView(controller: this, message: confidenceMessage, mesColor: confidenceColor, image: _getImage()),
      ),
    );
  }

  void imagePicker(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePickerView(controller: this),
      ),
    );
  }

  /*
  void showImagePickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageMethod(controller: this);
      },
    );
  }
 */

  void showConfirmationScreen(BuildContext context) {
    if (_getImage() != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationView(controller: this, image: _getImage()),
        ),
      );
    }
  }

  Future<void> saveResultsToServer() async {
    ModelManager.saveInstance();
  }

  Future<List<Map<String, dynamic>>> retrieveResultsFromServer() async {
    try {
      List<Map<String, dynamic>> results = await ServerManager.retrieveFromMongoDB();
      print('Successfully retrieved ${results.length} results from the server.');
      return results;
    } catch (e) {
      print('Error retrieving results from the server: $e');
      return [];
    }
  }

  bool serverStatus(){
    return ServerManager.isConnected();
  }
}
