import 'package:centinelas_app/application/utils/color_utils.dart';
import 'package:flutter/material.dart';

final ButtonStyle registerButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: redColorCentinelas,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle checkInButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: redColorCentinelas,
  backgroundColor: pinkColorCentinelas,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle goToMapButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: greenColorCentinelas,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

final ButtonStyle signOutButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: redColorCentinelas,
  backgroundColor: pinkColorCentinelas,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  elevation: 8.0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);