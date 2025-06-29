import 'package:flutter/material.dart';

Widget bigText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 40,
      color: color,
      fontWeight: FontWeight.bold,
    ),
  );
}
