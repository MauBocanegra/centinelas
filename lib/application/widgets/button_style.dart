import 'package:flutter/material.dart';

final ButtonStyle raisedBlueButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.blue,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle raisedOrangeButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.deepOrange,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle raisedRedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.red,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle raisedYellowButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.black,
  backgroundColor: Colors.yellow,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);