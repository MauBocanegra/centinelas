part of 'incidence_entry_item_bloc.dart';

abstract class IncidenceEntryItemState extends Equatable{
  const IncidenceEntryItemState();

  @override
  List<Object> get props => [];
}

class IncidenceEntryItemLoadingState extends IncidenceEntryItemState{
  const IncidenceEntryItemLoadingState();
}
class IncidenceEntryItemErrorState extends IncidenceEntryItemState{
  const IncidenceEntryItemErrorState();
}
class IncidenceEntryItemLoadedState extends IncidenceEntryItemState{
  const IncidenceEntryItemLoadedState({
    required this.incidenceModel,
  });
  final IncidenceModel incidenceModel;

  @override
  List<Object> get props => [incidenceModel];
}
