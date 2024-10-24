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
        builder: (context) => HomeView(),
      ),
    );
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
        builder: (context) => ResultsView( message: confidenceMessage, mesColor: confidenceColor, image: _getImage()),
      ),
    );
  }

  void imagePicker(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePickerView(),
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
          builder: (context) => ConfirmationView( image: _getImage()),
        ),
      );
    }
  }

}
