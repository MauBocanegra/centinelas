import 'dart:async';
import 'dart:math';

import 'package:centinelas_app/application/core/page_config.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/dispatch/bloc/dispatch_bloc.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/incidence_entry_item.dart';
import 'package:centinelas_app/application/pages/login/login_page.dart';
import 'package:centinelas_app/core/usecase.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:centinelas_app/domain/repositories/realtime_repository.dart';
import 'package:centinelas_app/domain/usecases/write_dispatcher_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DispatchPageProvider extends StatefulWidget {
  const DispatchPageProvider({
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

  late final BlocProvider<DispatchBloc> dispatchBloc;
  final StreamController<Iterable<IncidenceModel>> streamController =
    StreamController();

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
    streamController.addStream(incidenceModelStream.stream);
  }

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
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){
                  return IncidenceEntryItemProvider(
                      incidenceModel: snapshot.data!.elementAt(index)
                  );
                },
                key:  Key("${Random().nextDouble()}"),
            );
          }
        },),
    );
  }
}

