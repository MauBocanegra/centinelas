import 'package:centinelas/application/core/constants.dart';
import 'package:flutter/material.dart';

Color redColorCentinelas = const Color.fromRGBO(211, 47, 47, 1);
Color pinkColorCentinelas = const Color.fromRGBO(247, 213, 212, 1);
Color greenColorCentinelas = const Color.fromRGBO(163, 214, 191, 1);

Color mapColorFromIncidenceType(String type){
  if(type == incidenceEmergencyTypeForMapping){
    return redColorCentinelas;
  } else if(type == incidenceAssistanceTypeForMapping){
    return greenColorCentinelas;
  } else {
    return Colors.white;
  }
}