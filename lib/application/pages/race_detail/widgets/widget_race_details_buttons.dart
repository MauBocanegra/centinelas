import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/race_detail/widgets/bloc/buttons_bloc/race_detail_buttons_bloc.dart';
import 'package:centinelas_app/application/widgets/button_style.dart';
import 'package:centinelas_app/domain/entities/race_full.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RaceDetailsButtonsWidgetProvider extends StatelessWidget{
  RaceDetailsButtonsWidgetProvider({
    super.key,
    required this.raceFull,
  });

  final RaceFull raceFull;
  final String uid =
      serviceLocator<FirebaseAuth>().currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceDetailButtonsBloc>(
      create: (context) => serviceLocator<RaceDetailButtonsBloc>()
        ..determineButtonsState(raceFull, uid),
      child: const RaceDetailsButtonsWidget(),
    );
  }
}

class RaceDetailsButtonsWidget extends StatelessWidget{
  const RaceDetailsButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RaceDetailButtonsBloc, RaceDetailButtonsState>(
      listener: (context, state){

      },
      builder: (context, state){
        if(state is RaceDetailButtonsLoadingState){
          return const Center(child: CircularProgressIndicator());
        } else if(state is RaceDetailButtonsOnlyRegisterState){
          return ElevatedButton(
            style: raisedBlueButtonStyle,
            onPressed: () { context
              .read<RaceDetailButtonsBloc>()
              .registerForRace(state.raceFull.id.value, state.uid);
            },
            child: const Text('Registrarse'),
          );
        } else if (state is RaceDetailButtonsOnlyCheckInState){
          return ElevatedButton(
            style: raisedOrangeButtonStyle,
            onPressed: () { },
            child: const Text('CheckIn'),
          );
        } else if (state is RaceDetailButtonsState){
          return Container();
        } else {
          return const Center(
            child: Text(
                'Ocurrio un error, intenta nuevamente mas tarde'
            ),
          );
        }
      }
    );
  }


}