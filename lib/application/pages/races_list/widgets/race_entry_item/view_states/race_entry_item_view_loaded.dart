import 'package:centinelas_app/application/pages/home/bloc/navigation_cubit.dart';
import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RaceEntryItemViewLoaded extends StatelessWidget {
  const RaceEntryItemViewLoaded({
    super.key,
    required this.raceEntry,
    required this.collectionId,
  });

  final RaceEntry raceEntry;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      buildWhen: (previous, current) =>
      previous.selectedRaceId != current.selectedRaceId,
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
                    image: NetworkImage(raceEntry.imageUrl ?? ''),
                    fit: BoxFit.cover),
              ),
              child: ListTile(
                title: Text(
                  raceEntry.description.split('-').first,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(raceEntry.description),
                leading: const Icon(Icons.directions_run_rounded),
                selected: state.selectedRaceId == raceEntry.id,
                onTap: (){
                  debugPrint('onTap race:${raceEntry.id.value} collection:${collectionId.value}');
                  context.read<NavigationCubit>().selectedRaceChanged(raceEntry.id);
                  if(Breakpoints.small.isActive(context)){
                    context.pushNamed(
                      RaceDetailPage.pageConfig.name,
                      pathParameters: {
                        'raceEntryId': raceEntry.id.value.toString(),
                        'collectionId': collectionId.value.toString()
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
