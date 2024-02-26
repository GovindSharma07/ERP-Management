import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NewUserEvent>(_newUserEvent);
  }

  FutureOr<void> _newUserEvent(NewUserEvent event, Emitter<HomeState> emit) {
    emit(NewUserState());
  }
}

