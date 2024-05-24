import 'package:centinelas_app/application/pages/users_list/widgets/view_states/users_list_item_report_view_loaded.dart';
import 'package:flutter/material.dart';

class UsersListLoadedView extends StatefulWidget {
  final List<String> usersList;
  late List<bool> isExpanded;
  UsersListLoadedView({
    super.key,
    required this.usersList,
  });

  @override
  State<UsersListLoadedView> createState() => UsersListLoadedViewState();
}

class UsersListLoadedViewState extends State<UsersListLoadedView> {

  @override
  void initState() {
    super.initState();
    widget.isExpanded = widget.usersList.map((e) => false).toList();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: ExpansionPanelList(
      expansionCallback: (index, isExpanded){
        setState(() {
          widget.isExpanded[index] = isExpanded;
        });
      },
      children: widget.usersList.asMap().entries.map((eachEmail) => ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(eachEmail.value),
            );
          },
          body: widget.isExpanded[eachEmail.key] ? UsersListItemReportViewLoaded(
            uid: widget.usersList[eachEmail.key]
          ) : Container(),
          isExpanded: widget.isExpanded[eachEmail.key],
      )).toList(),
    ));
  }
}
