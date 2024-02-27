import 'package:flutter/material.dart';

class ToDoColor {
  final int colorIndex;
  static const List<Color> predefinedColors = [
    Colors.red,
    Colors.blueGrey,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.teal,
    Colors.purple,
    Colors.orange,
  ];
  Color get color => predefinedColors[colorIndex];

  ToDoColor({required this.colorIndex});
}
