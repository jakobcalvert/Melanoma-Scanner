import 'package:flutter/material.dart';
import 'styles.dart';
import '../controllers/image_controller.dart';
import '../controllers/server_controller.dart';

class HomeView extends StatelessWidget {
  final ImageController controller = ImageController();
  final ServerController svrController = ServerController();

  HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Melanoma Scanner',
              style: AppStyles.titleStyle.copyWith(
                fontSize: 32.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Scan a patch of skin for a diagnosis on you phone',
              style: AppStyles.subtitleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () { controller.imagePicker(context); },
              child: Text(
                'Scan a Image',
                style: AppStyles.buttonTextStyle,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: svrController.serverStatus()
                  ? () {
                svrController.viewSavedResults(context);
              }
                  : null,
              child: Text(
                'Previous Scans',
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
