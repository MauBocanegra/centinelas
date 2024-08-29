import 'package:centinelas/application/core/page_config.dart';
import 'package:centinelas/application/core/routes_constants.dart';
import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/application/pages/users_list/bloc/users_list_bloc.dart';
import 'package:centinelas/application/pages/users_list/view_states/races_list_view_error.dart';
import 'package:centinelas/application/pages/users_list/view_states/races_list_view_loading.dart';
import 'package:centinelas/application/pages/users_list/view_states/users_list_view_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.supervised_user_circle_rounded,
    name: usersListPage,
  );

  @override
  State<UsersListPage> createState() => UsersListPageState();
}

class UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersListBloc>(
        create: (context) => serviceLocator<UsersListBloc>()
            ..loadUsersList(),
        child: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state){
            if(state is UsersListLoadingState){
              return const UsersListLoadingView();
            } else if(state is UsersListLoadedState){
              return UsersListLoadedView(
                  usersList: state.usersList
              );
            } else {
              return const RacesListViewError();
            }
          },
        )
    );
  }
}
