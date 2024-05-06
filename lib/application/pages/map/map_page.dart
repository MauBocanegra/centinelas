import 'dart:async';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/core/strings.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/map/helpers/location_permission_status.dart';
import 'package:centinelas_app/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas_app/application/widgets/button_style.dart';
import 'package:centinelas_app/data/sealed_classes/incidence_request_type.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as custom_permission_handler;

class MapPageProvider extends StatefulWidget {
  final String raceIdString;
  final String raceRoute;
  final Map<dynamic, dynamic> racePoints;
  late LocationPermissionStatus locationPermissionStatus;
  MapPageProvider({
    super.key,
    required this.raceIdString,
    required this.raceRoute,
    required this.racePoints,
  });

  static const pageConfig = PageConfig(
      icon: Icons.map,
      name: mapRoute
  );

  @override
  State<MapPageProvider> createState() => MapPageState();
}

class MapPageState extends State<MapPageProvider> {

  Location location = Location();
  late List<LatLng> routeLatLng;
  late Map<String, LatLng> points;
  late LatLngBounds? latLngBounds;
  late CameraPosition raceCameraPosition;
  late List<Marker> markers;
  
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  late final Completer<GoogleMapController> googleMapController =
  Completer<GoogleMapController>();

  late final BlocProvider<RaceDetailButtonsBloc> raceDetailButtonsBloc;

