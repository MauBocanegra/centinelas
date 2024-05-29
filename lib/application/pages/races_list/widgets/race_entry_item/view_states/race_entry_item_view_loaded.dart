import 'package:centinelas_app/application/core/constants.dart';
import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RaceEntryItemViewLoaded extends StatelessWidget {
  const RaceEntryItemViewLoaded({
    super.key,
    required this.raceEntry,
  });

  final RaceEntry raceEntry;

  Future<String> getImageUrl(String path) async {
    final reference = serviceLocator<FirebaseStorage>().ref().child(path);
    final url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      buildWhen: (previous, current) =>
      previous.selectedRaceId != current.selectedRaceId,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 0, 8),
          child: Material(
            clipBehavior: Clip.hardEdge,
            elevation: 8.0,
            shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(0.0),
            )),
            child: Column(
              children: <Widget>[
                /*
                ListTile(
                  title: Text(
                    raceEntry.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(raceEntry.description),
                  leading: const Icon(Icons.directions_run_rounded),
                  selected: state.selectedRaceId == raceEntry.id,
                  onTap: (){
                    debugPrint('onTap race:${raceEntry.id.value}');
                    serviceLocator<FirebaseAnalytics>().logEvent(
                        name: firebaseEventGoToRace
                    );
                    context.read<NavigationCubit>().selectedRaceChanged(raceEntry.id);
                    if(Breakpoints.small.isActive(context)){
                      debugPrint('small: ${raceEntry.id.value}');
                      context.pushNamed(
                        RaceDetailPage.pageConfig.name,
                        pathParameters: {
                          'raceEntryId': raceEntry.id.value.toString(),
                        },
                      );
                    }else {}
                  },
                ),
                */
                InkWell(
                  onTapUp: (details) async {
                    debugPrint('onTap race:${raceEntry.id.value}');
                    serviceLocator<FirebaseAnalytics>().logEvent(
                        name: firebaseEventGoToRace
                    );
                    context.read<NavigationCubit>().selectedRaceChanged(raceEntry.id);
                    if(Breakpoints.small.isActive(context)){
                      debugPrint('small: ${raceEntry.id.value}');
                      Future.delayed(const Duration(milliseconds: 300),(){
                        context.pushNamed(
                          RaceDetailPage.pageConfig.name,
                          pathParameters: {
                            'raceEntryId': raceEntry.id.value.toString(),
                          },
                        );
                      });
                    }else {}
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                            child: Image(
                              image: NetworkImage(raceEntry.imageUrl ?? ''),
                              width: double.infinity,
                            ),
                          )
                      ),
                      Expanded(
                        flex: 10,
                          child: Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.asset(
                                    'assets/race_item_background_no_shadow.png',
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          raceEntry.dayString,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          '${raceEntry.dateString}\n${raceEntry.hourString}',
                                          style: const TextStyle(
                                              height: 0,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
