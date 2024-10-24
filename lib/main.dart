import 'package:flutter/material.dart';
import 'package:fluttertest/models/server.dart';
import 'views/home_view.dart';
import 'models/modelManager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // loads the model at launch
  await ModelManager.loadModel();
  await ServerManager.connectToMongoDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      title: 'Melanoma Scanner',
      home: HomeView(),
    );
  }
}

