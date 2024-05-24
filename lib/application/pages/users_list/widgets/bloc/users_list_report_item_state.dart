part of 'users_list_report_item_bloc.dart';

abstract class UsersListReportItemState extends Equatable{
  const UsersListReportItemState();
  @override List<Object?> get props => [];
}

class UsersListReportItemLoadingState extends UsersListReportItemState {}
class UsersListReportItemLoadedState extends UsersListReportItemState {
  const UsersListReportItemLoadedState({
    required this.reportsList
  });
  final List<ReportModel> reportsList;
  @override List<Object?> get props => [reportsList];
}
class UsersListReportItemErrorState extends UsersListReportItemState {}