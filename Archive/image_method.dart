import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../lib/controllers/image_controller.dart';

class ImageMethod extends StatelessWidget {

  final ImageController controller;

  ImageMethod({required this.controller,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Image Source'),
      content: Text('Choose to take a new photo or select from the gallery.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            controller.handleImageSelection(ImageSource.camera, context);
          },
          child: Text('Camera'),
        ),
        TextButton(
          onPressed: () {
            controller.handleImageSelection(ImageSource.gallery, context);
          },
          child: Text('Gallery'),
        ),
        TextButton(
          onPressed: () {
            controller.cancel(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
