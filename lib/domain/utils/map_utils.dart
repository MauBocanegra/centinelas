import 'dart:math';

import 'package:centinelas_app/application/core/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RaceRouteAndPoints{

  List<LatLng>? routeLatLng;
  LatLngBounds? latLngBounds;
  CameraPosition? raceCameraPosition;
  List<Marker>? markers;

  RaceRouteAndPoints(String? routeString, Map<dynamic, dynamic> racePoints){
    if(routeString!=noRouteConst) {
      List<String> racesListString = routeString!.split(',');
      routeLatLng = racesListString.map((raceString) {
            String treatedRaceString = raceString.startsWith(' ') ? raceString
                .substring(1) : raceString;
            return LatLng(
              double.parse(treatedRaceString.split(' ')[1]),
              double.parse(treatedRaceString.split(' ')[0]),
            );
          }
      ).toList();
      double mostNorthLat = routeLatLng!.map((e) => e.latitude).reduce(max);
      double mostSouthLat = routeLatLng!.map((e) => e.latitude).reduce(min);
      double mostWestLon = routeLatLng!.map((e) => e.longitude).reduce(min);
      double mostEastLon = routeLatLng!.map((e) => e.longitude).reduce(max);
      latLngBounds = LatLngBounds(
        southwest: LatLng(mostSouthLat, mostWestLon),
        northeast: LatLng(mostNorthLat, mostEastLon),
      );
    }else{
      routeLatLng = [];
      latLngBounds = null;
    }

    if(latLngBounds!=null){
      CameraUpdate.newLatLngBounds(latLngBounds!, 0);
    } else {
      raceCameraPosition = const CameraPosition(
        target: LatLng(19.423096795906307, -99.17567078650453),
        zoom: 17,
      );
    }

    if(racePoints.isNotEmpty) {
      markers = racePoints.map((key, raceString) {
        String treatedRaceString = raceString.startsWith(' ') ? raceString
            .substring(1) : raceString;
        LatLng latLng = LatLng(
          double.parse(treatedRaceString.split(' ')[1]),
          double.parse(treatedRaceString.split(' ')[0]),
        );
        return MapEntry(
            key,
            Marker(
              markerId: MarkerId('${latLng.latitude}${latLng.longitude}'),
              position: LatLng(latLng.latitude, latLng.longitude),
              infoWindow: InfoWindow(title: key),
              icon: getMarkerColor(key),
            )
        );
      }).values.toList();
    } else {
      markers = [];
    }
  }

  BitmapDescriptor getMarkerColor(String markerKey){
    double color = switch (markerKey){
      exitPointKey => BitmapDescriptor.hueOrange,
      finishPointKey => BitmapDescriptor.hueOrange,
      kmPointKey => BitmapDescriptor.hueRose,
      medicPointKey => BitmapDescriptor.hueRed,
      redPoint => BitmapDescriptor.hueRed,
      rosePoint => BitmapDescriptor.hueRose,
      orangePoint => BitmapDescriptor.hueOrange,
      azurePoint => BitmapDescriptor.hueAzure,
      greenPoint => BitmapDescriptor.hueGreen,
      bluePoint => BitmapDescriptor.hueBlue,
      cyanPoint => BitmapDescriptor.hueCyan,
      magentaPoint => BitmapDescriptor.hueMagenta,
      violetPoint => BitmapDescriptor.hueViolet,
      yellowPoint => BitmapDescriptor.hueYellow,
      String() => BitmapDescriptor.hueRed,
    };
    return BitmapDescriptor.defaultMarkerWithHue(color);
  }

}