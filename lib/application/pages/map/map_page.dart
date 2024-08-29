import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/core/strings.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/home/home_page.dart';
import 'package:centinelas/application/pages/map/helpers/location_permission_status.dart';
import 'package:centinelas/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas/application/utils/color_utils.dart';
import 'package:centinelas/data/sealed_classes/incidence_request_type.dart';
import 'package:centinelas/domain/utils/map_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;
  late RaceRouteAndPoints raceRouteAndPoints;

  CameraPosition reformaCameraPosition = const CameraPosition(
      target: LatLng(
          19.423295657661217,
          -99.1763032731237
      ),
      zoom: 17
  );

  late final Completer<GoogleMapController> googleMapController =
  Completer<GoogleMapController>();

  late final BlocProvider<RaceDetailButtonsBloc> raceDetailButtonsBloc;

  @override
  void initState(){
    super.initState();

    debugPrint('raceRoute[${widget.raceRoute}] racePoints[${widget.racePoints}]');
    raceRouteAndPoints = RaceRouteAndPoints(
        widget.raceRoute,
        widget.racePoints
    );

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
            return Stack(
              children: [
                //locationDisclaimerWidget(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 32.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                  onPressed: (){
                                    onTapIncidenceButton(
                                        context,
                                        SimpleIncidenceRequestType()
                                    );
                                  },
                                  style: elevatedButtonStyleWithColor(greenColorCentinelas),
                                  child: buttonContent(Icons.healing, assistanceButtonText),
                                )
                              ),
                              const SizedBox(height: 16,),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      onTapIncidenceButton(
                                          context,
                                          EmergencyIncidenceRequestType()
                                      );
                                    },
                                    style: elevatedButtonStyleWithColor(redColorCentinelas),
                                    child: buttonContent(Icons.warning_rounded, emergencyButtonText),
                                  )
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                ),
              ],
            );
          }
      ),
    );
  }

  ButtonStyle elevatedButtonStyleWithColor(Color color){
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0))
      ),
      elevation: 8.0,
    );
  }

  Widget buttonContent(IconData icon, String text){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8,),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget locationDisclaimerWidget(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.25,
                  child: Material(
                      color: Colors.white.withAlpha(200),
                      elevation: 8,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          locationDisclaimer,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      )
                  )
              );
            }
        ),
      ),
    );
  }
  */

  void checkAndRequestLocationPermissions() async {
    //if(await custom_permission_handler.Permission.location.serviceStatus.isEnabled){
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
        await showOkAlertDialog(
            context: context,
            message: locationDisclaimer,
            okLabel: locationOkButton
        );
        //checkAndRequestLocationPermissions();
        await [
          custom_permission_handler.Permission.location,
        ].request();
        var locationStatus = await custom_permission_handler.Permission.location.status;
        if(locationStatus.isGranted){
          widget.locationPermissionStatus = LocationPermissionGranted();
        } else {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          try {
            IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
            debugPrint('Running on ${iosInfo.utsname.machine}');

            if(iosInfo!=null){
              var permissionStatus = await location.hasPermission();
              if(permissionStatus == PermissionStatus.granted){
                widget.locationPermissionStatus = LocationPermissionGranted();
              } else {}
            }
          }catch(exception){
            widget.locationPermissionStatus = LocationPermissionDenied();
          }
        }
      }
    //} else {
      // disabled
      //widget.locationPermissionStatus = LocationPermissionDisabled();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/header_mapa.png',
          fit: BoxFit.contain,
          height: 32,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if(context.canPop()){
              context.pop();
            } else {
              context.goNamed(
                HomePage.pageConfig.name,
              );
            }
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: reformaCameraPosition,
            onMapCreated: (GoogleMapController gMController){
              googleMapController.complete(gMController);
              moveCamera();
            },
            polylines: <Polyline>{
              Polyline(
                polylineId: const PolylineId('ruta'),
                points: raceRouteAndPoints.routeLatLng!,
                color: redColorCentinelas,
                width: 3,
              )
            },
            markers: raceRouteAndPoints.markers!.toSet(),
            //markers: markers.toSet(),
          ),
          raceDetailButtonsBloc,
        ],
      ),
    );
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await googleMapController.future;
    if(raceRouteAndPoints.latLngBounds!=null){
      await controller.animateCamera(
          CameraUpdate.newLatLngBounds(
              raceRouteAndPoints.latLngBounds!, 0
          )
      );
    } else {
      await controller.animateCamera(
          CameraUpdate.newCameraPosition(reformaCameraPosition)
      );
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
