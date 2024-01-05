import 'package:flutter/material.dart';

class RaceColor {
  final int colorIndex;

  static const List<Color> predifinedColors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
  ];

  Color get color => predifinedColors[colorIndex];

  RaceColor({
    required this.colorIndex
  });
}