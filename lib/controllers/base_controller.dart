
import 'package:flutter/material.dart';
import '/views/home_view.dart';

class BaseController {

void cancel(BuildContext context) {
  Navigator.pop(context);
}
Future<void> returnHome(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomeView(),
    ),
  );
}
}