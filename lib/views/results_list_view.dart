import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'styles.dart';
import '../controllers/image_controller.dart';
import 'styles.dart';

class ResultsListView extends StatelessWidget {
  final ImageController controller = ImageController();
  final List<Uint8List> images;
  final List<Color> colors;
  final List<String> messages;

  ResultsListView({
    required this.images,
    required this.colors,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Results', style: AppStyles.titleStyle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: MemoryImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        messages[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colors[index],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () {
                controller.returnHome(context);
              },
              child: Text('Return Home', style: AppStyles.buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
