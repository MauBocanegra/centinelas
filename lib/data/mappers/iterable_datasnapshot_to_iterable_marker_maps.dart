import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/strings.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:firebase_database/firebase_database.dart';
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
        )
      )
  );
  return iterableMarker;
}
