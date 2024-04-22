import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/core/routes_constants.dart';
import 'package:centinelas_app/application/core/strings.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/map/map_page.dart';
import 'package:centinelas_app/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas_app/application/widgets/button_style.dart';
import 'package:centinelas_app/data/sealed_classes/incidence_request_type.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// hay que limpiar este codigo :(
class RaceDetailsButtonsWidgetProvider extends StatefulWidget{
  RaceDetailsButtonsWidgetProvider({
    super.key,
    required this.raceFull,
  });

  final RaceFull raceFull;
  final String uid =
      serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';

  @override
  State<StatefulWidget> createState() => RaceDetailsButtonsWidget();
}

class RaceDetailsButtonsWidget extends State<RaceDetailsButtonsWidgetProvider>{

  final textEditingController = TextEditingController();
  late final BlocProvider<RaceDetailButtonsBloc> raceDetailButtonsBloc;
  String typedPhone = '';

  @override
  void initState(){
    super.initState();
    raceDetailButtonsBloc = BlocProvider<RaceDetailButtonsBloc>(
      create: (context) => serviceLocator<RaceDetailButtonsBloc>()
        ..determineButtonsState(widget.raceFull, widget.uid),
      child: BlocConsumer<RaceDetailButtonsBloc, RaceDetailButtonsState>(
          listener: (context, state) async {
            if(state is RaceDetailButtonsIncidenceWithSuccessState){
              final result = await showModalActionSheet<String>(
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
                style: raisedBlueButtonStyle,
                onPressed: () { context
                    .read<RaceDetailButtonsBloc>()
                    .registerForRace(widget.raceFull, widget.uid);
                },
                child: const Text(registerButtonText),
              );
            } else if (state is RaceDetailButtonsOnlyCheckInState){
              return ElevatedButton(
                style: raisedOrangeButtonStyle,
                onPressed: () { context
                    .read<RaceDetailButtonsBloc>()
                    .checkInRace(widget.raceFull, widget.uid);
                },
                child: const Text(checkInButtonText),
              );
            } else if (state is RaceDetailButtonsPhoneUpdateState){
              return Padding(
                padding: const EdgeInsets.fromLTRB(24.0,0.0,24.0,0.0),
                child: Center(
                    child:Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            hintText: hintPhone
                          ),
                          keyboardType: TextInputType.phone,
                          controller: textEditingController,
                        ),
                        ElevatedButton(
                          style: raisedOrangeButtonStyle,
                          onPressed: () { context
                              .read<RaceDetailButtonsBloc>()
                              .updatePhoneThenCheckIn(
                            widget.raceFull,
                            widget.uid,
                            typedPhone,
                          );
                          },
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
              return ElevatedButton(
                  onPressed: (){
                    context.goNamed(
                      MapPageProvider.pageConfig.name,
                      pathParameters: {raceFullIdParamKey : widget.raceFull.id.value},
                    );
                  },
                  child: const Text('Seguimiento de carrera'),
              );
              /*
              return Center(child: Column(children: [
                ElevatedButton(
                  style: raisedYellowButtonStyle,
                  onPressed: () { onTapAssistanceButton(context); },
                  child: const Text(assistanceButtonText),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  style: raisedRedButtonStyle,
                  onPressed: () { onTapEmergencyButton(context); },
                  child: const Text(emergencyButtonText),
                ),
              ],),);
              */
            } else {
              return const Center(
                child: Text(errorRaceDetailButtonsWidget),
              );
            }
          }
      ),
    );

    textEditingController.addListener(() {
      typedPhone = textEditingController.value.text;
      debugPrint(typedPhone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return raceDetailButtonsBloc;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void onTapAssistanceButton(BuildContext context) async {
    final inputText = await showTextInputDialog(
      context: context,
      textFields: [
        const DialogTextField(
          hintText: assistanceDialogHint,
          maxLines: 2,
        ),
      ],
      title: assistanceDialogTitle,
      message: assistanceDialogDescription,
    );
    if(context.mounted && inputText != null && inputText.isNotEmpty) {
      context.read<RaceDetailButtonsBloc>().writeIncidence({
        raceIdKeyForMapping : widget.raceFull.id.value,
        incidenceTextKeyForMapping : inputText.first,
        incidenceTypeKeyForMapping : SimpleIncidenceRequestType(),
      });
    }
  }

  void onTapEmergencyButton(BuildContext context) async {
    final inputText = await showTextInputDialog(
      context: context,
      textFields: [
        const DialogTextField(
          hintText: emergencyDialogHint,
          maxLines: 3,
        ),
      ],
      title: emergencyDialogTitle,
      message: emergencyDialogDescription,
    );
    if(context.mounted && inputText != null && inputText.isNotEmpty) {
      context.read<RaceDetailButtonsBloc>().writeIncidence({
        raceIdKeyForMapping : widget.raceFull.id.value,
        incidenceTextKeyForMapping : inputText.first,
        incidenceTypeKeyForMapping : EmergencyIncidenceRequestType(),
      });
    }
  }
}