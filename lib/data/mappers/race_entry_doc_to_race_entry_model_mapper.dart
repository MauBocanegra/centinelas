import 'package:centinelas_app/data/models/race_entry_model.dart';
import 'package:flutter/cupertino.dart';

/// This mapper will have to add a mechanism to dynamically
/// display whatever is stored in the race entry document
RaceEntryModel mapRaceEntryDocToRaceEntryModel(Map<String, dynamic> map){
  return RaceEntryModel(
      raceEntryId: map['id'],
      title: map['titulo'],
      shortDescription: map['descripcionCorta'],
      imageUrl: map['linkImagen'],
  );
}