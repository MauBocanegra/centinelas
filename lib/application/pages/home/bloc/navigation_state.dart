part of 'navigation_cubit.dart';

class NavigationCubitState extends Equatable{
  final RaceEntryId? selectedRaceId;
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyDisplayed;

  const NavigationCubitState({
    this.isSecondBodyDisplayed,
    this.selectedRaceId,
    this.selectedCollectionId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isSecondBodyDisplayed,
    selectedRaceId,
    selectedCollectionId
  ];
}