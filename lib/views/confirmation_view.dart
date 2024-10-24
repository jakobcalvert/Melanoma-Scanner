import 'package:flutter/material.dart';
import 'styles.dart';
import 'dart:io';
import '../controllers/image_controller.dart';

class ConfirmationView extends StatelessWidget {
  final ImageController controller = ImageController();
  final File image;

  ConfirmationView({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Image', style: AppStyles.titleStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Do you want to proceed with this image?',
              textAlign: TextAlign.center,
              style: AppStyles.subtitleStyle,
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: FileImage(image),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: AppStyles.elevatedButtonStyle,
                  onPressed: () => controller.returnHome(context),
                  child: Text('Return Home', style: AppStyles.buttonTextStyle),
                ),
                ElevatedButton(
                  style: AppStyles.elevatedButtonStyle,
                  onPressed: () => controller.confirmImage(context),
                  child: Text('Confirm', style: AppStyles.buttonTextStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