  @override
  void initState(){
    super.initState();

      List<String> racesListString = widget.raceRoute.split(',');
      routeLatLng = racesListString.map(
              (raceString) {
            String treatedRaceString = raceString.startsWith(' ') ? raceString
                .substring(1) : raceString;
            return LatLng(
              double.parse(treatedRaceString.split(' ')[1]),
              double.parse(treatedRaceString.split(' ')[0]),
            );
          }
      ).toList();
      //latLngBounds = LatLngBounds.fromList(routeLatLng.toString());
      double mostNorthLat = routeLatLng.map((e) => e.latitude).reduce(max);
      double mostSouthLat = routeLatLng.map((e) => e.latitude).reduce(min);
      double mostWestLon = routeLatLng.map((e) => e.longitude).reduce(min);
      double mostEastLon = routeLatLng.map((e) => e.longitude).reduce(max);
      latLngBounds = LatLngBounds(
        southwest: LatLng(mostSouthLat, mostWestLon),
        northeast: LatLng(mostNorthLat, mostEastLon),
      );

    if(latLngBounds!=null){
      CameraUpdate.newLatLngBounds(latLngBounds!, 0);
    } else {
      raceCameraPosition = const CameraPosition(
        target: LatLng(19.423096795906307, -99.17567078650453),
        zoom: 17,
      );
    }

    markers = widget.racePoints.map((key, raceString) {
      String treatedRaceString = raceString.startsWith(' ') ? raceString.substring(1) : raceString;
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
        )
      );
    }).values.toList();

    checkAndRequestLocationPermissions();
    raceDetailButtonsBloc = BlocProvider<RaceDetailButtonsBloc>(
      create: (context) => serviceLocator<RaceDetailButtonsBloc>(),
      child: BlocConsumer<RaceDetailButtonsBloc, RaceDetailButtonsState>(
        listener: (context, state) async {
          if(state is RaceDetailButtonsLoadingState){
            await showModalActionSheet<String>(
                context: context,
              message: obtainingLocationString,
              isDismissible: false,
            );
          } else if(state is RaceDetailButtonsIncidenceWithSuccessState){
            //Pop loading modalActionSheet
            Navigator.pop(context, '');
            await showModalActionSheet<String>(
              context: context,
              message: incidenceReportedConfirmationText,
            );
          } else if (state is RaceDetailButtonsIncidenceWithErrorState) {
            //Pop loading modalActionSheet
            Navigator.pop(context, '');
            await showModalActionSheet<String>(
              context: context,
              message: incidenceReportedErrorText,
            );
          }
        },
        builder: (context, state){
            return Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        onTapIncidenceButton(
                            context,
                            SimpleIncidenceRequestType()
                        );
                      },
                      style: raisedBlueButtonStyle,
                      child: const Text(assistanceButtonText),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        onTapIncidenceButton(
                            context,
                            EmergencyIncidenceRequestType()
                        );
                      },
                      style: raisedRedButtonStyle,
                      child: const Wrap(
                        children: <Widget>[
                          Icon(Icons.warning_rounded,),
                          SizedBox(width:10,),
                          Text(emergencyButtonText),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  void checkAndRequestLocationPermissions() async {
    if(await custom_permission_handler.Permission.location.serviceStatus.isEnabled){
      // enabled
      var status = await custom_permission_handler.Permission.location.status;
      if(await custom_permission_handler.Permission.location.isPermanentlyDenied){
        widget.locationPermissionStatus = LocationPermissionPermanentlyDenied();
      }
      if(status.isGranted){
        // Location permission granted
        widget.locationPermissionStatus = LocationPermissionGranted();
      } else {
        // location permission not granted
        await [custom_permission_handler.Permission.location].request();
        var locationStatus = await custom_permission_handler.Permission.location.status;
        if(locationStatus.isGranted){
          widget.locationPermissionStatus = LocationPermissionGranted();
        } else {
          widget.locationPermissionStatus = LocationPermissionDenied();
        }
      }
    } else {
      // disabled
      widget.locationPermissionStatus = LocationPermissionDisabled();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapToolbarEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(
              19.423295657661217,
              -99.1763032731237
          )),
          onMapCreated: (GoogleMapController gMController){
            googleMapController.complete(gMController);
            moveCamera();
          },
          polylines: <Polyline>{
            Polyline(
              polylineId: const PolylineId('ruta'),
              points: routeLatLng,
              color: Colors.red,
              width: 3,
            )
          },
          markers: markers.toSet(),
        ),
        raceDetailButtonsBloc,
      ],
    );
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await googleMapController.future;
    if(latLngBounds!=null){
      await controller.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds!, 0));
    }
  }

  void onTapIncidenceButton(
      BuildContext context,
      IncidenceRequestType incidenceRequestType,
  ) async {
    String dialogHint = '';
    String dialogTitle = '';
    String dialogDescription = '';
    String dialogNoEmptyText = '';
    String firebaseEventIncidenceString = '';

    if(incidenceRequestType is SimpleIncidenceRequestType){
      dialogHint = assistanceDialogHint;
      dialogTitle = assistanceDialogTitle;
      dialogDescription = assistanceDialogDescription;
      dialogNoEmptyText = assistanceDialogNoEmptyText;
      firebaseEventIncidenceString = firebaseEventSendAssistanceIncidence;
    } else if (incidenceRequestType is EmergencyIncidenceRequestType){
      dialogHint = emergencyDialogHint;
      dialogTitle = emergencyDialogTitle;
      dialogDescription = emergencyDialogDescription;
      dialogNoEmptyText = emergencyDialogNoEmptyText;
      firebaseEventIncidenceString = firebaseEventSendEmergencyIncidence;
    }

    checkAndRequestLocationPermissions();

    switch(widget.locationPermissionStatus){
      case LocationPermissionDenied():{
        await showOkAlertDialog(
          context: context,
          message: locationDeniedDialogTitle,
          okLabel: locationErrorDialogOkButton
        );
      }

      case LocationPermissionDisabled():{
        await showOkAlertDialog(
          context: context,
          message: locationOffDialogTitle,
          okLabel: locationErrorDialogOkButton
        );
      }

      case LocationPermissionPermanentlyDenied():{
        await showOkAlertDialog(
          context: context,
          message: locationDeniedDialogTitle,
          okLabel: locationErrorDialogOkButton
        );
      }

      case _:{}
    }

    List<String>? inputText;
    if(context.mounted) {
      inputText = await showTextInputDialog(
        context: context,
        barrierDismissible: false,
        textFields: [
          DialogTextField(
            hintText: dialogHint,
            maxLines: 2,
          ),
        ],
        title: dialogTitle,
        message: dialogDescription,
      );
    }

    var inputedText = inputText?.first;
    if (inputedText != null && inputedText.length > minIncidenceLength) {
      bool locationDataAvailable = false;
      if(widget.locationPermissionStatus is LocationPermissionGranted) {
        locationDataAvailable = true;
        locationData = await location.getLocation();
      }
      double doubleFallback = 0.0;
      if(context.mounted) {
        serviceLocator<FirebaseAnalytics>().logEvent(
            name: firebaseEventIncidenceString
        );
        context.read<RaceDetailButtonsBloc>().writeIncidence({
          raceIdKeyForMapping: widget.raceIdString,
          incidenceTextKeyForMapping: inputedText,
          incidenceTypeKeyForMapping: incidenceRequestType,
          incidenceLatitudeKeyForMapping:
            locationDataAvailable ? locationData.latitude : doubleFallback,
          incidenceLongitudeKeyForMapping:
            locationDataAvailable ? locationData.longitude : doubleFallback,
        });
      }

      if(!locationDataAvailable){
        locationData = await location.getLocation();
      }
    } else if(inputedText != null && context.mounted){
      await showModalActionSheet<String>(
        context: context,
        message: dialogNoEmptyText,
      );
    }
  }
}
