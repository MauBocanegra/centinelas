import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:centinelas/application/core/constants.dart';
import 'package:centinelas/application/core/strings.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/map/map_page.dart';
import 'package:centinelas/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas/application/utils/color_utils.dart';
import 'package:centinelas/application/widgets/button_style.dart';
import 'package:centinelas/domain/entities/race_full.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RaceDetailsButtonsWidgetProvider extends StatefulWidget{
  const RaceDetailsButtonsWidgetProvider({
    super.key,
    required this.raceFull,
  });

  final RaceFull raceFull;

  @override
  State<StatefulWidget> createState() => RaceDetailsButtonsWidget();
}

class RaceDetailsButtonsWidget extends State<RaceDetailsButtonsWidgetProvider>{

  final textEditingController = TextEditingController();
  String typedPhone = '';
  bool isPhoneCompleted = false;
  String? get errorPhoneText {
    final text = textEditingController.value.text;
    if (text.length < 10) {
      return errorPhone;
    }
    return null;
  }

  @override
  void initState(){
    super.initState();

    textEditingController.addListener(() {
      typedPhone = textEditingController.value.text;
      if(typedPhone.length == 10){
        setState(() {
          isPhoneCompleted = true;
        });
      }else{
        setState(() {
          isPhoneCompleted = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceDetailButtonsBloc>(
      create: (context) => serviceLocator<RaceDetailButtonsBloc>()
        ..determineButtonsState(widget.raceFull),
      child: BlocConsumer<RaceDetailButtonsBloc, RaceDetailButtonsState>(
          listener: (context, state) async {
            if(state is RaceDetailButtonsIncidenceWithSuccessState){
              await showModalActionSheet<String>(
                context: context,
                message: incidenceReportedConfirmationText,
              );
            } else if (state is RaceDetailButtonsIncidenceWithErrorState) {
              final result = await showModalActionSheet<String>(
                context: context,
                message: incidenceReportedErrorText,
              );
              debugPrint(result.toString());
            }
          },
          builder: (context, state){
            if(state is RaceDetailButtonsLoadingState){
              return const Center(child: CircularProgressIndicator());
            } else if(state is RaceDetailButtonsOnlyRegisterState){
              return ElevatedButton(
                style: registerButtonStyle,
                onPressed: () {
                  serviceLocator<FirebaseAnalytics>().logEvent(
                      name: firebaseEventRegister
                  );
                  context
                    .read<RaceDetailButtonsBloc>()
                    .registerForRace(widget.raceFull);
                },
                child: const Text(registerButtonText),
              );
            } else if (state is RaceDetailButtonsOnlyCheckInState){
              return ElevatedButton(
                style: checkInButtonStyle,
                onPressed: () {
                  serviceLocator<FirebaseAnalytics>().logEvent(
                      name: firebaseEventCheckin
                  );
                  context
                    .read<RaceDetailButtonsBloc>()
                    .checkInRace(widget.raceFull);
                },
                child: const Text(checkInButtonText),
              );
            } else if (state is RaceDetailButtonsPhoneUpdateState){
              return Padding(
                padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
                child: Center(
                    child:Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: stringPhoneTitle,
                              hintText: hintPhone,
                              errorText: errorPhoneText,
                            ),
                            keyboardType: TextInputType.phone,
                            controller: textEditingController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ]
                        ),
                        const SizedBox(height: 8,),
                        ElevatedButton(
                          style: checkInButtonStyle,
                          onPressed: isPhoneCompleted ? (){updatePhoneAndCheckin(context);} : null,
                          child: const Text(phoneAndCheckInButtonText),
                        )
                      ],
                    )
                ),
              );
            } else if(state is RaceDetailButtonsCheckedInNotActiveState){
              return const Center(
                child: Text(
                  checkedInNotActiveRaceText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              );
            }else if (
            state is RaceDetailButtonsIncidenceState ||
                state is RaceDetailButtonsIncidenceWithSuccessState ||
                state is RaceDetailButtonsIncidenceWithErrorState
            ){
              return InkWell(
                onTap: (){
                  serviceLocator<FirebaseAnalytics>().logEvent(
                      name: firebaseEventGoToMap
                  );
                  String? raceRoute = widget.raceFull.raceRoute;
                  raceRoute = raceRoute.isNotEmpty ? raceRoute : noRouteConst;
                  Map<dynamic, dynamic> racePointsMap = widget.raceFull.racePoints;
                  context.goNamed(
                    MapPageProvider.pageConfig.name,
                    pathParameters: {
                      raceFullIdParamKey : widget.raceFull.id.value,
                      raceRouteParamKey: raceRoute,
                      racePointsParamKey: json.encode(racePointsMap),
                    }
                    ,
                  );
                },
                child: Material(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(8.0)
                  ),
                  color: greenColorCentinelas,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.directions_run,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          SizedBox(
                            width:10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            mapButtonText,
                            style: TextStyle(
                              color: Colors.white,
                              height: 1,
                            ),
                          )
                        ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(errorRaceDetailButtonsWidget),
              );
            }
          }
      ),
    );
  }

  void updatePhoneAndCheckin(BuildContext buildContext){
    serviceLocator<FirebaseAnalytics>().logEvent(
        name: firebaseEventCheckinAfterPhone
    );
    buildContext.read<RaceDetailButtonsBloc>().updatePhoneThenCheckIn(
      widget.raceFull,
      typedPhone,
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}