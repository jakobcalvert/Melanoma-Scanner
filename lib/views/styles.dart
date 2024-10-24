import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Colors.black;
  static const Color accentColor = Colors.white;

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16.0,
    color: accentColor,
  );

  static const TextStyle dialogTitleStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle dialogContentStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  static const TextStyle dialogButtonTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    textStyle: buttonTextStyle,
    foregroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
