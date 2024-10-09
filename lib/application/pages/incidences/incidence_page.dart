import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/login/login_page.dart';
import 'package:centinelas/application/pages/map/helpers/location_permission_status.dart';
import 'package:centinelas/application/utils/color_utils.dart';
import 'package:centinelas/core/usecase.dart';
import 'package:centinelas/data/mappers/iterable_datasnapshot_to_iterable_marker_maps.dart';
import 'package:centinelas/data/models/incidence_model.dart';
import 'package:centinelas/domain/repositories/realtime_repository.dart';
import 'package:centinelas/domain/usecases/write_dispatcher_usecase.dart';
import 'package:centinelas/domain/utils/map_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as custom_permission_handler;

import 'widgets/incidence_item/incidence_entry_item.dart';

class IncidencesPageProvider extends StatefulWidget {
  late LocationPermissionStatus locationPermissionStatus;
  final String raceId;
  final String route;
  final String points;
  IncidencesPageProvider({
    super.key,
    required this.raceId,
    required this.route,
    required this.points,
  });

  static const pageConfig = PageConfig(
      icon: Icons.volume_up_sharp,
      name: incidencesRoute,
  );

  @override
  State<IncidencesPageProvider> createState() => IncidencesPageProviderState();
}

class IncidencesPageProviderState extends State<IncidencesPageProvider> {

  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;
  late RaceRouteAndPoints raceRouteAndPoints;

  late final Completer<GoogleMapController> googleMapController =
  Completer<GoogleMapController>();

  final StreamController<Iterable<IncidenceModel>> streamController =
    StreamController();
  final ScrollController scrollController = ScrollController();

  late GoogleMap googleMap;

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint('message received: ${message.toString()}');
  }

  @override
  void initState(){
    super.initState();
    try{
      raceRouteAndPoints = RaceRouteAndPoints(
          widget.route,
          json.decode(widget.points),
      );
    } catch(exception){
      debugPrint('errorDecodingMapRouteAndPoints: ${exception.toString()}');
    }
    checkNotifsPermissions();

    //debugPrint('raceId: ${widget.activeRaceId}');
    final realtimeRepository =
      serviceLocator<RealtimeRepository>();
    final incidenceModelStream =
      realtimeRepository.getIncidenceModelStream(widget.raceId);
    googleMap = reCreateGoogleMap([]);
    streamController.addStream(incidenceModelStream.stream);
  }

  void initGoogleMap(){
    googleMap = GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: estelaLuzCameraPosition,
      onMapCreated: (GoogleMapController gMController){
        googleMapController.complete(gMController);
      },
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
          CameraUpdate.newCameraPosition(estelaLuzCameraPosition)
      );
    }
  }

  GoogleMap reCreateGoogleMap(Iterable<Marker> markers){
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: estelaLuzCameraPosition,
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
      markers: {...markers.toSet(), ...raceRouteAndPoints.markers!.toSet()},
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

  static const CameraPosition estelaLuzCameraPosition =
  CameraPosition(
    target: LatLng(19.423096795906307, -99.17567078650453),
    zoom: 15,
  );

  void checkNotifsPermissions() async {
    NotificationSettings settings =
    await serviceLocator<FirebaseMessaging>().requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if(serviceLocator<FirebaseAuth>().currentUser != null){
        try{
          final writeDispatcherUseCase =
              serviceLocator<WriteDispatcherUseCase>();
          final dispatcherWasWritten =
              await writeDispatcherUseCase.call(NoParams());
          if(dispatcherWasWritten.isRight){
            throw Exception('Unable to write dispatcher in RTDB');
          }
        }on Exception catch(e){
          serviceLocator<FirebaseCrashlytics>().recordError(e, null);
          debugPrint('error inSessionPage ${e.toString()}');
        }
      } else {
        debugPrint('shouldGoToLogin');
        context.go('/${LoginPageProvider.pageConfig.name}');
      }
    });

    return Scaffold(
      body: StreamBuilder<Iterable<IncidenceModel>>(
        stream: streamController.stream,
        builder: (
            BuildContext context,
            AsyncSnapshot<Iterable<IncidenceModel>> snapshot
        ){
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }else{
            debugPrint('incidences: ${snapshot.data.toString()}');
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index){
                      return IncidenceEntryItemProvider(
                          incidenceModel: snapshot.data!.elementAt(index)
                      );
                    },
                    key:  Key("${Random().nextDouble()}"),
                  ),
                ),
                Expanded(
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: reCreateGoogleMap(
                          mapIterableDataSnapshotToIterableGoogleMapsMarker(
                              snapshot.data!
                          )
                      ),
                    )
                ),
              ],
            );
          }
        },),
    );
  }
}

