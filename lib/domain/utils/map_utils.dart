import 'dart:math';

import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/strings.dart';
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
              infoWindow: InfoWindow(title: getMarkerTitle(key)),
              icon: getMarkerColor(key),
            )
        );
      }).values.toList();
    } else {
      markers = [];
    }
  }

  String getMarkerTitle(String markerKey) {
    String title = switch (markerKey) {
      hidrationPointKey => hidrationPointTitle,
      exitPointKey => exitPointTitle,
      finishPointKey => finishPointTitle,
      medicPointKey => medicPointTitle,
      km1PointKey => km1PointTitle,
      km2PointKey => km2PointTitle,
      km3PointKey => km3PointTitle,
      km4PointKey => km4PointTitle,
      km5PointKey => km5PointTitle,
      km6PointKey => km6PointTitle,
      km7PointKey => km7PointTitle,
      km8PointKey => km8PointTitle,
      km9PointKey => km9PointTitle,
      km10PointKey => km10PointTitle,
      km11PointKey => km11PointTitle,
      km12PointKey => km12PointTitle,
      km13PointKey => km13PointTitle,
      km14PointKey => km14PointTitle,
      km15PointKey => km15PointTitle,
      km16PointKey => km16PointTitle,
      km17PointKey => km17PointTitle,
      km18PointKey => km18PointTitle,
      km19PointKey => km19PointTitle,
      km20PointKey => km20PointTitle,
      km21PointKey => km21PointTitle,
      km22PointKey => km22PointTitle,
      km23PointKey => km23PointTitle,
      km24PointKey => km24PointTitle,
      km25PointKey => km25PointTitle,
      km26PointKey => km26PointTitle,
      km27PointKey => km27PointTitle,
      km28PointKey => km28PointTitle,
      km29PointKey => km29PointTitle,
      km30PointKey => km30PointTitle,
      km31PointKey => km31PointTitle,
      km32PointKey => km32PointTitle,
      km33PointKey => km33PointTitle,
      km34PointKey => km34PointTitle,
      km35PointKey => km35PointTitle,
      km36PointKey => km36PointTitle,
      km37PointKey => km37PointTitle,
      km38PointKey => km38PointTitle,
      km39PointKey => km39PointTitle,
      km40PointKey => km40PointTitle,
      km41PointKey => km41PointTitle,
      km42PointKey => km42PointTitle,
      String() => '',
    };
    return title;
  }

  BitmapDescriptor getMarkerColor(String markerKey){
    double color = switch (markerKey){
      hidrationPointKey => BitmapDescriptor.hueAzure,
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
      km1PointKey => BitmapDescriptor.hueRose,
      km2PointKey => BitmapDescriptor.hueRose,
      km3PointKey => BitmapDescriptor.hueRose,
      km4PointKey => BitmapDescriptor.hueRose,
      km5PointKey => BitmapDescriptor.hueRose,
      km6PointKey => BitmapDescriptor.hueRose,
      km7PointKey => BitmapDescriptor.hueRose,
      km8PointKey => BitmapDescriptor.hueRose,
      km9PointKey => BitmapDescriptor.hueRose,
      km10PointKey => BitmapDescriptor.hueRose,
      km11PointKey => BitmapDescriptor.hueRose,
      km12PointKey => BitmapDescriptor.hueRose,
      km13PointKey => BitmapDescriptor.hueRose,
      km14PointKey => BitmapDescriptor.hueRose,
      km15PointKey => BitmapDescriptor.hueRose,
      km16PointKey => BitmapDescriptor.hueRose,
      km17PointKey => BitmapDescriptor.hueRose,
      km18PointKey => BitmapDescriptor.hueRose,
      km19PointKey => BitmapDescriptor.hueRose,
      km20PointKey => BitmapDescriptor.hueRose,
      km21PointKey => BitmapDescriptor.hueRose,
      km22PointKey => BitmapDescriptor.hueRose,
      km23PointKey => BitmapDescriptor.hueRose,
      km24PointKey => BitmapDescriptor.hueRose,
      km25PointKey => BitmapDescriptor.hueRose,
      km26PointKey => BitmapDescriptor.hueRose,
      km27PointKey => BitmapDescriptor.hueRose,
      km28PointKey => BitmapDescriptor.hueRose,
      km29PointKey => BitmapDescriptor.hueRose,
      km30PointKey => BitmapDescriptor.hueRose,
      km31PointKey => BitmapDescriptor.hueRose,
      km32PointKey => BitmapDescriptor.hueRose,
      km33PointKey => BitmapDescriptor.hueRose,
      km34PointKey => BitmapDescriptor.hueRose,
      km35PointKey => BitmapDescriptor.hueRose,
      km36PointKey => BitmapDescriptor.hueRose,
      km37PointKey => BitmapDescriptor.hueRose,
      km38PointKey => BitmapDescriptor.hueRose,
      km39PointKey => BitmapDescriptor.hueRose,
      km40PointKey => BitmapDescriptor.hueRose,
      km41PointKey => BitmapDescriptor.hueRose,
      km42PointKey => BitmapDescriptor.hueRose,
      String() => BitmapDescriptor.hueRed,
    };
    return BitmapDescriptor.defaultMarkerWithHue(color);
  }

}