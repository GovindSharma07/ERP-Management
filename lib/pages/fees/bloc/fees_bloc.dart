import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erp_management/model/student_model.dart';
import 'package:meta/meta.dart';

part 'fees_event.dart';
part 'fees_state.dart';

class FeesBloc extends Bloc<FeesEvent, FeesState> {
  FeesBloc() : super(FeesInitial()) {
    on<FeesInitialEvent>(_feesInitialEvent);
   on<FeesStudentSelectedEvent>(_feesStudentSelectedEvent);
  }

  FutureOr<void> _feesStudentSelectedEvent(FeesStudentSelectedEvent event, Emitter<FeesState> emit) {
  emit(FeesStudentSelectedState(event.studentModel));
  }

  FutureOr<void> _feesInitialEvent(FeesInitialEvent event, Emitter<FeesState> emit) {
  emit(FeesInitial(name: event.name,rollNo: event.rollNo,course: event.course,section: event.section));
  }
}
