import 'dart:async';
import 'dart:math';

import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/dispatch/bloc/dispatch_bloc.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/incidence_entry_item.dart';
import 'package:centinelas_app/application/pages/login/login_page.dart';
import 'package:centinelas_app/application/pages/map/helpers/location_permission_status.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/data/mappers/iterable_datasnapshot_to_iterable_marker_maps.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:centinelas_app/domain/usecases/write_dispatcher_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as CustomPermissionHandler;

class DispatchPageProvider extends StatefulWidget {
  late LocationPermissionStatus locationPermissionStatus;

  DispatchPageProvider({
    super.key,
    required this.activeRaceId,
  });

  static const pageConfig = PageConfig(
      icon: Icons.broadcast_on_home_outlined,
      name: dispatchRoute,
  );

  final String activeRaceId;

  @override
  State<DispatchPageProvider> createState() => DispatchPageProviderState();
}

class DispatchPageProviderState extends State<DispatchPageProvider> {

  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  late final Completer<GoogleMapController> googleMapController =
  Completer<GoogleMapController>();

  late final BlocProvider<DispatchBloc> dispatchBloc;
  final StreamController<Iterable<IncidenceModel>> streamController =
    StreamController();

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

    checkNotifsPermissions();

    debugPrint('raceId: ${widget.activeRaceId}');
    final realtimeRepository =
      serviceLocator<RealtimeRepository>();
    final incidenceModelStream = realtimeRepository.getIncidenceModelStream();
    initGoogleMap();
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

  GoogleMap reCreateGoogleMap(Iterable<Marker> markers){
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: estelaLuzCameraPosition,
      onMapCreated: (GoogleMapController gMController){
        googleMapController.complete(gMController);
      },
      markers: markers.toSet(),
    );
  }

  void checkAndRequestLocationPermissions() async {
    if(await CustomPermissionHandler.Permission.location.serviceStatus.isEnabled){
      // enabled
      var status = await CustomPermissionHandler.Permission.location.status;
      if(await CustomPermissionHandler.Permission.location.isPermanentlyDenied){
        widget.locationPermissionStatus = LocationPermissionPermanentlyDenied();
      }
      if(status.isGranted){
        // Location permission granted
        widget.locationPermissionStatus = LocationPermissionGranted();
      } else {
        // location permission not granted
        Map<
            CustomPermissionHandler.Permission,
            CustomPermissionHandler.PermissionStatus
        > requestStatus = await [CustomPermissionHandler.Permission.location].request();
        var locationStatus = await CustomPermissionHandler.Permission.location.status;
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
          debugPrint('error inSessionPage ${e.toString()}');
        }
      } else {
        debugPrint('shouldGoToLogin');
        context.go('/${LoginPage.pageConfig.name}');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidencias'),
      ),
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
                  child: Card(
                    elevation: 6,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index){
                          return IncidenceEntryItemProvider(
                              incidenceModel: snapshot.data!.elementAt(index)
                          );
                        },
                        key:  Key("${Random().nextDouble()}"),
                    ),
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

