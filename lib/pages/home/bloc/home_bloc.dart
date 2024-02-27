import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NewUserEvent>(_newUserEvent);
    on<DoneEvent>(_DoneEvent);
  }

  FutureOr<void> _newUserEvent(NewUserEvent event, Emitter<HomeState> emit) {
    emit(NewUserState());
  }

  FutureOr<void> _DoneEvent(DoneEvent event, Emitter<HomeState> emit) {
    emit(DoneState());
  }
}
