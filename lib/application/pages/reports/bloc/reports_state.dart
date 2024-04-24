part of 'reports_bloc.dart';

abstract class ReportsState extends Equatable{
  const ReportsState();
  @override List<Object?> get props => [];
}

class ReportsLoadingState extends ReportsState {
  const ReportsLoadingState();
}
class ReportsErrorState extends ReportsState {
  const ReportsErrorState();
}
class ReportsLoadedState extends ReportsState {
  const ReportsLoadedState({
    required this.reportsList
  });
  final List<ReportModel> reportsList;
  @override List<Object?> get props => [reportsList];
}