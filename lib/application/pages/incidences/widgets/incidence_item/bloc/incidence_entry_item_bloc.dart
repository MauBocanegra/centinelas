import 'package:centinelas/application/di/injection.dart';
import 'package:centinelas/data/models/incidence_model.dart';
import 'package:centinelas/domain/usecases/load_custom_user_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'incidence_entry_item_event.dart';
part 'incidence_entry_item_state.dart';

class IncidenceEntryItemBloc extends
  Bloc<IncidenceEntryItemEvent, IncidenceEntryItemState> {

  IncidenceEntryItemBloc({
    required this.loadCustomUserDataUseCase
  }) : super (const IncidenceEntryItemLoadingState());

  final LoadCustomUserDataUseCase loadCustomUserDataUseCase;

  Future<void> readFullIncidenceItem(IncidenceModel incidenceModel) async {
    try{
      final customUserDataResult =
        await loadCustomUserDataUseCase.call(incidenceModel.centinelId);
      return customUserDataResult.fold(
              (customUserData) {
                incidenceModel.phoneNumber = customUserData.phone;
                emit(IncidenceEntryItemLoadedState(incidenceModel: incidenceModel));
              },
              (right) => emit(const IncidenceEntryItemErrorState()),
      );
    } on Exception catch(exception){
      serviceLocator<FirebaseCrashlytics>().recordError(exception, null);
      debugPrint('incidenceEntryItemError: ${exception.toString()}');
      emit(const IncidenceEntryItemErrorState());
    }
  }

}