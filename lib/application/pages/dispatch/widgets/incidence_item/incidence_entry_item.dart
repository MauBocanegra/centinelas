import 'package:centinelas_app/application/di/injection.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/bloc/incidence_entry_item_bloc.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/view_states/incidence_entry_item_view_error.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/view_states/incidence_entry_item_view_loaded.dart';
import 'package:centinelas_app/application/pages/dispatch/widgets/incidence_item/view_states/incidence_entry_item_view_loading.dart';
import 'package:centinelas_app/data/models/incidence_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncidenceEntryItemProvider extends StatelessWidget {
  const IncidenceEntryItemProvider({
    super.key,
    required this.incidenceModel,
  });

  final IncidenceModel incidenceModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncidenceEntryItemBloc>(
        create: (context) => serviceLocator<IncidenceEntryItemBloc>()
          ..readFullIncidenceItem(incidenceModel),
        child: const IncidenceEntryItem(),
    );
  }
}
class IncidenceEntryItem extends StatelessWidget {
  const IncidenceEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncidenceEntryItemBloc, IncidenceEntryItemState>(
        builder: (context, state){
          if(state is IncidenceEntryItemLoadingState){
            return const IncidenceEntryItemViewLoading();
          } else if(state is IncidenceEntryItemLoadedState){
            return IncidenceEntryItemViewLoaded(
              incidenceModel: state.incidenceModel,
            );
          } else {
            return const IncidenceEntryItemViewError();
          }
        }
    );
  }
}

