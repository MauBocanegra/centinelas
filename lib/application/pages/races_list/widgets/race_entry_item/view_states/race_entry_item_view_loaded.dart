import 'package:centinelas_app/application/pages/race_detail/race_detail_page.dart';
import 'package:centinelas_app/domain/entities/race_entry.dart';
import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(raceEntry.id.value),
          subtitle: Text(raceEntry.description),
          leading: const Icon(Icons.directions_run_rounded),
          onTap: (){
            debugPrint('onTap Race');
            if(Breakpoints.small.isActive(context)){
              debugPrint('small.isActive onTap Race');

              context.pushNamed(
                RaceDetailPage.pageConfig.name,
                pathParameters: {
                  'raceEntryId': raceEntry.id.value.toString(),
                  'collectionId': collectionId.value.toString()
                },
              );

              //context.goNamed('${RaceDetailPage.pageConfig.name}/raceEntryId=${raceEntry.id.value.toString()}');
            }
          },
        ),
      ),
    );
  }
}
