import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dispatch_events.dart';
part 'dispatch_states.dart';

class DispatchBloc extends Bloc<DispatchEvent, DispatchState> {
  DispatchBloc() : super (const DispatchLoadingState());


}