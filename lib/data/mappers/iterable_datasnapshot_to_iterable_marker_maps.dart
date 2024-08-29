import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/core/strings.dart';
import 'package:centinelas/data/models/incidence_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Iterable<Marker> mapIterableDataSnapshotToIterableGoogleMapsMarker(
    Iterable<IncidenceModel> iterableIncidenceModel
){
  Iterable<Marker> iterableMarker = iterableIncidenceModel.map(
      (incidenceModel) => Marker(
        markerId: MarkerId(incidenceModel.time),
        position: LatLng(incidenceModel.lat, incidenceModel.lon),
        infoWindow: InfoWindow(
          title: incidenceModel.type == incidenceEmergencyTypeForMapping
              ? emergencyDialogTitle : assistanceDialogTitle,
          snippet: incidenceModel.text,
        ),
        icon: getMarkerColorByIncidenceType(incidenceModel.type),
      )
  );
  return iterableMarker;
}

BitmapDescriptor getMarkerColorByIncidenceType(String incidenceType){
  double color;
  if(incidenceType == incidenceEmergencyTypeForMapping){
    color = BitmapDescriptor.hueRed;
  } else if (incidenceType == incidenceAssistanceTypeForMapping){
    color = BitmapDescriptor.hueGreen;
  } else {
    color = BitmapDescriptor.hueRed;
  }
  return BitmapDescriptor.defaultMarkerWithHue(color);
}
