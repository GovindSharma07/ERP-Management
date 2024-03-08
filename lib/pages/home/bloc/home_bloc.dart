import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NewUserEvent>(_newUserEvent);
    on<FeesEvent>(_feesEvent);
    on<DoneEvent>(_doneEvent);
  }

  FutureOr<void> _newUserEvent(NewUserEvent event, Emitter<HomeState> emit) {
    emit(NewUserState());
  }

  FutureOr<void> _doneEvent(DoneEvent event, Emitter<HomeState> emit) {
    emit(DoneState());
  }


  FutureOr<void> _feesEvent(FeesEvent event, Emitter<HomeState> emit) {
    emit(FeesState());
  }
}
