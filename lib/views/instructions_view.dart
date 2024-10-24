import 'package:flutter/material.dart';
import '../controllers/image_controller.dart';
import 'styles.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerView extends StatelessWidget {
  final ImageController controller = ImageController();

  ImagePickerView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions', style: AppStyles.titleStyle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/example.png',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Please capture or select an image that follows the example above.\n\n'
                    'The image needs to be:\n'
                    '- Clear and well-lit\n'
                    '- Clearly show suspicious region centered in the image\n'
                    '- Only containing skin in the image',
                textAlign: TextAlign.center,
                style: AppStyles.bodyTextStyle,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.handleImageSelection(ImageSource.camera, context),
                    style: AppStyles.elevatedButtonStyle,
                    child: Text('Camera', style: AppStyles.buttonTextStyle),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.handleImageSelection(ImageSource.gallery, context),
                    style: AppStyles.elevatedButtonStyle,
                    child: Text('Gallery', style: AppStyles.buttonTextStyle),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
