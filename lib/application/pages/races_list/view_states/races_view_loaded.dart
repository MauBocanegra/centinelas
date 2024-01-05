import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/race_collection.dart';
import '../../race_detail/race_detail_page.dart';

class RacesViewLoaded extends StatelessWidget {
  const RacesViewLoaded({
    super.key,
    required this.collections
  });

  final List<RaceCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context).colorScheme;
          return ListTile(
            tileColor: colorScheme.surface,
            selectedTileColor: colorScheme.surfaceVariant,
            iconColor: item.color.color,
            selectedColor: item.color.color,
            onTap: (){
              debugPrint('tapped ${item.title}');
              if(Breakpoints.small.isActive(context)){
                context.pushNamed(
                  RaceDetailPage.pageConfig.name,
                  pathParameters: {'collectionId': item.id.value},
                );
              }
            },
            leading: const Icon(Icons.circle),
            title: Text(item.title),
          );
      }
    );
  }
}
