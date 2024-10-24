import 'package:flutter/material.dart';
import 'dart:io';
import '../controllers/image_controller.dart';
import 'styles.dart';

class ResultsView extends StatelessWidget {
  final ImageController controller;
  final String message;
  final Color mesColor;
  final File image;

  ResultsView({required this.controller, required this.message, required this.mesColor, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results', style: AppStyles.titleStyle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mesColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: AppStyles.elevatedButtonStyle,
                    onPressed: () {
                      controller.returnHome(context);
                    },
                    child: Text('Return to Home', style: AppStyles.buttonTextStyle),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: AppStyles.elevatedButtonStyle,
                    onPressed: controller.serverStatus()
                        ? () {
                      controller.saveResults(context);
                    }
                        : null,
                    child: Text('Save Result', style: AppStyles.buttonTextStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
